#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2024 Yanis Zafirópulos
#
# @file: vm/values/custom/verror.nim
#=======================================================

#=======================================
# Libraries
#=======================================

import std/strformat

#=======================================
# Types
#=======================================

type        
    VErrorKind* = ref object
        parent*         : VErrorKind
        label*          : string
        description*    : string

    VError* = ref object of CatchableError
        kind*       : VErrorKind
        hint*       : string

#=======================================
# Constants
#=======================================

const
    EPERM*           =   int(1)      ## Operation not permitted
    ENOENT*          =   int(2)      ## No such file or directory
    ESRCH*           =   int(3)      ## No such process
    EINTR*           =   int(4)      ## Interrupted system call
    EIO*             =   int(5)      ## I/O error
    ENXIO*           =   int(6)      ## No such device or address
    E2BIG*           =   int(7)      ## Argument list too long
    ENOEXEC*         =   int(8)      ## Exec format error
    EBADF*           =   int(9)      ## Bad file number
    ECHILD*          =   int(10)     ## No child processes
    EAGAIN*          =   int(11)     ## Try again
    ENOMEM*          =   int(12)     ## Out of memory
    EACCES*          =   int(13)     ## Permission denied
    EFAULT*          =   int(14)     ## Bad address
    ENOTBLK*         =   int(15)     ## Block device required
    EBUSY*           =   int(16)     ## Device or resource busy
    EEXIST*          =   int(17)     ## File exists
    EXDEV*           =   int(18)     ## Cross-device link
    ENODEV*          =   int(19)     ## No such device
    ENOTDIR*         =   int(20)     ## Not a directory
    EISDIR*          =   int(21)     ## Is a directory
    EINVAL*          =   int(22)     ## Invalid argument
    ENFILE*          =   int(23)     ## File table overflow
    EMFILE*          =   int(24)     ## Too many open files
    ENOTTY*          =   int(25)     ## Not a typewriter
    ETXTBSY*         =   int(26)     ## Text file busy
    EFBIG*           =   int(27)     ## File too large
    ENOSPC*          =   int(28)     ## No space left on device
    ESPIPE*          =   int(29)     ## Illegal seek
    EROFS*           =   int(30)     ## Read-only file system
    EMLINK*          =   int(31)     ## Too many links
    EPIPE*           =   int(32)     ## Broken pipe
    EDOM*            =   int(33)     ## Math argument out of domain of func
    ERANGE*          =   int(34)     ## Math result not representable
    EDEADLK*         =   int(35)     ## Resource deadlock would occur
    ENAMETOOLONG*    =   int(36)     ## File name too long
    ENOLCK*          =   int(37)     ## No record locks available
    ENOSYS*          =   int(38)     ## Function not implemented
    ENOTEMPTY*       =   int(39)     ## Directory not empty
    ELOOP*           =   int(40)     ## Too many symbolic links encountered
    ENOMSG*          =   int(42)     ## No message of desired type
    EIDRM*           =   int(43)     ## Identifier removed
    ECHRNG*          =   int(44)     ## Channel number out of range
    EL2NSYNC*        =   int(45)     ## Level 2 not synchronized
    EL3HLT*          =   int(46)     ## Level 3 halted
    EL3RST*          =   int(47)     ## Level 3 reset
    ELNRNG*          =   int(48)     ## Link number out of range
    EUNATCH*         =   int(49)     ## Protocol driver not attached
    ENOCSI*          =   int(50)     ## No CSI structure available
    EL2HLT*          =   int(51)     ## Level 2 halted
    EBADE*           =   int(52)     ## Invalid exchange
    EBADR*           =   int(53)     ## Invalid request descriptor
    EXFULL*          =   int(54)     ## Exchange full
    ENOANO*          =   int(55)     ## No anode
    EBADRQC*         =   int(56)     ## Invalid request code
    EBADSLT*         =   int(57)     ## Invalid slot
    EBFONT*          =   int(59)     ## Bad font file format
    ENOSTR*          =   int(60)     ## Device not a stream
    ENODATA*         =   int(61)     ## No data available
    ETIME*           =   int(62)     ## Timer expired
    ENOSR*           =   int(63)     ## Out of streams resources
    ENONET*          =   int(64)     ## Machine is not on the network
    ENOPKG*          =   int(65)     ## Package not installed
    EREMOTE*         =   int(66)     ## Object is remote
    ENOLINK*         =   int(67)     ## Link has been severed
    EADV*            =   int(68)     ## Advertise error
    ESRMNT*          =   int(69)     ## Srmount error
    ECOMM*           =   int(70)     ## Communication error on send
    EPROTO*          =   int(71)     ## Protocol error
    EMULTIHOP*       =   int(72)     ## Multihop attempted
    EDOTDOT*         =   int(73)     ## RFS specific error
    EBADMSG*         =   int(74)     ## Not a data message
    EOVERFLOW*       =   int(75)     ## Value too large for defined data type
    ENOTUNIQ*        =   int(76)     ## Name not unique on network
    EBADFD*          =   int(77)     ## File descriptor in bad state
    EREMCHG*         =   int(78)     ## Remote address changed
    ELIBACC*         =   int(79)     ## Can not access a needed shared library
    ELIBBAD*         =   int(80)     ## Accessing a corrupted shared library
    ELIBSCN*         =   int(81)     ## .lib section in a.out corrupted
    ELIBMAX*         =   int(82)     ## Attempting to link in too many shared libraries
    ELIBEXEC*        =   int(83)     ## Cannot exec a shared library directly
    EILSEQ*          =   int(84)     ## Illegal byte sequence
    ERESTART*        =   int(85)     ## Interrupted system call should be restarted
    ESTRPIPE*        =   int(86)     ## Streams pipe error
    EUSERS*          =   int(87)     ## Too many users
    ENOTSOCK*        =   int(88)     ## Socket operation on non-socket
    EDESTADDRREQ*    =   int(89)     ## Destination address required
    EMSGSIZE*        =   int(90)     ## Message too long
    EPROTOTYPE*      =   int(91)     ## Protocol wrong type for socket
    ENOPROTOOPT*     =   int(92)     ## Protocol not available
    EPROTONOSUPPORT* =   int(93)     ## Protocol not supported
    ESOCKTNOSUPPORT* =   int(94)     ## Socket type not supported
    EOPNOTSUPP*      =   int(95)     ## Operation not supported on transport endpoint
    EPFNOSUPPORT*    =   int(96)     ## Protocol family not supported
    EAFNOSUPPORT*    =   int(97)     ## Address family not supported by protocol
    EADDRINUSE*      =   int(98)     ## Address already in use
    EADDRNOTAVAIL*   =   int(99)     ## Cannot assign requested address
    ENETDOWN*        =   int(100)    ## Network is down
    ENETUNREACH*     =   int(101)    ## Network is unreachable
    ENETRESET*       =   int(102)    ## Network dropped connection because of reset
    ECONNABORTED*    =   int(103)    ## Software caused connection abort
    ECONNRESET*      =   int(104)    ## Connection reset by peer
    ENOBUFS*         =   int(105)    ## No buffer space available
    EISCONN*         =   int(106)    ## Transport endpoint is already connected
    ENOTCONN*        =   int(107)    ## Transport endpoint is not connected
    ESHUTDOWN*       =   int(108)    ## Cannot send after transport endpoint shutdown
    ETOOMANYREFS*    =   int(109)    ## Too many references: cannot splice
    ETIMEDOUT*       =   int(110)    ## Connection timed out
    ECONNREFUSED*    =   int(111)    ## Connection refused
    EHOSTDOWN*       =   int(112)    ## Host is down
    EHOSTUNREACH*    =   int(113)    ## No route to host
    EALREADY*        =   int(114)    ## Operation already in progress
    EINPROGRESS*     =   int(115)    ## Operation now in progress
    ESTALE*          =   int(116)    ## Stale NFS file handle
    EUCLEAN*         =   int(117)    ## Structure needs cleaning
    ENOTNAM*         =   int(118)    ## Not a XENIX named type file
    ENAVAIL*         =   int(119)    ## No XENIX semaphores available
    EISNAM*          =   int(120)    ## Is a named type file
    EREMOTEIO*       =   int(121)    ## Remote I/O error
    EDQUOT*          =   int(122)    ## Quota exceeded
    ENOMEDIUM*       =   int(123)    ## No medium found
    EMEDIUMTYPE*     =   int(124)    ## Wrong medium type
    ECANCELED*       =   int(125)    ## Operation Canceled
    ENOKEY*          =   int(126)    ## Required key not available
    EKEYEXPIRED*     =   int(127)    ## Key has expired
    EKEYREVOKED*     =   int(128)    ## Key has been revoked
    EKEYREJECTED*    =   int(129)    ## Key was rejected by service
    EOWNERDEAD*      =   int(130)    ## Owner died
    ENOTRECOVERABLE* =   int(131)    ## State not recoverable

