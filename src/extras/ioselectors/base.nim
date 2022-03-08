#                        Nim's Runtime Library
#                (c) Copyright 2016 Eugene Kabanov


#                        IO selectors
#                (c) Copyright 2020 Zeshen Xing



import os, nativesockets

const hasThreadSupport* = compileOption("threads") and defined(threadsafe)


when hasThreadSupport:
    type
        SharedArray*[T] = UncheckedArray[T]

    proc allocSharedArray*[T](nsize: int): ptr SharedArray[T] =
        result = cast[ptr SharedArray[T]](allocShared0(sizeof(T) * nsize))

    proc reallocSharedArray*[T](sa: ptr SharedArray[T], nsize: int): ptr SharedArray[T] =
        result = cast[ptr SharedArray[T]](reallocShared(sa, sizeof(T) * nsize))

    proc deallocSharedArray*[T](sa: ptr SharedArray[T]) =
        deallocShared(cast[pointer](sa))

type
    Event* {.pure.} = enum
        Read, Write, Timer, Signal, Process, Vnode, User, Error, Oneshot,
        Finished, VnodeWrite, VnodeDelete, VnodeExtend, VnodeAttrib, VnodeLink,
        VnodeRename, VnodeRevoke

type
    IOSelectorsException* = object of CatchableError

    ReadyKey* = object
        fd* : int
        events*: set[Event]
        errorCode*: OSErrorCode

    SelectorKey*[T] = object
        ident*: int
        events*: set[Event]
        param*: int
        data*: T

const
    InvalidIdent* = -1

proc raiseIOSelectorsError*[T](message: T) =
    var msg = ""
    when T is string:
        msg.add(message)
    elif T is OSErrorCode:
        msg.add(osErrorMsg(message) & " (code: " & $int(message) & ")")
    else:
        msg.add("Internal Error\n")
    var err = newException(IOSelectorsException, msg)
    raise err

proc setNonBlocking*(fd: cint) {.inline.} =
    setBlocking(fd.SocketHandle, false)

proc verifySelectParams*(timeout: int) =
    # Timeout of -1 means: wait forever
    # Anything higher is the time to wait in milliseconds.
    doAssert(timeout >= -1, "Cannot select with a negative value, got " & $timeout)