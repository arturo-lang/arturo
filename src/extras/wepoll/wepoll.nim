##
##  wepoll - epoll for Windows
##  https://github.com/piscisaureus/wepoll
##
##  Copyright 2012-2020, Bert Belder <bertbelder@gmail.com>
##  All rights reserved.
##
##  Redistribution and use in source and binary forms, with or without
##  modification, are permitted provided that the following conditions are
##  met:
##
##    * Redistributions of source code must retain the above copyright
##      notice, this list of conditions and the following disclaimer.
##
##    * Redistributions in binary form must reproduce the above copyright
##      notice, this list of conditions and the following disclaimer in the
##      documentation and/or other materials provided with the distribution.
##
##  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
##  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
##  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
##  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
##  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
##  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
##  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
##  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
##  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
##  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##


import os


{.compile: "wepoll.c".}

const header_file = currentSourcePath().splitPath.head / "wepoll.h"

{.pragma: wepoll, header: header_file.}
# when not defined(WEBVIEW_NOEDGE):
#   {.passL: "wsock32.lib".}
# else:
{.passL: "-lws2_32".}


type
  EPOLL_EVENTS* = enum
    EPOLLIN = (int)(1 shl 0), EPOLLPRI = (int)(1 shl 1), EPOLLOUT = (int)(1 shl 2),
    EPOLLERR = (int)(1 shl 3), EPOLLHUP = (int)(1 shl 4), EPOLLRDNORM = (int)(1 shl 6),
    EPOLLRDBAND = (int)(1 shl 7), EPOLLWRNORM = (int)(1 shl 8),
    EPOLLWRBAND = (int)(1 shl 9), EPOLLMSG = (int)(1 shl 10), ##  Never reported.
    EPOLLRDHUP = (int)(1 shl 13), EPOLLONESHOT = (int)(1 shl 31)


const
  EPOLL_CTL_ADD* = 1
  EPOLL_CTL_MOD* = 2
  EPOLL_CTL_DEL* = 3


type
  EpollHandle* = pointer

  EpollSocket* = culonglong

  EpollData* {.bycopy, union.} = object
    p*: pointer
    fd*: cint
    u32*: uint32
    u64*: uint64
    sock*: EpollSocket         ##  Windows specific
    hnd*: EpollHandle          ##  Windows specific

  EpollEvent* {.wepoll, importc:"struct epoll_event".} = object
    events*: uint32          ##  Epoll events and flags
    data*: EpollData         ##  User data variable


proc epoll_create*(size: cint): EpollHandle {.wepoll.}

proc epoll_create1*(flags: cint): EpollHandle {.wepoll.}

proc epoll_close*(ephnd: EpollHandle): cint {.wepoll.}

proc epoll_ctl*(ephnd: EpollHandle, op: cint, 
                sock: EpollSocket, event: ptr EpollEvent): cint {.wepoll.}

proc epoll_wait*(ephnd: EpollHandle, events: ptr EpollEvent, 
                 maxevents: cint, timeout: cint): cint {.wepoll.}