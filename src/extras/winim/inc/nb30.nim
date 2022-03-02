#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
#include <nb30.h>
const
  NCBNAMSZ* = 16
when winimCpu64:
  type
    NCB_RESERVE* = array[18, UCHAR]
when winimCpu32:
  type
    NCB_RESERVE* = array[10, UCHAR]
type
  NCB* {.pure.} = object
    ncb_command*: UCHAR
    ncb_retcode*: UCHAR
    ncb_lsn*: UCHAR
    ncb_num*: UCHAR
    ncb_buffer*: PUCHAR
    ncb_length*: WORD
    ncb_callname*: array[NCBNAMSZ, UCHAR]
    ncb_name*: array[NCBNAMSZ, UCHAR]
    ncb_rto*: UCHAR
    ncb_sto*: UCHAR
    ncb_post*: proc (P1: ptr NCB): void {.stdcall.}
    ncb_lana_num*: UCHAR
    ncb_cmd_cplt*: UCHAR
    ncb_reserve*: NCB_RESERVE
    ncb_event*: HANDLE
  PNCB* = ptr NCB
  ADAPTER_STATUS* {.pure.} = object
    adapter_address*: array[6, UCHAR]
    rev_major*: UCHAR
    reserved0*: UCHAR
    adapter_type*: UCHAR
    rev_minor*: UCHAR
    duration*: WORD
    frmr_recv*: WORD
    frmr_xmit*: WORD
    iframe_recv_err*: WORD
    xmit_aborts*: WORD
    xmit_success*: DWORD
    recv_success*: DWORD
    iframe_xmit_err*: WORD
    recv_buff_unavail*: WORD
    t1_timeouts*: WORD
    ti_timeouts*: WORD
    reserved1*: DWORD
    free_ncbs*: WORD
    max_cfg_ncbs*: WORD
    max_ncbs*: WORD
    xmit_buf_unavail*: WORD
    max_dgram_size*: WORD
    pending_sess*: WORD
    max_cfg_sess*: WORD
    max_sess*: WORD
    max_sess_pkt_size*: WORD
    name_count*: WORD
  PADAPTER_STATUS* = ptr ADAPTER_STATUS
  NAME_BUFFER* {.pure.} = object
    name*: array[NCBNAMSZ, UCHAR]
    name_num*: UCHAR
    name_flags*: UCHAR
  PNAME_BUFFER* = ptr NAME_BUFFER
  SESSION_HEADER* {.pure.} = object
    sess_name*: UCHAR
    num_sess*: UCHAR
    rcv_dg_outstanding*: UCHAR
    rcv_any_outstanding*: UCHAR
  PSESSION_HEADER* = ptr SESSION_HEADER
  SESSION_BUFFER* {.pure.} = object
    lsn*: UCHAR
    state*: UCHAR
    local_name*: array[NCBNAMSZ, UCHAR]
    remote_name*: array[NCBNAMSZ, UCHAR]
    rcvs_outstanding*: UCHAR
    sends_outstanding*: UCHAR
  PSESSION_BUFFER* = ptr SESSION_BUFFER
const
  MAX_LANA* = 254
type
  LANA_ENUM* {.pure.} = object
    length*: UCHAR
    lana*: array[MAX_LANA+1, UCHAR]
  PLANA_ENUM* = ptr LANA_ENUM
  FIND_NAME_HEADER* {.pure.} = object
    node_count*: WORD
    reserved*: UCHAR
    unique_group*: UCHAR
  PFIND_NAME_HEADER* = ptr FIND_NAME_HEADER
  FIND_NAME_BUFFER* {.pure.} = object
    length*: UCHAR
    access_control*: UCHAR
    frame_control*: UCHAR
    destination_addr*: array[6, UCHAR]
    source_addr*: array[6, UCHAR]
    routing_info*: array[18, UCHAR]
  PFIND_NAME_BUFFER* = ptr FIND_NAME_BUFFER
  ACTION_HEADER* {.pure.} = object
    transport_id*: ULONG
    action_code*: USHORT
    reserved*: USHORT
  PACTION_HEADER* = ptr ACTION_HEADER
