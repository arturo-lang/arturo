#                        Nim's Runtime Library
#                (c) Copyright 2016 Eugene Kabanov


#                        IO selectors
#                (c) Copyright 2020 Zeshen Xing


import os, winlean
import nativesockets

import strutils
import base

import extras/wepoll
export wepoll


const 
    MAX_EPOLL_EVENTS = 64
    numFD = 1024            # Start with a reasonable size, checkFd() will grow this on demand.


when hasThreadSupport:
    type
        SelectorImpl[T] = object
            epollFD: EpollHandle
            maxFD: int
            numFD: int
            fds*: ptr SharedArray[SelectorKey[T]]
            count: int
        Selector*[T] = ptr SelectorImpl[T]
else:
    type
        SelectorImpl[T] = object
            epollFD: EpollHandle
            numFD: int
            fds*: seq[SelectorKey[T]]
            count: int
        Selector*[T] = ref SelectorImpl[T]

type
    SelectEventImpl = object
        rsock: SocketHandle
        wsock: SocketHandle
    SelectEvent* = ptr SelectEventImpl

proc newSelector*[T](): Selector[T] =
    var epollFD = epoll_create1(0)

    if epollFD == nil:
        raiseOSError(osLastError())

    when hasThreadSupport:
        result = cast[Selector[T]](allocShared0(sizeof(SelectorImpl[T])))
        result.epollFD = epollFD
        result.numFD = numFD
        result.fds = allocSharedArray[SelectorKey[T]](numFD)
    else:
        result = Selector[T]()
        result.epollFD = epollFD
        result.numFD = numFD
        result.fds = newSeq[SelectorKey[T]](numFD)

    for i in 0 ..< numFD:
        result.fds[i].ident = InvalidIdent

proc close*[T](s: Selector[T]) =
    let res = epoll_close(s.epollFD)
    when hasThreadSupport:
        deallocSharedArray(s.fds)
        deallocShared(cast[pointer](s))
    
    if res != 0:
        raiseIOSelectorsError(osLastError())

proc newSelectEvent*(): SelectEvent =
    var ssock = createNativeSocket()
    var wsock = createNativeSocket()
    var rsock: SocketHandle = INVALID_SOCKET
    var saddr = Sockaddr_in()

    saddr.sin_family = winlean.AF_INET
    saddr.sin_port = 0
    saddr.sin_addr.s_addr = INADDR_ANY
    if bindAddr(ssock, cast[ptr SockAddr](addr(saddr)),
                            sizeof(saddr).SockLen) < 0'i32:
        raiseIOSelectorsError(osLastError())

    if winlean.listen(ssock, 1) != 0:
        raiseIOSelectorsError(osLastError())

    var namelen = sizeof(saddr).SockLen
    if getsockname(ssock, cast[ptr SockAddr](addr(saddr)),
                                    addr(namelen)) != 0'i32:
        raiseIOSelectorsError(osLastError())

    saddr.sin_addr.s_addr = 0x0100007F
    if winlean.connect(wsock, cast[ptr SockAddr](addr(saddr)),
                                            sizeof(saddr).SockLen) != 0:
        raiseIOSelectorsError(osLastError())
    namelen = sizeof(saddr).SockLen
    rsock = winlean.accept(ssock, cast[ptr SockAddr](addr(saddr)),
                                                    cast[ptr SockLen](addr(namelen)))
    if rsock == SocketHandle(-1):
        raiseIOSelectorsError(osLastError())

    if winlean.closesocket(ssock) != 0:
        raiseIOSelectorsError(osLastError())

    var mode = clong(1)
    if ioctlsocket(rsock, FIONBIO, addr(mode)) != 0:
        raiseIOSelectorsError(osLastError())
    mode = clong(1)
    if ioctlsocket(wsock, FIONBIO, addr(mode)) != 0:
        raiseIOSelectorsError(osLastError())

    result = cast[SelectEvent](allocShared0(sizeof(SelectEventImpl)))
    result.rsock = rsock
    result.wsock = wsock

proc trigger*(ev: SelectEvent) =
    var data: uint64 = 1
    if winlean.send(ev.wsock, cast[pointer](addr data),
                                    cint(sizeof(uint64)), 0) != sizeof(uint64):
        raiseIOSelectorsError(osLastError())

proc close*(ev: SelectEvent) =
    let res1 = winlean.closesocket(ev.rsock)
    let res2 = winlean.closesocket(ev.wsock)
    deallocShared(cast[pointer](ev))
    if res1 != 0 or res2 != 0:
        raiseIOSelectorsError(osLastError())

template setKey(s, pident, pevents, pparam, pdata: untyped) =
    var skey = addr(s.fds[pident])
    skey.ident = pident
    skey.events = pevents
    skey.param = pparam
    skey.data = pdata

template clearKey[T](key: ptr SelectorKey[T]) =
    var empty: T
    key.ident = InvalidIdent
    key.events = {}
    key.data = empty

func changeFd*(s: SocketHandle|int): int {.inline.} =
    result = s.int shr 2

func restoreFd*(s: SocketHandle|int): int {.inline.} =
    result = s.int shl 2

proc registerHandle*[T](s: Selector[T], socket: SocketHandle, events: set[Event], data: T) =
    let fd = socket.changeFd
    s.checkFd(fd)
    doAssert(s.fds[fd].ident == InvalidIdent, "Descriptor $# already registered" % $fd)
    s.setKey(fd, events, 0, data)
    if events != {}:
        var epv = EpollEvent(events: EPOLLRDHUP.uint32)
        epv.data.u64 = fd.uint64
        if Event.Read in events: epv.events = epv.events or EPOLLIN.uint32
        if Event.Write in events: epv.events = epv.events or EPOLLOUT.uint32
        if epoll_ctl(s.epollFD, EPOLL_CTL_ADD, EpollSocket(socket), addr epv) != 0:
            raiseIOSelectorsError(osLastError())
        inc(s.count)