let 
    # The core error types
    RuntimeErr*     = VErrorKind(label: "Runtime Error"     , parent: nil)
    SyntaxErr*      = VErrorKind(label: "Syntax Error"      , parent: nil,  description: "Unable to parse input code")
    CmdlineErr*     = VErrorKind(label: "Command-line Error", parent: nil,  description: "Something went wrong while processing given command-line arguments")
    ProgramErr*     = VErrorKind(label: "Program Error"     , parent: nil)
    SystemErr*      = VErrorKind(label: "System Error"      , parent: nil)
    VMErr*          = VErrorKind(label: "VM Error"          , parent: nil)

proc toRuntimeErrorKind*(lbl: string, desc: string = ""): VErrorKind =
    result = VErrorKind(label: lbl, description: desc, parent: RuntimeErr)

let 
    # Derived error types to be used
    # by our error templates
    ArithmeticErr*      = toRuntimeErrorKind(
                            "Arithmetic Error",
                            "")
    AssertionErr*       = toRuntimeErrorKind(
                            "Assertion Error",
                            "Runtime check failed")
    ConversionErr*      = toRuntimeErrorKind(
                            "Conversion Error", 
                            "Problem when converting value to given type")
    IndexErr*           = toRuntimeErrorKind(
                            "Index Error",
                            "Cannot resolve requested index")
    PackageErr*         = toRuntimeErrorKind(
                            "Package Error",
                            "")
    LibraryErr*         = toRuntimeErrorKind(
                            "Library Error",
                            "")
    NameErr*            = toRuntimeErrorKind(
                            "Name Error",
                            "Cannot resolve requested value")
    ValueErr*           = toRuntimeErrorKind(
                            "Value Error",
                            "")
    TypeErr*            = toRuntimeErrorKind(
                            "Type Error",
                            "Erroneous type found")
    UIErr*              = toRuntimeErrorKind(
                            "UI Error",
                            "")

#TypeErr, ArgumentErr, ValueErr, AttributeErr

#=======================================
# Constructors
#=======================================

func toError*(kind: VErrorKind, msg: string, hint: string = "", errCode: int = EPERM): VError =
    VError(kind: kind, name: cstring($errCode), msg: msg, hint: hint)

#=======================================
# Overloads
#=======================================

func `$`*(kind: VErrorKind): string {.inline,enforceNoRaises.} =
    kind.label

func `$`*(error: VError): string {.inline,enforceNoRaises.} =
    fmt"{error.kind}: {error.msg}"