const
  NAME_FLAGS_MASK* = 0x87
  GROUP_NAME* = 0x80
  UNIQUE_NAME* = 0x00
  REGISTERING* = 0x00
  REGISTERED* = 0x04
  DEREGISTERED* = 0x05
  DUPLICATE* = 0x06
  DUPLICATE_DEREG* = 0x07
  LISTEN_OUTSTANDING* = 0x01
  CALL_PENDING* = 0x02
  SESSION_ESTABLISHED* = 0x03
  HANGUP_PENDING* = 0x04
  HANGUP_COMPLETE* = 0x05
  SESSION_ABORTED* = 0x06
  ALL_TRANSPORTS* = "M\0\0\0"
  MS_NBF* = "MNBF"
  NCBCALL* = 0x10
  NCBLISTEN* = 0x11
  NCBHANGUP* = 0x12
  NCBSEND* = 0x14
  NCBRECV* = 0x15
  NCBRECVANY* = 0x16
  NCBCHAINSEND* = 0x17
  NCBDGSEND* = 0x20
  NCBDGRECV* = 0x21
  NCBDGSENDBC* = 0x22
  NCBDGRECVBC* = 0x23
  NCBADDNAME* = 0x30
  NCBDELNAME* = 0x31
  NCBRESET* = 0x32
  NCBASTAT* = 0x33
  NCBSSTAT* = 0x34
  NCBCANCEL* = 0x35
  NCBADDGRNAME* = 0x36
  NCBENUM* = 0x37
  NCBUNLINK* = 0x70
  NCBSENDNA* = 0x71
  NCBCHAINSENDNA* = 0x72
  NCBLANSTALERT* = 0x73
  NCBACTION* = 0x77
  NCBFINDNAME* = 0x78
  NCBTRACE* = 0x79
  ASYNCH* = 0x80
  NRC_GOODRET* = 0x00
  NRC_BUFLEN* = 0x01
  NRC_ILLCMD* = 0x03
  NRC_CMDTMO* = 0x05
  NRC_INCOMP* = 0x06
  NRC_BADDR* = 0x07
  NRC_SNUMOUT* = 0x08
  NRC_NORES* = 0x09
  NRC_SCLOSED* = 0x0a
  NRC_CMDCAN* = 0x0b
  NRC_DUPNAME* = 0x0d
  NRC_NAMTFUL* = 0x0e
  NRC_ACTSES* = 0x0f
  NRC_LOCTFUL* = 0x11
  NRC_REMTFUL* = 0x12
  NRC_ILLNN* = 0x13
  NRC_NOCALL* = 0x14
  NRC_NOWILD* = 0x15
  NRC_INUSE* = 0x16
  NRC_NAMERR* = 0x17
  NRC_SABORT* = 0x18
  NRC_NAMCONF* = 0x19
  NRC_IFBUSY* = 0x21
  NRC_TOOMANY* = 0x22
  NRC_BRIDGE* = 0x23
  NRC_CANOCCR* = 0x24
  NRC_CANCEL* = 0x26
  NRC_DUPENV* = 0x30
  NRC_ENVNOTDEF* = 0x34
  NRC_OSRESNOTAV* = 0x35
  NRC_MAXAPPS* = 0x36
  NRC_NOSAPS* = 0x37
  NRC_NORESOURCES* = 0x38
  NRC_INVADDRESS* = 0x39
  NRC_INVDDID* = 0x3B
  NRC_LOCKFAIL* = 0x3C
  NRC_OPENERR* = 0x3f
  NRC_SYSTEM* = 0x40
  NRC_PENDING* = 0xff
proc Netbios*(pncb: PNCB): UCHAR {.winapi, stdcall, dynlib: "netapi32", importc.}