proc registerEvent*[T](s: Selector[T], ev: SelectEvent, data: T) =
    s.setKey(ev.rsock, {Event.User}, 0, data)
    var epv = EpollEvent(events: EPOLLIN or EPOLLRDHUP)
    epv.data.u64 = ev.rsock.uint64
    if epoll_ctl(s.epollFD, EPOLL_CTL_ADD, ev.rsock, addr epv) != 0:
        raiseIOSelectorsError(osLastError())
    inc(s.count)

proc updateHandle*[T](s: Selector[T], socket: int|SocketHandle, events: set[Event]) =
    let maskEvents = {Event.Timer, Event.Signal, Event.Process, Event.Vnode,
                                        Event.User, Event.Oneshot, Event.Error}

    let fd = socket.changeFd
    s.checkFd(fd)
    var pkey = addr(s.fds[fd])
    doAssert(pkey.ident != InvalidIdent,
                     "Descriptor $# is not registered in the selector!" % $fd)
    doAssert(pkey.events * maskEvents == {})
    if pkey.events != events:
        var epv = EpollEvent(events: EPOLLRDHUP.uint32)
        epv.data.u64 = fd.uint64

        if Event.Read in events: epv.events = epv.events or EPOLLIN.uint32
        if Event.Write in events: epv.events = epv.events or EPOLLOUT.uint32

        if pkey.events == {}:
            if epoll_ctl(s.epollFD, EPOLL_CTL_ADD, EpollSocket(socket), addr epv) != 0:
                raiseIOSelectorsError(osLastError())
            inc(s.count)
        else:
            if events != {}:
                if epoll_ctl(s.epollFD, EPOLL_CTL_MOD, EpollSocket(socket), addr epv) != 0:
                    raiseIOSelectorsError(osLastError())
            else:
                if epoll_ctl(s.epollFD, EPOLL_CTL_DEL, EpollSocket(socket), addr epv) != 0:
                    raiseIOSelectorsError(osLastError())
                dec(s.count)
        pkey.events = events

proc unregister*[T](s: Selector[T], socket: int|SocketHandle) =
    let fd = socket.changeFd
    s.checkFd(fd)
    var pkey = addr(s.fds[fd])
    doAssert(pkey.ident != InvalidIdent,
                     "Descriptor $# is not registered in the selector!" % $fd)
    if pkey.events != {}:
        if Event.Read in pkey.events or Event.Write in pkey.events or Event.User in pkey.events:
            var epv = EpollEvent()
            if epoll_ctl(s.epollFD, EPOLL_CTL_DEL, EpollSocket(socket), addr epv) != 0:
                raiseIOSelectorsError(osLastError())
            dec(s.count)

    clearKey(pkey)

template checkFd*(s, f) =
    if f >= s.numFD:
        var numFD = s.numFD
        while numFD <= f: 
            numFD = numFD shl 1
        when hasThreadSupport:
            s.fds = reallocSharedArray(s.fds, numFD)
        else:
            s.fds.setLen(numFD)
        for i in s.numFD ..< numFD:
            s.fds[i].ident = InvalidIdent
        s.numFD = numFD

proc selectInto*[T](s: Selector[T], timeout: int,
                                        results: var openArray[ReadyKey]): int =

    var
        resTable: array[MAX_EPOLL_EVENTS, EpollEvent]
        maxres = MAX_EPOLL_EVENTS

    let length = len(results)
    if maxres > length:
        maxres = length

    # verifySelectParams(timeout)

    let count = epoll_wait(s.epollFD, addr(resTable[0]), maxres.cint,
                                                 timeout.cint)


    if count < 0:
        raiseIOSelectorsError(osLastError())
    elif count == 0:
        result = 0
    else:
        var idx = 0
        var k = 0
        while idx < count:
            let fd = resTable[idx].data.u64.int
            let pevents = resTable[idx].events
            let fevents = s.fds[fd].events
            var rkey = ReadyKey(fd: fd.restoreFd, events: {})

            if (pevents and EPOLLOUT.uint32) != 0:
                rkey.events.incl(Event.Write)

            if (pevents and EPOLLIN.uint32) != 0:
                if Event.Read in fevents:
                    rkey.events.incl(Event.Read)

            results[k] = rkey
            inc idx
            inc k
        result = count

proc select*[T](s: Selector[T], timeout: int): seq[ReadyKey] {.inline.} =
    result = newSeq[ReadyKey](MAX_EPOLL_EVENTS)
    let count = selectInto(s, timeout, result)
    result.setLen(count)

template isEmpty*[T](s: Selector[T]): bool =
    (s.count == 0)

template internalContains[T](s: Selector[T], fd: int): bool =
    s.fds[fd].ident != InvalidIdent

func contains*[T](s: Selector[T], fd: SocketHandle|int): bool {.inline.} =
    result = internalContains(s, fd.changeFd)

proc getData*[T](s: Selector[T], fd: SocketHandle|int): var T {.inline.} =
    let fdi = fd.changeFd
    s.checkFd(fdi)
    if s.internalContains(fdi):
        result = s.fds[fdi].data

proc setData*[T](s: Selector[T], fd: SocketHandle|int, data: T): bool =
    let fdi = fd.changeFd
    s.checkFd(fdi)
    if s.internalContains(fdi):
        s.fds[fdi].data = data
        result = true

func getFd*[T](s: Selector[T]): EpollHandle =
    result = s.epollFd