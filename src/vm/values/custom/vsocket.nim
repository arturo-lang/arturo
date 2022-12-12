#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: vm/values/custom/vsocket.nim
#=======================================================

## The internal `:socket` type

when not defined(WEB):
    #=======================================
    # Libraries
    #=======================================

    import hashes, net

    #=======================================
    # Types
    #=======================================

    type 
        SocketProtocol* = enum
            TCP, UDP

        VSocket* = ref object
            socket*: Socket
            address*: string
            protocol*: SocketProtocol
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

    func `$`*(b: VSocket): string  {.enforceNoRaises.} =
        if b.protocol == TCP:
            result = "tcp://"
        else:
            result = "udp://"

        result &= b.address & ":" & $b.port

    #=======================================
    # Methods
    #=======================================

    proc initSocket*(sock: Socket): VSocket {.inline.} =
        result = VSocket(
            socket: sock,
            address: "",
            protocol: TCP,
            port: 0
        )