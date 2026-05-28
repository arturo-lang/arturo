#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2026 Yanis Zafirópulos
#
# @file: vm/values/custom/vsocket.nim
#=======================================================

## The internal `:socket` type

when not defined(WEB):
    #=======================================
    # Libraries
    #=======================================

    import asyncnet, hashes, nativesockets, net

    #=======================================
    # Types
    #=======================================

    type
        VSocket* = ref object
            socket*: AsyncSocket
            address*: string
            protocol*: Protocol
            port*: int

    #=======================================
    # Constants
    #=======================================

    #=======================================
    # Overloads
    #=======================================

    proc hash*(a: VSocket): Hash {.inline.} =
        result = 1
        result = result !& hash(a.address)
        result = result !& hash(a.protocol)
        result = result !& hash(a.port)
        result = !$ result

    func `$`*(b: VSocket): string   =
        if b.protocol == IPPROTO_TCP:
            result = "tcp://"
        else:
            result = "udp://"

        if b.address == "0.0.0.0" or b.address == "127.0.0.1":
            result &= "localhost"
        else:
            result &= b.address

        result &= ":" & $b.port

    #=======================================
    # Methods
    #=======================================

    proc initSocket*(sock: AsyncSocket, proto: Protocol, address: string, port: Port): VSocket {.inline.} =
        result = VSocket(
            socket: sock,
            address: address,
            protocol: proto,
            port: int(port)
        )
