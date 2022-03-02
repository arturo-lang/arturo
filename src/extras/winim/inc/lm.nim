#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winsvc
#include <lm.h>
#include <lmcons.h>
#include <lmerr.h>
#include <lmaccess.h>
#include <lmalert.h>
#include <lmshare.h>
#include <lmmsg.h>
#include <lmremutl.h>
#include <lmrepl.h>
#include <lmserver.h>
#include <lmsvc.h>
#include <lmsname.h>
#include <lmuse.h>
#include <lmuseflg.h>
#include <lmwksta.h>
#include <lmapibuf.h>
#include <lmerrlog.h>
#include <lmconfig.h>
#include <lmstats.h>
#include <lmaudit.h>
#include <lmjoin.h>
#include <lmat.h>
#include <lmdfs.h>
#include <lmon.h>
type
  NET_VALIDATE_PASSWORD_TYPE* = int32
  PNET_VALIDATE_PASSWORD_TYPE* = ptr int32
  MSA_INFO_STATE* = int32
  NETSETUP_NAME_TYPE* = int32
  PNETSETUP_NAME_TYPE* = ptr int32
  NETSETUP_JOIN_STATUS* = int32
  PNETSETUP_JOIN_STATUS* = ptr int32
  NET_COMPUTER_NAME_TYPE* = int32
  PNET_COMPUTER_NAME_TYPE* = ptr int32
  DFS_TARGET_PRIORITY_CLASS* = int32
  DFS_NAMESPACE_VERSION_ORIGIN* = int32
  LMSTR* = LPWSTR
  LMCSTR* = LPCWSTR
  NET_API_STATUS* = DWORD
when winimUnicode:
  type
    DESC_CHAR* = WCHAR
when winimAnsi:
  type
    DESC_CHAR* = CHAR
type
  API_RET_TYPE* = NET_API_STATUS
  USER_INFO_0* {.pure.} = object
    usri0_name*: LPWSTR
  PUSER_INFO_0* = ptr USER_INFO_0
  LPUSER_INFO_0* = ptr USER_INFO_0
  USER_INFO_1* {.pure.} = object
    usri1_name*: LPWSTR
    usri1_password*: LPWSTR
    usri1_password_age*: DWORD
    usri1_priv*: DWORD
    usri1_home_dir*: LPWSTR
    usri1_comment*: LPWSTR
    usri1_flags*: DWORD
    usri1_script_path*: LPWSTR
  PUSER_INFO_1* = ptr USER_INFO_1
  LPUSER_INFO_1* = ptr USER_INFO_1
  USER_INFO_2* {.pure.} = object
    usri2_name*: LPWSTR
    usri2_password*: LPWSTR
    usri2_password_age*: DWORD
    usri2_priv*: DWORD
    usri2_home_dir*: LPWSTR
    usri2_comment*: LPWSTR
    usri2_flags*: DWORD
    usri2_script_path*: LPWSTR
    usri2_auth_flags*: DWORD
    usri2_full_name*: LPWSTR
    usri2_usr_comment*: LPWSTR
    usri2_parms*: LPWSTR
    usri2_workstations*: LPWSTR
    usri2_last_logon*: DWORD
    usri2_last_logoff*: DWORD
    usri2_acct_expires*: DWORD
    usri2_max_storage*: DWORD
    usri2_units_per_week*: DWORD
    usri2_logon_hours*: PBYTE
    usri2_bad_pw_count*: DWORD
    usri2_num_logons*: DWORD
    usri2_logon_server*: LPWSTR
    usri2_country_code*: DWORD
    usri2_code_page*: DWORD
  PUSER_INFO_2* = ptr USER_INFO_2
  LPUSER_INFO_2* = ptr USER_INFO_2
  USER_INFO_3* {.pure.} = object
    usri3_name*: LPWSTR
    usri3_password*: LPWSTR
    usri3_password_age*: DWORD
    usri3_priv*: DWORD
    usri3_home_dir*: LPWSTR
    usri3_comment*: LPWSTR
    usri3_flags*: DWORD
    usri3_script_path*: LPWSTR
    usri3_auth_flags*: DWORD
    usri3_full_name*: LPWSTR
    usri3_usr_comment*: LPWSTR
    usri3_parms*: LPWSTR
    usri3_workstations*: LPWSTR
    usri3_last_logon*: DWORD
    usri3_last_logoff*: DWORD
    usri3_acct_expires*: DWORD
    usri3_max_storage*: DWORD
    usri3_units_per_week*: DWORD
    usri3_logon_hours*: PBYTE
    usri3_bad_pw_count*: DWORD
    usri3_num_logons*: DWORD
    usri3_logon_server*: LPWSTR
    usri3_country_code*: DWORD
    usri3_code_page*: DWORD
    usri3_user_id*: DWORD
    usri3_primary_group_id*: DWORD
    usri3_profile*: LPWSTR
    usri3_home_dir_drive*: LPWSTR
    usri3_password_expired*: DWORD
  PUSER_INFO_3* = ptr USER_INFO_3
  LPUSER_INFO_3* = ptr USER_INFO_3
  USER_INFO_4* {.pure.} = object
    usri4_name*: LPWSTR
    usri4_password*: LPWSTR
    usri4_password_age*: DWORD
    usri4_priv*: DWORD
    usri4_home_dir*: LPWSTR
    usri4_comment*: LPWSTR
    usri4_flags*: DWORD
    usri4_script_path*: LPWSTR
    usri4_auth_flags*: DWORD
    usri4_full_name*: LPWSTR
    usri4_usr_comment*: LPWSTR
    usri4_parms*: LPWSTR
    usri4_workstations*: LPWSTR
    usri4_last_logon*: DWORD
    usri4_last_logoff*: DWORD
    usri4_acct_expires*: DWORD
    usri4_max_storage*: DWORD
    usri4_units_per_week*: DWORD
    usri4_logon_hours*: PBYTE
    usri4_bad_pw_count*: DWORD
    usri4_num_logons*: DWORD
    usri4_logon_server*: LPWSTR
    usri4_country_code*: DWORD
    usri4_code_page*: DWORD
    usri4_user_sid*: PSID
    usri4_primary_group_id*: DWORD
    usri4_profile*: LPWSTR
    usri4_home_dir_drive*: LPWSTR
    usri4_password_expired*: DWORD
  PUSER_INFO_4* = ptr USER_INFO_4
  LPUSER_INFO_4* = ptr USER_INFO_4
  USER_INFO_10* {.pure.} = object
    usri10_name*: LPWSTR
    usri10_comment*: LPWSTR
    usri10_usr_comment*: LPWSTR
    usri10_full_name*: LPWSTR
  PUSER_INFO_10* = ptr USER_INFO_10
  LPUSER_INFO_10* = ptr USER_INFO_10
  USER_INFO_11* {.pure.} = object
    usri11_name*: LPWSTR
    usri11_comment*: LPWSTR
    usri11_usr_comment*: LPWSTR
    usri11_full_name*: LPWSTR
    usri11_priv*: DWORD
    usri11_auth_flags*: DWORD
    usri11_password_age*: DWORD
    usri11_home_dir*: LPWSTR
    usri11_parms*: LPWSTR
    usri11_last_logon*: DWORD
    usri11_last_logoff*: DWORD
    usri11_bad_pw_count*: DWORD
    usri11_num_logons*: DWORD
    usri11_logon_server*: LPWSTR
    usri11_country_code*: DWORD
    usri11_workstations*: LPWSTR
    usri11_max_storage*: DWORD
    usri11_units_per_week*: DWORD
    usri11_logon_hours*: PBYTE
    usri11_code_page*: DWORD
  PUSER_INFO_11* = ptr USER_INFO_11
  LPUSER_INFO_11* = ptr USER_INFO_11
  USER_INFO_20* {.pure.} = object
    usri20_name*: LPWSTR
    usri20_full_name*: LPWSTR
    usri20_comment*: LPWSTR
    usri20_flags*: DWORD
    usri20_user_id*: DWORD
  PUSER_INFO_20* = ptr USER_INFO_20
  LPUSER_INFO_20* = ptr USER_INFO_20
const
  ENCRYPTED_PWLEN* = 16
type
  USER_INFO_21* {.pure.} = object
    usri21_password*: array[ENCRYPTED_PWLEN, BYTE]
  PUSER_INFO_21* = ptr USER_INFO_21
  LPUSER_INFO_21* = ptr USER_INFO_21
  USER_INFO_22* {.pure.} = object
    usri22_name*: LPWSTR
    usri22_password*: array[ENCRYPTED_PWLEN, BYTE]
    usri22_password_age*: DWORD
    usri22_priv*: DWORD
    usri22_home_dir*: LPWSTR
    usri22_comment*: LPWSTR
    usri22_flags*: DWORD
    usri22_script_path*: LPWSTR
    usri22_auth_flags*: DWORD
    usri22_full_name*: LPWSTR
    usri22_usr_comment*: LPWSTR
    usri22_parms*: LPWSTR
    usri22_workstations*: LPWSTR
    usri22_last_logon*: DWORD
    usri22_last_logoff*: DWORD
    usri22_acct_expires*: DWORD
    usri22_max_storage*: DWORD
    usri22_units_per_week*: DWORD
    usri22_logon_hours*: PBYTE
    usri22_bad_pw_count*: DWORD
    usri22_num_logons*: DWORD
    usri22_logon_server*: LPWSTR
    usri22_country_code*: DWORD
    usri22_code_page*: DWORD
  PUSER_INFO_22* = ptr USER_INFO_22
  LPUSER_INFO_22* = ptr USER_INFO_22
  USER_INFO_23* {.pure.} = object
    usri23_name*: LPWSTR
    usri23_full_name*: LPWSTR
    usri23_comment*: LPWSTR
    usri23_flags*: DWORD
    usri23_user_sid*: PSID
  PUSER_INFO_23* = ptr USER_INFO_23
  LPUSER_INFO_23* = ptr USER_INFO_23
  USER_INFO_24* {.pure.} = object
    usri24_internet_identity*: BOOL
    usri24_flags*: DWORD
    usri24_internet_provider_name*: LPWSTR
    usri24_internet_principal_name*: LPWSTR
    usri24_user_sid*: PSID
  PUSER_INFO_24* = ptr USER_INFO_24
  LPUSER_INFO_24* = ptr USER_INFO_24
  USER_INFO_1003* {.pure.} = object
    usri1003_password*: LPWSTR
  PUSER_INFO_1003* = ptr USER_INFO_1003
  LPUSER_INFO_1003* = ptr USER_INFO_1003
  USER_INFO_1005* {.pure.} = object
    usri1005_priv*: DWORD
  PUSER_INFO_1005* = ptr USER_INFO_1005
  LPUSER_INFO_1005* = ptr USER_INFO_1005
  USER_INFO_1006* {.pure.} = object
    usri1006_home_dir*: LPWSTR
  PUSER_INFO_1006* = ptr USER_INFO_1006
  LPUSER_INFO_1006* = ptr USER_INFO_1006
  USER_INFO_1007* {.pure.} = object
    usri1007_comment*: LPWSTR
  PUSER_INFO_1007* = ptr USER_INFO_1007
  LPUSER_INFO_1007* = ptr USER_INFO_1007
  USER_INFO_1008* {.pure.} = object
    usri1008_flags*: DWORD
  PUSER_INFO_1008* = ptr USER_INFO_1008
  LPUSER_INFO_1008* = ptr USER_INFO_1008
  USER_INFO_1009* {.pure.} = object
    usri1009_script_path*: LPWSTR
  PUSER_INFO_1009* = ptr USER_INFO_1009
  LPUSER_INFO_1009* = ptr USER_INFO_1009
  USER_INFO_1010* {.pure.} = object
    usri1010_auth_flags*: DWORD
  PUSER_INFO_1010* = ptr USER_INFO_1010
  LPUSER_INFO_1010* = ptr USER_INFO_1010
  USER_INFO_1011* {.pure.} = object
    usri1011_full_name*: LPWSTR
  PUSER_INFO_1011* = ptr USER_INFO_1011
  LPUSER_INFO_1011* = ptr USER_INFO_1011
  USER_INFO_1012* {.pure.} = object
    usri1012_usr_comment*: LPWSTR
  PUSER_INFO_1012* = ptr USER_INFO_1012
  LPUSER_INFO_1012* = ptr USER_INFO_1012
  USER_INFO_1013* {.pure.} = object
    usri1013_parms*: LPWSTR
  PUSER_INFO_1013* = ptr USER_INFO_1013
  LPUSER_INFO_1013* = ptr USER_INFO_1013
  USER_INFO_1014* {.pure.} = object
    usri1014_workstations*: LPWSTR
  PUSER_INFO_1014* = ptr USER_INFO_1014
  LPUSER_INFO_1014* = ptr USER_INFO_1014
  USER_INFO_1017* {.pure.} = object
    usri1017_acct_expires*: DWORD
  PUSER_INFO_1017* = ptr USER_INFO_1017
  LPUSER_INFO_1017* = ptr USER_INFO_1017
  USER_INFO_1018* {.pure.} = object
    usri1018_max_storage*: DWORD
  PUSER_INFO_1018* = ptr USER_INFO_1018
  LPUSER_INFO_1018* = ptr USER_INFO_1018
  USER_INFO_1020* {.pure.} = object
    usri1020_units_per_week*: DWORD
    usri1020_logon_hours*: LPBYTE
  PUSER_INFO_1020* = ptr USER_INFO_1020
  LPUSER_INFO_1020* = ptr USER_INFO_1020
  USER_INFO_1023* {.pure.} = object
    usri1023_logon_server*: LPWSTR
  PUSER_INFO_1023* = ptr USER_INFO_1023
  LPUSER_INFO_1023* = ptr USER_INFO_1023
  USER_INFO_1024* {.pure.} = object
    usri1024_country_code*: DWORD
  PUSER_INFO_1024* = ptr USER_INFO_1024
  LPUSER_INFO_1024* = ptr USER_INFO_1024
  USER_INFO_1025* {.pure.} = object
    usri1025_code_page*: DWORD
  PUSER_INFO_1025* = ptr USER_INFO_1025
  LPUSER_INFO_1025* = ptr USER_INFO_1025
  USER_INFO_1051* {.pure.} = object
    usri1051_primary_group_id*: DWORD
  PUSER_INFO_1051* = ptr USER_INFO_1051
  LPUSER_INFO_1051* = ptr USER_INFO_1051
  USER_INFO_1052* {.pure.} = object
    usri1052_profile*: LPWSTR
  PUSER_INFO_1052* = ptr USER_INFO_1052
  LPUSER_INFO_1052* = ptr USER_INFO_1052
  USER_INFO_1053* {.pure.} = object
    usri1053_home_dir_drive*: LPWSTR
  PUSER_INFO_1053* = ptr USER_INFO_1053
  LPUSER_INFO_1053* = ptr USER_INFO_1053
  USER_MODALS_INFO_0* {.pure.} = object
    usrmod0_min_passwd_len*: DWORD
    usrmod0_max_passwd_age*: DWORD
    usrmod0_min_passwd_age*: DWORD
    usrmod0_force_logoff*: DWORD
    usrmod0_password_hist_len*: DWORD
  PUSER_MODALS_INFO_0* = ptr USER_MODALS_INFO_0
  LPUSER_MODALS_INFO_0* = ptr USER_MODALS_INFO_0
  USER_MODALS_INFO_1* {.pure.} = object
    usrmod1_role*: DWORD
    usrmod1_primary*: LPWSTR
  PUSER_MODALS_INFO_1* = ptr USER_MODALS_INFO_1
  LPUSER_MODALS_INFO_1* = ptr USER_MODALS_INFO_1
  USER_MODALS_INFO_2* {.pure.} = object
    usrmod2_domain_name*: LPWSTR
    usrmod2_domain_id*: PSID
  PUSER_MODALS_INFO_2* = ptr USER_MODALS_INFO_2
  LPUSER_MODALS_INFO_2* = ptr USER_MODALS_INFO_2
  USER_MODALS_INFO_3* {.pure.} = object
    usrmod3_lockout_duration*: DWORD
    usrmod3_lockout_observation_window*: DWORD
    usrmod3_lockout_threshold*: DWORD
  PUSER_MODALS_INFO_3* = ptr USER_MODALS_INFO_3
  LPUSER_MODALS_INFO_3* = ptr USER_MODALS_INFO_3
  USER_MODALS_INFO_1001* {.pure.} = object
    usrmod1001_min_passwd_len*: DWORD
  PUSER_MODALS_INFO_1001* = ptr USER_MODALS_INFO_1001
  LPUSER_MODALS_INFO_1001* = ptr USER_MODALS_INFO_1001
  USER_MODALS_INFO_1002* {.pure.} = object
    usrmod1002_max_passwd_age*: DWORD
  PUSER_MODALS_INFO_1002* = ptr USER_MODALS_INFO_1002
  LPUSER_MODALS_INFO_1002* = ptr USER_MODALS_INFO_1002
  USER_MODALS_INFO_1003* {.pure.} = object
    usrmod1003_min_passwd_age*: DWORD
  PUSER_MODALS_INFO_1003* = ptr USER_MODALS_INFO_1003
  LPUSER_MODALS_INFO_1003* = ptr USER_MODALS_INFO_1003
  USER_MODALS_INFO_1004* {.pure.} = object
    usrmod1004_force_logoff*: DWORD
  PUSER_MODALS_INFO_1004* = ptr USER_MODALS_INFO_1004
  LPUSER_MODALS_INFO_1004* = ptr USER_MODALS_INFO_1004
  USER_MODALS_INFO_1005* {.pure.} = object
    usrmod1005_password_hist_len*: DWORD
  PUSER_MODALS_INFO_1005* = ptr USER_MODALS_INFO_1005
  LPUSER_MODALS_INFO_1005* = ptr USER_MODALS_INFO_1005
  USER_MODALS_INFO_1006* {.pure.} = object
    usrmod1006_role*: DWORD
  PUSER_MODALS_INFO_1006* = ptr USER_MODALS_INFO_1006
  LPUSER_MODALS_INFO_1006* = ptr USER_MODALS_INFO_1006
  USER_MODALS_INFO_1007* {.pure.} = object
    usrmod1007_primary*: LPWSTR
  PUSER_MODALS_INFO_1007* = ptr USER_MODALS_INFO_1007
  LPUSER_MODALS_INFO_1007* = ptr USER_MODALS_INFO_1007
  GROUP_INFO_0* {.pure.} = object
    grpi0_name*: LPWSTR
  PGROUP_INFO_0* = ptr GROUP_INFO_0
  LPGROUP_INFO_0* = ptr GROUP_INFO_0
  GROUP_INFO_1* {.pure.} = object
    grpi1_name*: LPWSTR
    grpi1_comment*: LPWSTR
  PGROUP_INFO_1* = ptr GROUP_INFO_1
  LPGROUP_INFO_1* = ptr GROUP_INFO_1
  GROUP_INFO_2* {.pure.} = object
    grpi2_name*: LPWSTR
    grpi2_comment*: LPWSTR
    grpi2_group_id*: DWORD
    grpi2_attributes*: DWORD
  PGROUP_INFO_2* = ptr GROUP_INFO_2
  GROUP_INFO_3* {.pure.} = object
    grpi3_name*: LPWSTR
    grpi3_comment*: LPWSTR
    grpi3_group_sid*: PSID
    grpi3_attributes*: DWORD
  PGROUP_INFO_3* = ptr GROUP_INFO_3
  GROUP_INFO_1002* {.pure.} = object
    grpi1002_comment*: LPWSTR
  PGROUP_INFO_1002* = ptr GROUP_INFO_1002
  LPGROUP_INFO_1002* = ptr GROUP_INFO_1002
  GROUP_INFO_1005* {.pure.} = object
    grpi1005_attributes*: DWORD
  PGROUP_INFO_1005* = ptr GROUP_INFO_1005
  LPGROUP_INFO_1005* = ptr GROUP_INFO_1005
  GROUP_USERS_INFO_0* {.pure.} = object
    grui0_name*: LPWSTR
  PGROUP_USERS_INFO_0* = ptr GROUP_USERS_INFO_0
  LPGROUP_USERS_INFO_0* = ptr GROUP_USERS_INFO_0
  GROUP_USERS_INFO_1* {.pure.} = object
    grui1_name*: LPWSTR
    grui1_attributes*: DWORD
  PGROUP_USERS_INFO_1* = ptr GROUP_USERS_INFO_1
  LPGROUP_USERS_INFO_1* = ptr GROUP_USERS_INFO_1
  LOCALGROUP_INFO_0* {.pure.} = object
    lgrpi0_name*: LPWSTR
  PLOCALGROUP_INFO_0* = ptr LOCALGROUP_INFO_0
  LPLOCALGROUP_INFO_0* = ptr LOCALGROUP_INFO_0
  LOCALGROUP_INFO_1* {.pure.} = object
    lgrpi1_name*: LPWSTR
    lgrpi1_comment*: LPWSTR
  PLOCALGROUP_INFO_1* = ptr LOCALGROUP_INFO_1
  LPLOCALGROUP_INFO_1* = ptr LOCALGROUP_INFO_1
  LOCALGROUP_INFO_1002* {.pure.} = object
    lgrpi1002_comment*: LPWSTR
  PLOCALGROUP_INFO_1002* = ptr LOCALGROUP_INFO_1002
  LPLOCALGROUP_INFO_1002* = ptr LOCALGROUP_INFO_1002
  LOCALGROUP_MEMBERS_INFO_0* {.pure.} = object
    lgrmi0_sid*: PSID
  PLOCALGROUP_MEMBERS_INFO_0* = ptr LOCALGROUP_MEMBERS_INFO_0
  LPLOCALGROUP_MEMBERS_INFO_0* = ptr LOCALGROUP_MEMBERS_INFO_0
  LOCALGROUP_MEMBERS_INFO_1* {.pure.} = object
    lgrmi1_sid*: PSID
    lgrmi1_sidusage*: SID_NAME_USE
    lgrmi1_name*: LPWSTR
  PLOCALGROUP_MEMBERS_INFO_1* = ptr LOCALGROUP_MEMBERS_INFO_1
  LPLOCALGROUP_MEMBERS_INFO_1* = ptr LOCALGROUP_MEMBERS_INFO_1
  LOCALGROUP_MEMBERS_INFO_2* {.pure.} = object
    lgrmi2_sid*: PSID
    lgrmi2_sidusage*: SID_NAME_USE
    lgrmi2_domainandname*: LPWSTR
  PLOCALGROUP_MEMBERS_INFO_2* = ptr LOCALGROUP_MEMBERS_INFO_2
  LPLOCALGROUP_MEMBERS_INFO_2* = ptr LOCALGROUP_MEMBERS_INFO_2
  LOCALGROUP_MEMBERS_INFO_3* {.pure.} = object
    lgrmi3_domainandname*: LPWSTR
  PLOCALGROUP_MEMBERS_INFO_3* = ptr LOCALGROUP_MEMBERS_INFO_3
  LPLOCALGROUP_MEMBERS_INFO_3* = ptr LOCALGROUP_MEMBERS_INFO_3
  LOCALGROUP_USERS_INFO_0* {.pure.} = object
    lgrui0_name*: LPWSTR
  PLOCALGROUP_USERS_INFO_0* = ptr LOCALGROUP_USERS_INFO_0
  LPLOCALGROUP_USERS_INFO_0* = ptr LOCALGROUP_USERS_INFO_0
  NET_DISPLAY_USER* {.pure.} = object
    usri1_name*: LPWSTR
    usri1_comment*: LPWSTR
    usri1_flags*: DWORD
    usri1_full_name*: LPWSTR
    usri1_user_id*: DWORD
    usri1_next_index*: DWORD
  PNET_DISPLAY_USER* = ptr NET_DISPLAY_USER
  NET_DISPLAY_MACHINE* {.pure.} = object
    usri2_name*: LPWSTR
    usri2_comment*: LPWSTR
    usri2_flags*: DWORD
    usri2_user_id*: DWORD
    usri2_next_index*: DWORD
  PNET_DISPLAY_MACHINE* = ptr NET_DISPLAY_MACHINE
  NET_DISPLAY_GROUP* {.pure.} = object
    grpi3_name*: LPWSTR
    grpi3_comment*: LPWSTR
    grpi3_group_id*: DWORD
    grpi3_attributes*: DWORD
    grpi3_next_index*: DWORD
  PNET_DISPLAY_GROUP* = ptr NET_DISPLAY_GROUP
  ACCESS_INFO_0* {.pure.} = object
    acc0_resource_name*: LPWSTR
  PACCESS_INFO_0* = ptr ACCESS_INFO_0
  LPACCESS_INFO_0* = ptr ACCESS_INFO_0
  ACCESS_INFO_1* {.pure.} = object
    acc1_resource_name*: LPWSTR
    acc1_attr*: DWORD
    acc1_count*: DWORD
  PACCESS_INFO_1* = ptr ACCESS_INFO_1
  LPACCESS_INFO_1* = ptr ACCESS_INFO_1
  ACCESS_INFO_1002* {.pure.} = object
    acc1002_attr*: DWORD
  PACCESS_INFO_1002* = ptr ACCESS_INFO_1002
  LPACCESS_INFO_1002* = ptr ACCESS_INFO_1002
  ACCESS_LIST* {.pure.} = object
    acl_ugname*: LPWSTR
    acl_access*: DWORD
  PACCESS_LIST* = ptr ACCESS_LIST
  LPACCESS_LIST* = ptr ACCESS_LIST
  NET_VALIDATE_PASSWORD_HASH* {.pure.} = object
    Length*: ULONG
    Hash*: LPBYTE
  PNET_VALIDATE_PASSWORD_HASH* = ptr NET_VALIDATE_PASSWORD_HASH
  NET_VALIDATE_PERSISTED_FIELDS* {.pure.} = object
    PresentFields*: ULONG
    PasswordLastSet*: FILETIME
    BadPasswordTime*: FILETIME
    LockoutTime*: FILETIME
    BadPasswordCount*: ULONG
    PasswordHistoryLength*: ULONG
    PasswordHistory*: PNET_VALIDATE_PASSWORD_HASH
  PNET_VALIDATE_PERSISTED_FIELDS* = ptr NET_VALIDATE_PERSISTED_FIELDS
  NET_VALIDATE_OUTPUT_ARG* {.pure.} = object
    ChangedPersistedFields*: NET_VALIDATE_PERSISTED_FIELDS
    ValidationStatus*: NET_API_STATUS
  PNET_VALIDATE_OUTPUT_ARG* = ptr NET_VALIDATE_OUTPUT_ARG
  NET_VALIDATE_AUTHENTICATION_INPUT_ARG* {.pure.} = object
    InputPersistedFields*: NET_VALIDATE_PERSISTED_FIELDS
    PasswordMatched*: BOOLEAN
  PNET_VALIDATE_AUTHENTICATION_INPUT_ARG* = ptr NET_VALIDATE_AUTHENTICATION_INPUT_ARG
  NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG* {.pure.} = object
    InputPersistedFields*: NET_VALIDATE_PERSISTED_FIELDS
    ClearPassword*: LPWSTR
    UserAccountName*: LPWSTR
    HashedPassword*: NET_VALIDATE_PASSWORD_HASH
    PasswordMatch*: BOOLEAN
  PNET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG* = ptr NET_VALIDATE_PASSWORD_CHANGE_INPUT_ARG
  NET_VALIDATE_PASSWORD_RESET_INPUT_ARG* {.pure.} = object
    InputPersistedFields*: NET_VALIDATE_PERSISTED_FIELDS
    ClearPassword*: LPWSTR
    UserAccountName*: LPWSTR
    HashedPassword*: NET_VALIDATE_PASSWORD_HASH
    PasswordMustChangeAtNextLogon*: BOOLEAN
    ClearLockout*: BOOLEAN
  PNET_VALIDATE_PASSWORD_RESET_INPUT_ARG* = ptr NET_VALIDATE_PASSWORD_RESET_INPUT_ARG
  NETLOGON_INFO_1* {.pure.} = object
    netlog1_flags*: DWORD
    netlog1_pdc_connection_status*: NET_API_STATUS
  PNETLOGON_INFO_1* = ptr NETLOGON_INFO_1
  NETLOGON_INFO_2* {.pure.} = object
    netlog2_flags*: DWORD
    netlog2_pdc_connection_status*: NET_API_STATUS
    netlog2_trusted_dc_name*: LPWSTR
    netlog2_tc_connection_status*: NET_API_STATUS
  PNETLOGON_INFO_2* = ptr NETLOGON_INFO_2
  NETLOGON_INFO_3* {.pure.} = object
    netlog3_flags*: DWORD
    netlog3_logon_attempts*: DWORD
    netlog3_reserved1*: DWORD
    netlog3_reserved2*: DWORD
    netlog3_reserved3*: DWORD
    netlog3_reserved4*: DWORD
    netlog3_reserved5*: DWORD
  PNETLOGON_INFO_3* = ptr NETLOGON_INFO_3
  NETLOGON_INFO_4* {.pure.} = object
    netlog4_trusted_dc_name*: LPWSTR
    netlog4_trusted_domain_name*: LPWSTR
  PNETLOGON_INFO_4* = ptr NETLOGON_INFO_4
  MSA_INFO_0* {.pure.} = object
    State*: MSA_INFO_STATE
  PMSA_INFO_0* = ptr MSA_INFO_0
const
  EVLEN* = 16
  SNLEN* = 80
type
  STD_ALERT* {.pure.} = object
    alrt_timestamp*: DWORD
    alrt_eventname*: array[EVLEN + 1, WCHAR]
    alrt_servicename*: array[SNLEN + 1, WCHAR]
  PSTD_ALERT* = ptr STD_ALERT
  LPSTD_ALERT* = ptr STD_ALERT
  ADMIN_OTHER_INFO* {.pure.} = object
    alrtad_errcode*: DWORD
    alrtad_numstrings*: DWORD
  PADMIN_OTHER_INFO* = ptr ADMIN_OTHER_INFO
  LPADMIN_OTHER_INFO* = ptr ADMIN_OTHER_INFO
  ERRLOG_OTHER_INFO* {.pure.} = object
    alrter_errcode*: DWORD
    alrter_offset*: DWORD
  PERRLOG_OTHER_INFO* = ptr ERRLOG_OTHER_INFO
  LPERRLOG_OTHER_INFO* = ptr ERRLOG_OTHER_INFO
  PRINT_OTHER_INFO* {.pure.} = object
    alrtpr_jobid*: DWORD
    alrtpr_status*: DWORD
    alrtpr_submitted*: DWORD
    alrtpr_size*: DWORD
  PPRINT_OTHER_INFO* = ptr PRINT_OTHER_INFO
  LPPRINT_OTHER_INFO* = ptr PRINT_OTHER_INFO
  USER_OTHER_INFO* {.pure.} = object
    alrtus_errcode*: DWORD
    alrtus_numstrings*: DWORD
  PUSER_OTHER_INFO* = ptr USER_OTHER_INFO
  LPUSER_OTHER_INFO* = ptr USER_OTHER_INFO
  SHARE_INFO_0* {.pure.} = object
    shi0_netname*: LMSTR
  PSHARE_INFO_0* = ptr SHARE_INFO_0
  LPSHARE_INFO_0* = ptr SHARE_INFO_0
  SHARE_INFO_1* {.pure.} = object
    shi1_netname*: LMSTR
    shi1_type*: DWORD
    shi1_remark*: LMSTR
  PSHARE_INFO_1* = ptr SHARE_INFO_1
  LPSHARE_INFO_1* = ptr SHARE_INFO_1
  SHARE_INFO_2* {.pure.} = object
    shi2_netname*: LMSTR
    shi2_type*: DWORD
    shi2_remark*: LMSTR
    shi2_permissions*: DWORD
    shi2_max_uses*: DWORD
    shi2_current_uses*: DWORD
    shi2_path*: LMSTR
    shi2_passwd*: LMSTR
  PSHARE_INFO_2* = ptr SHARE_INFO_2
  LPSHARE_INFO_2* = ptr SHARE_INFO_2
  SHARE_INFO_501* {.pure.} = object
    shi501_netname*: LMSTR
    shi501_type*: DWORD
    shi501_remark*: LMSTR
    shi501_flags*: DWORD
  PSHARE_INFO_501* = ptr SHARE_INFO_501
  LPSHARE_INFO_501* = ptr SHARE_INFO_501
  SHARE_INFO_502* {.pure.} = object
    shi502_netname*: LMSTR
    shi502_type*: DWORD
    shi502_remark*: LMSTR
    shi502_permissions*: DWORD
    shi502_max_uses*: DWORD
    shi502_current_uses*: DWORD
    shi502_path*: LMSTR
    shi502_passwd*: LMSTR
    shi502_reserved*: DWORD
    shi502_security_descriptor*: PSECURITY_DESCRIPTOR
  PSHARE_INFO_502* = ptr SHARE_INFO_502
  LPSHARE_INFO_502* = ptr SHARE_INFO_502
  SHARE_INFO_1004* {.pure.} = object
    shi1004_remark*: LMSTR
  PSHARE_INFO_1004* = ptr SHARE_INFO_1004
  LPSHARE_INFO_1004* = ptr SHARE_INFO_1004
  SHARE_INFO_1005* {.pure.} = object
    shi1005_flags*: DWORD
  PSHARE_INFO_1005* = ptr SHARE_INFO_1005
  LPSHARE_INFO_1005* = ptr SHARE_INFO_1005
  SHARE_INFO_1006* {.pure.} = object
    shi1006_max_uses*: DWORD
  PSHARE_INFO_1006* = ptr SHARE_INFO_1006
  LPSHARE_INFO_1006* = ptr SHARE_INFO_1006
  SHARE_INFO_1501* {.pure.} = object
    shi1501_reserved*: DWORD
    shi1501_security_descriptor*: PSECURITY_DESCRIPTOR
  PSHARE_INFO_1501* = ptr SHARE_INFO_1501
  LPSHARE_INFO_1501* = ptr SHARE_INFO_1501
  SESSION_INFO_0* {.pure.} = object
    sesi0_cname*: LMSTR
  PSESSION_INFO_0* = ptr SESSION_INFO_0
  LPSESSION_INFO_0* = ptr SESSION_INFO_0
  SESSION_INFO_1* {.pure.} = object
    sesi1_cname*: LMSTR
    sesi1_username*: LMSTR
    sesi1_num_opens*: DWORD
    sesi1_time*: DWORD
    sesi1_idle_time*: DWORD
    sesi1_user_flags*: DWORD
  PSESSION_INFO_1* = ptr SESSION_INFO_1
  LPSESSION_INFO_1* = ptr SESSION_INFO_1
  SESSION_INFO_2* {.pure.} = object
    sesi2_cname*: LMSTR
    sesi2_username*: LMSTR
    sesi2_num_opens*: DWORD
    sesi2_time*: DWORD
    sesi2_idle_time*: DWORD
    sesi2_user_flags*: DWORD
    sesi2_cltype_name*: LMSTR
  PSESSION_INFO_2* = ptr SESSION_INFO_2
  LPSESSION_INFO_2* = ptr SESSION_INFO_2
  SESSION_INFO_10* {.pure.} = object
    sesi10_cname*: LMSTR
    sesi10_username*: LMSTR
    sesi10_time*: DWORD
    sesi10_idle_time*: DWORD
  PSESSION_INFO_10* = ptr SESSION_INFO_10
  LPSESSION_INFO_10* = ptr SESSION_INFO_10
  SESSION_INFO_502* {.pure.} = object
    sesi502_cname*: LMSTR
    sesi502_username*: LMSTR
    sesi502_num_opens*: DWORD
    sesi502_time*: DWORD
    sesi502_idle_time*: DWORD
    sesi502_user_flags*: DWORD
    sesi502_cltype_name*: LMSTR
    sesi502_transport*: LMSTR
  PSESSION_INFO_502* = ptr SESSION_INFO_502
  LPSESSION_INFO_502* = ptr SESSION_INFO_502
  CONNECTION_INFO_0* {.pure.} = object
    coni0_id*: DWORD
  PCONNECTION_INFO_0* = ptr CONNECTION_INFO_0
  LPCONNECTION_INFO_0* = ptr CONNECTION_INFO_0
  CONNECTION_INFO_1* {.pure.} = object
    coni1_id*: DWORD
    coni1_type*: DWORD
    coni1_num_opens*: DWORD
    coni1_num_users*: DWORD
    coni1_time*: DWORD
    coni1_username*: LMSTR
    coni1_netname*: LMSTR
  PCONNECTION_INFO_1* = ptr CONNECTION_INFO_1
  LPCONNECTION_INFO_1* = ptr CONNECTION_INFO_1
  FILE_INFO_2* {.pure.} = object
    fi2_id*: DWORD
  PFILE_INFO_2* = ptr FILE_INFO_2
  LPFILE_INFO_2* = ptr FILE_INFO_2
  FILE_INFO_3* {.pure.} = object
    fi3_id*: DWORD
    fi3_permissions*: DWORD
    fi3_num_locks*: DWORD
    fi3_pathname*: LMSTR
    fi3_username*: LMSTR
  PFILE_INFO_3* = ptr FILE_INFO_3
  LPFILE_INFO_3* = ptr FILE_INFO_3
  MSG_INFO_0* {.pure.} = object
    msgi0_name*: LPWSTR
  PMSG_INFO_0* = ptr MSG_INFO_0
  LPMSG_INFO_0* = ptr MSG_INFO_0
  MSG_INFO_1* {.pure.} = object
    msgi1_name*: LPWSTR
    msgi1_forward_flag*: DWORD
    msgi1_forward*: LPWSTR
  PMSG_INFO_1* = ptr MSG_INFO_1
  LPMSG_INFO_1* = ptr MSG_INFO_1
  LPDESC* = ptr DESC_CHAR
  TIME_OF_DAY_INFO* {.pure.} = object
    tod_elapsedt*: DWORD
    tod_msecs*: DWORD
    tod_hours*: DWORD
    tod_mins*: DWORD
    tod_secs*: DWORD
    tod_hunds*: DWORD
    tod_timezone*: LONG
    tod_tinterval*: DWORD
    tod_day*: DWORD
    tod_month*: DWORD
    tod_year*: DWORD
    tod_weekday*: DWORD
  PTIME_OF_DAY_INFO* = ptr TIME_OF_DAY_INFO
  LPTIME_OF_DAY_INFO* = ptr TIME_OF_DAY_INFO
  REPL_INFO_0* {.pure.} = object
    rp0_role*: DWORD
    rp0_exportpath*: LPWSTR
    rp0_exportlist*: LPWSTR
    rp0_importpath*: LPWSTR
    rp0_importlist*: LPWSTR
    rp0_logonusername*: LPWSTR
    rp0_interval*: DWORD
    rp0_pulse*: DWORD
    rp0_guardtime*: DWORD
    rp0_random*: DWORD
  PREPL_INFO_0* = ptr REPL_INFO_0
  LPREPL_INFO_0* = ptr REPL_INFO_0
  REPL_INFO_1000* {.pure.} = object
    rp1000_interval*: DWORD
  PREPL_INFO_1000* = ptr REPL_INFO_1000
  LPREPL_INFO_1000* = ptr REPL_INFO_1000
  REPL_INFO_1001* {.pure.} = object
    rp1001_pulse*: DWORD
  PREPL_INFO_1001* = ptr REPL_INFO_1001
  LPREPL_INFO_1001* = ptr REPL_INFO_1001
  REPL_INFO_1002* {.pure.} = object
    rp1002_guardtime*: DWORD
  PREPL_INFO_1002* = ptr REPL_INFO_1002
  LPREPL_INFO_1002* = ptr REPL_INFO_1002
  REPL_INFO_1003* {.pure.} = object
    rp1003_random*: DWORD
  PREPL_INFO_1003* = ptr REPL_INFO_1003
  LPREPL_INFO_1003* = ptr REPL_INFO_1003
  REPL_EDIR_INFO_0* {.pure.} = object
    rped0_dirname*: LPWSTR
  PREPL_EDIR_INFO_0* = ptr REPL_EDIR_INFO_0
  LPREPL_EDIR_INFO_0* = ptr REPL_EDIR_INFO_0
  REPL_EDIR_INFO_1* {.pure.} = object
    rped1_dirname*: LPWSTR
    rped1_integrity*: DWORD
    rped1_extent*: DWORD
  PREPL_EDIR_INFO_1* = ptr REPL_EDIR_INFO_1
  LPREPL_EDIR_INFO_1* = ptr REPL_EDIR_INFO_1
  REPL_EDIR_INFO_2* {.pure.} = object
    rped2_dirname*: LPWSTR
    rped2_integrity*: DWORD
    rped2_extent*: DWORD
    rped2_lockcount*: DWORD
    rped2_locktime*: DWORD
  PREPL_EDIR_INFO_2* = ptr REPL_EDIR_INFO_2
  LPREPL_EDIR_INFO_2* = ptr REPL_EDIR_INFO_2
  REPL_EDIR_INFO_1000* {.pure.} = object
    rped1000_integrity*: DWORD
  PREPL_EDIR_INFO_1000* = ptr REPL_EDIR_INFO_1000
  LPREPL_EDIR_INFO_1000* = ptr REPL_EDIR_INFO_1000
  REPL_EDIR_INFO_1001* {.pure.} = object
    rped1001_extent*: DWORD
  PREPL_EDIR_INFO_1001* = ptr REPL_EDIR_INFO_1001
  LPREPL_EDIR_INFO_1001* = ptr REPL_EDIR_INFO_1001
  REPL_IDIR_INFO_0* {.pure.} = object
    rpid0_dirname*: LPWSTR
  PREPL_IDIR_INFO_0* = ptr REPL_IDIR_INFO_0
  LPREPL_IDIR_INFO_0* = ptr REPL_IDIR_INFO_0
  REPL_IDIR_INFO_1* {.pure.} = object
    rpid1_dirname*: LPWSTR
    rpid1_state*: DWORD
    rpid1_mastername*: LPWSTR
    rpid1_last_update_time*: DWORD
    rpid1_lockcount*: DWORD
    rpid1_locktime*: DWORD
  PREPL_IDIR_INFO_1* = ptr REPL_IDIR_INFO_1
  LPREPL_IDIR_INFO_1* = ptr REPL_IDIR_INFO_1
  SERVER_INFO_100* {.pure.} = object
    sv100_platform_id*: DWORD
    sv100_name*: LMSTR
  PSERVER_INFO_100* = ptr SERVER_INFO_100
  LPSERVER_INFO_100* = ptr SERVER_INFO_100
  SERVER_INFO_101* {.pure.} = object
    sv101_platform_id*: DWORD
    sv101_name*: LMSTR
    sv101_version_major*: DWORD
    sv101_version_minor*: DWORD
    sv101_type*: DWORD
    sv101_comment*: LMSTR
  PSERVER_INFO_101* = ptr SERVER_INFO_101
  LPSERVER_INFO_101* = ptr SERVER_INFO_101
  SERVER_INFO_102* {.pure.} = object
    sv102_platform_id*: DWORD
    sv102_name*: LMSTR
    sv102_version_major*: DWORD
    sv102_version_minor*: DWORD
    sv102_type*: DWORD
    sv102_comment*: LMSTR
    sv102_users*: DWORD
    sv102_disc*: LONG
    sv102_hidden*: WINBOOL
    sv102_announce*: DWORD
    sv102_anndelta*: DWORD
    sv102_licenses*: DWORD
    sv102_userpath*: LMSTR
  PSERVER_INFO_102* = ptr SERVER_INFO_102
  LPSERVER_INFO_102* = ptr SERVER_INFO_102
  SERVER_INFO_402* {.pure.} = object
    sv402_ulist_mtime*: DWORD
    sv402_glist_mtime*: DWORD
    sv402_alist_mtime*: DWORD
    sv402_alerts*: LMSTR
    sv402_security*: DWORD
    sv402_numadmin*: DWORD
    sv402_lanmask*: DWORD
    sv402_guestacct*: LMSTR
    sv402_chdevs*: DWORD
    sv402_chdevq*: DWORD
    sv402_chdevjobs*: DWORD
    sv402_connections*: DWORD
    sv402_shares*: DWORD
    sv402_openfiles*: DWORD
    sv402_sessopens*: DWORD
    sv402_sessvcs*: DWORD
    sv402_sessreqs*: DWORD
    sv402_opensearch*: DWORD
    sv402_activelocks*: DWORD
    sv402_numreqbuf*: DWORD
    sv402_sizreqbuf*: DWORD
    sv402_numbigbuf*: DWORD
    sv402_numfiletasks*: DWORD
    sv402_alertsched*: DWORD
    sv402_erroralert*: DWORD
    sv402_logonalert*: DWORD
    sv402_accessalert*: DWORD
    sv402_diskalert*: DWORD
    sv402_netioalert*: DWORD
    sv402_maxauditsz*: DWORD
    sv402_srvheuristics*: LMSTR
  PSERVER_INFO_402* = ptr SERVER_INFO_402
  LPSERVER_INFO_402* = ptr SERVER_INFO_402
  SERVER_INFO_403* {.pure.} = object
    sv403_ulist_mtime*: DWORD
    sv403_glist_mtime*: DWORD
    sv403_alist_mtime*: DWORD
    sv403_alerts*: LMSTR
    sv403_security*: DWORD
    sv403_numadmin*: DWORD
    sv403_lanmask*: DWORD
    sv403_guestacct*: LMSTR
    sv403_chdevs*: DWORD
    sv403_chdevq*: DWORD
    sv403_chdevjobs*: DWORD
    sv403_connections*: DWORD
    sv403_shares*: DWORD
    sv403_openfiles*: DWORD
    sv403_sessopens*: DWORD
    sv403_sessvcs*: DWORD
    sv403_sessreqs*: DWORD
    sv403_opensearch*: DWORD
    sv403_activelocks*: DWORD
    sv403_numreqbuf*: DWORD
    sv403_sizreqbuf*: DWORD
    sv403_numbigbuf*: DWORD
    sv403_numfiletasks*: DWORD
    sv403_alertsched*: DWORD
    sv403_erroralert*: DWORD
    sv403_logonalert*: DWORD
    sv403_accessalert*: DWORD
    sv403_diskalert*: DWORD
    sv403_netioalert*: DWORD
    sv403_maxauditsz*: DWORD
    sv403_srvheuristics*: LMSTR
    sv403_auditedevents*: DWORD
    sv403_autoprofile*: DWORD
    sv403_autopath*: LMSTR
  PSERVER_INFO_403* = ptr SERVER_INFO_403
  LPSERVER_INFO_403* = ptr SERVER_INFO_403
  SERVER_INFO_502* {.pure.} = object
    sv502_sessopens*: DWORD
    sv502_sessvcs*: DWORD
    sv502_opensearch*: DWORD
    sv502_sizreqbuf*: DWORD
    sv502_initworkitems*: DWORD
    sv502_maxworkitems*: DWORD
    sv502_rawworkitems*: DWORD
    sv502_irpstacksize*: DWORD
    sv502_maxrawbuflen*: DWORD
    sv502_sessusers*: DWORD
    sv502_sessconns*: DWORD
    sv502_maxpagedmemoryusage*: DWORD
    sv502_maxnonpagedmemoryusage*: DWORD
    sv502_enablesoftcompat*: WINBOOL
    sv502_enableforcedlogoff*: WINBOOL
    sv502_timesource*: WINBOOL
    sv502_acceptdownlevelapis*: WINBOOL
    sv502_lmannounce*: WINBOOL
  PSERVER_INFO_502* = ptr SERVER_INFO_502
  LPSERVER_INFO_502* = ptr SERVER_INFO_502
  SERVER_INFO_503* {.pure.} = object
    sv503_sessopens*: DWORD
    sv503_sessvcs*: DWORD
    sv503_opensearch*: DWORD
    sv503_sizreqbuf*: DWORD
    sv503_initworkitems*: DWORD
    sv503_maxworkitems*: DWORD
    sv503_rawworkitems*: DWORD
    sv503_irpstacksize*: DWORD
    sv503_maxrawbuflen*: DWORD
    sv503_sessusers*: DWORD
    sv503_sessconns*: DWORD
    sv503_maxpagedmemoryusage*: DWORD
    sv503_maxnonpagedmemoryusage*: DWORD
    sv503_enablesoftcompat*: WINBOOL
    sv503_enableforcedlogoff*: WINBOOL
    sv503_timesource*: WINBOOL
    sv503_acceptdownlevelapis*: WINBOOL
    sv503_lmannounce*: WINBOOL
    sv503_domain*: LMSTR
    sv503_maxcopyreadlen*: DWORD
    sv503_maxcopywritelen*: DWORD
    sv503_minkeepsearch*: DWORD
    sv503_maxkeepsearch*: DWORD
    sv503_minkeepcomplsearch*: DWORD
    sv503_maxkeepcomplsearch*: DWORD
    sv503_threadcountadd*: DWORD
    sv503_numblockthreads*: DWORD
    sv503_scavtimeout*: DWORD
    sv503_minrcvqueue*: DWORD
    sv503_minfreeworkitems*: DWORD
    sv503_xactmemsize*: DWORD
    sv503_threadpriority*: DWORD
    sv503_maxmpxct*: DWORD
    sv503_oplockbreakwait*: DWORD
    sv503_oplockbreakresponsewait*: DWORD
    sv503_enableoplocks*: WINBOOL
    sv503_enableoplockforceclose*: WINBOOL
    sv503_enablefcbopens*: WINBOOL
    sv503_enableraw*: WINBOOL
    sv503_enablesharednetdrives*: WINBOOL
    sv503_minfreeconnections*: DWORD
    sv503_maxfreeconnections*: DWORD
  PSERVER_INFO_503* = ptr SERVER_INFO_503
  LPSERVER_INFO_503* = ptr SERVER_INFO_503
  SERVER_INFO_599* {.pure.} = object
    sv599_sessopens*: DWORD
    sv599_sessvcs*: DWORD
    sv599_opensearch*: DWORD
    sv599_sizreqbuf*: DWORD
    sv599_initworkitems*: DWORD
    sv599_maxworkitems*: DWORD
    sv599_rawworkitems*: DWORD
    sv599_irpstacksize*: DWORD
    sv599_maxrawbuflen*: DWORD
    sv599_sessusers*: DWORD
    sv599_sessconns*: DWORD
    sv599_maxpagedmemoryusage*: DWORD
    sv599_maxnonpagedmemoryusage*: DWORD
    sv599_enablesoftcompat*: WINBOOL
    sv599_enableforcedlogoff*: WINBOOL
    sv599_timesource*: WINBOOL
    sv599_acceptdownlevelapis*: WINBOOL
    sv599_lmannounce*: WINBOOL
    sv599_domain*: LMSTR
    sv599_maxcopyreadlen*: DWORD
    sv599_maxcopywritelen*: DWORD
    sv599_minkeepsearch*: DWORD
    sv599_maxkeepsearch*: DWORD
    sv599_minkeepcomplsearch*: DWORD
    sv599_maxkeepcomplsearch*: DWORD
    sv599_threadcountadd*: DWORD
    sv599_numblockthreads*: DWORD
    sv599_scavtimeout*: DWORD
    sv599_minrcvqueue*: DWORD
    sv599_minfreeworkitems*: DWORD
    sv599_xactmemsize*: DWORD
    sv599_threadpriority*: DWORD
    sv599_maxmpxct*: DWORD
    sv599_oplockbreakwait*: DWORD
    sv599_oplockbreakresponsewait*: DWORD
    sv599_enableoplocks*: WINBOOL
    sv599_enableoplockforceclose*: WINBOOL
    sv599_enablefcbopens*: WINBOOL
    sv599_enableraw*: WINBOOL
    sv599_enablesharednetdrives*: WINBOOL
    sv599_minfreeconnections*: DWORD
    sv599_maxfreeconnections*: DWORD
    sv599_initsesstable*: DWORD
    sv599_initconntable*: DWORD
    sv599_initfiletable*: DWORD
    sv599_initsearchtable*: DWORD
    sv599_alertschedule*: DWORD
    sv599_errorthreshold*: DWORD
    sv599_networkerrorthreshold*: DWORD
    sv599_diskspacethreshold*: DWORD
    sv599_reserved*: DWORD
    sv599_maxlinkdelay*: DWORD
    sv599_minlinkthroughput*: DWORD
    sv599_linkinfovalidtime*: DWORD
    sv599_scavqosinfoupdatetime*: DWORD
    sv599_maxworkitemidletime*: DWORD
  PSERVER_INFO_599* = ptr SERVER_INFO_599
  LPSERVER_INFO_599* = ptr SERVER_INFO_599
  SERVER_INFO_598* {.pure.} = object
    sv598_maxrawworkitems*: DWORD
    sv598_maxthreadsperqueue*: DWORD
    sv598_producttype*: DWORD
    sv598_serversize*: DWORD
    sv598_connectionlessautodisc*: DWORD
    sv598_sharingviolationretries*: DWORD
    sv598_sharingviolationdelay*: DWORD
    sv598_maxglobalopensearch*: DWORD
    sv598_removeduplicatesearches*: DWORD
    sv598_lockviolationoffset*: DWORD
    sv598_lockviolationdelay*: DWORD
    sv598_mdlreadswitchover*: DWORD
    sv598_cachedopenlimit*: DWORD
    sv598_otherqueueaffinity*: DWORD
    sv598_restrictnullsessaccess*: WINBOOL
    sv598_enablewfw311directipx*: WINBOOL
    sv598_queuesamplesecs*: DWORD
    sv598_balancecount*: DWORD
    sv598_preferredaffinity*: DWORD
    sv598_maxfreerfcbs*: DWORD
    sv598_maxfreemfcbs*: DWORD
    sv598_maxfreelfcbs*: DWORD
    sv598_maxfreepagedpoolchunks*: DWORD
    sv598_minpagedpoolchunksize*: DWORD
    sv598_maxpagedpoolchunksize*: DWORD
    sv598_sendsfrompreferredprocessor*: WINBOOL
    sv598_cacheddirectorylimit*: DWORD
    sv598_maxcopylength*: DWORD
    sv598_enablecompression*: WINBOOL
    sv598_autosharewks*: WINBOOL
    sv598_autoshareserver*: WINBOOL
    sv598_enablesecuritysignature*: WINBOOL
    sv598_requiresecuritysignature*: WINBOOL
    sv598_minclientbuffersize*: DWORD
    sv598_serverguid*: GUID
    sv598_ConnectionNoSessionsTimeout*: DWORD
    sv598_IdleThreadTimeOut*: DWORD
    sv598_enableW9xsecuritysignature*: WINBOOL
    sv598_enforcekerberosreauthentication*: WINBOOL
    sv598_disabledos*: WINBOOL
    sv598_lowdiskspaceminimum*: DWORD
    sv598_disablestrictnamechecking*: WINBOOL
  PSERVER_INFO_598* = ptr SERVER_INFO_598
  LPSERVER_INFO_598* = ptr SERVER_INFO_598
  SERVER_INFO_1005* {.pure.} = object
    sv1005_comment*: LMSTR
  PSERVER_INFO_1005* = ptr SERVER_INFO_1005
  LPSERVER_INFO_1005* = ptr SERVER_INFO_1005
  SERVER_INFO_1107* {.pure.} = object
    sv1107_users*: DWORD
  PSERVER_INFO_1107* = ptr SERVER_INFO_1107
  LPSERVER_INFO_1107* = ptr SERVER_INFO_1107
  SERVER_INFO_1010* {.pure.} = object
    sv1010_disc*: LONG
  PSERVER_INFO_1010* = ptr SERVER_INFO_1010
  LPSERVER_INFO_1010* = ptr SERVER_INFO_1010
  SERVER_INFO_1016* {.pure.} = object
    sv1016_hidden*: WINBOOL
  PSERVER_INFO_1016* = ptr SERVER_INFO_1016
  LPSERVER_INFO_1016* = ptr SERVER_INFO_1016
  SERVER_INFO_1017* {.pure.} = object
    sv1017_announce*: DWORD
  PSERVER_INFO_1017* = ptr SERVER_INFO_1017
  LPSERVER_INFO_1017* = ptr SERVER_INFO_1017
  SERVER_INFO_1018* {.pure.} = object
    sv1018_anndelta*: DWORD
  PSERVER_INFO_1018* = ptr SERVER_INFO_1018
  LPSERVER_INFO_1018* = ptr SERVER_INFO_1018
  SERVER_INFO_1501* {.pure.} = object
    sv1501_sessopens*: DWORD
  PSERVER_INFO_1501* = ptr SERVER_INFO_1501
  LPSERVER_INFO_1501* = ptr SERVER_INFO_1501
  SERVER_INFO_1502* {.pure.} = object
    sv1502_sessvcs*: DWORD
  PSERVER_INFO_1502* = ptr SERVER_INFO_1502
  LPSERVER_INFO_1502* = ptr SERVER_INFO_1502
  SERVER_INFO_1503* {.pure.} = object
    sv1503_opensearch*: DWORD
  PSERVER_INFO_1503* = ptr SERVER_INFO_1503
  LPSERVER_INFO_1503* = ptr SERVER_INFO_1503
  SERVER_INFO_1506* {.pure.} = object
    sv1506_maxworkitems*: DWORD
  PSERVER_INFO_1506* = ptr SERVER_INFO_1506
  LPSERVER_INFO_1506* = ptr SERVER_INFO_1506
  SERVER_INFO_1509* {.pure.} = object
    sv1509_maxrawbuflen*: DWORD
  PSERVER_INFO_1509* = ptr SERVER_INFO_1509
  LPSERVER_INFO_1509* = ptr SERVER_INFO_1509
  SERVER_INFO_1510* {.pure.} = object
    sv1510_sessusers*: DWORD
  PSERVER_INFO_1510* = ptr SERVER_INFO_1510
  LPSERVER_INFO_1510* = ptr SERVER_INFO_1510
  SERVER_INFO_1511* {.pure.} = object
    sv1511_sessconns*: DWORD
  PSERVER_INFO_1511* = ptr SERVER_INFO_1511
  LPSERVER_INFO_1511* = ptr SERVER_INFO_1511
  SERVER_INFO_1512* {.pure.} = object
    sv1512_maxnonpagedmemoryusage*: DWORD
  PSERVER_INFO_1512* = ptr SERVER_INFO_1512
  LPSERVER_INFO_1512* = ptr SERVER_INFO_1512
  SERVER_INFO_1513* {.pure.} = object
    sv1513_maxpagedmemoryusage*: DWORD
  PSERVER_INFO_1513* = ptr SERVER_INFO_1513
  LPSERVER_INFO_1513* = ptr SERVER_INFO_1513
  SERVER_INFO_1514* {.pure.} = object
    sv1514_enablesoftcompat*: WINBOOL
  PSERVER_INFO_1514* = ptr SERVER_INFO_1514
  LPSERVER_INFO_1514* = ptr SERVER_INFO_1514
  SERVER_INFO_1515* {.pure.} = object
    sv1515_enableforcedlogoff*: WINBOOL
  PSERVER_INFO_1515* = ptr SERVER_INFO_1515
  LPSERVER_INFO_1515* = ptr SERVER_INFO_1515
  SERVER_INFO_1516* {.pure.} = object
    sv1516_timesource*: WINBOOL
  PSERVER_INFO_1516* = ptr SERVER_INFO_1516
  LPSERVER_INFO_1516* = ptr SERVER_INFO_1516
  SERVER_INFO_1518* {.pure.} = object
    sv1518_lmannounce*: WINBOOL
  PSERVER_INFO_1518* = ptr SERVER_INFO_1518
  LPSERVER_INFO_1518* = ptr SERVER_INFO_1518
  SERVER_INFO_1520* {.pure.} = object
    sv1520_maxcopyreadlen*: DWORD
  PSERVER_INFO_1520* = ptr SERVER_INFO_1520
  LPSERVER_INFO_1520* = ptr SERVER_INFO_1520
  SERVER_INFO_1521* {.pure.} = object
    sv1521_maxcopywritelen*: DWORD
  PSERVER_INFO_1521* = ptr SERVER_INFO_1521
  LPSERVER_INFO_1521* = ptr SERVER_INFO_1521
  SERVER_INFO_1522* {.pure.} = object
    sv1522_minkeepsearch*: DWORD
  PSERVER_INFO_1522* = ptr SERVER_INFO_1522
  LPSERVER_INFO_1522* = ptr SERVER_INFO_1522
  SERVER_INFO_1523* {.pure.} = object
    sv1523_maxkeepsearch*: DWORD
  PSERVER_INFO_1523* = ptr SERVER_INFO_1523
  LPSERVER_INFO_1523* = ptr SERVER_INFO_1523
  SERVER_INFO_1524* {.pure.} = object
    sv1524_minkeepcomplsearch*: DWORD
  PSERVER_INFO_1524* = ptr SERVER_INFO_1524
  LPSERVER_INFO_1524* = ptr SERVER_INFO_1524
  SERVER_INFO_1525* {.pure.} = object
    sv1525_maxkeepcomplsearch*: DWORD
  PSERVER_INFO_1525* = ptr SERVER_INFO_1525
  LPSERVER_INFO_1525* = ptr SERVER_INFO_1525
  SERVER_INFO_1528* {.pure.} = object
    sv1528_scavtimeout*: DWORD
  PSERVER_INFO_1528* = ptr SERVER_INFO_1528
  LPSERVER_INFO_1528* = ptr SERVER_INFO_1528
  SERVER_INFO_1529* {.pure.} = object
    sv1529_minrcvqueue*: DWORD
  PSERVER_INFO_1529* = ptr SERVER_INFO_1529
  LPSERVER_INFO_1529* = ptr SERVER_INFO_1529
  SERVER_INFO_1530* {.pure.} = object
    sv1530_minfreeworkitems*: DWORD
  PSERVER_INFO_1530* = ptr SERVER_INFO_1530
  LPSERVER_INFO_1530* = ptr SERVER_INFO_1530
  SERVER_INFO_1533* {.pure.} = object
    sv1533_maxmpxct*: DWORD
  PSERVER_INFO_1533* = ptr SERVER_INFO_1533
  LPSERVER_INFO_1533* = ptr SERVER_INFO_1533
  SERVER_INFO_1534* {.pure.} = object
    sv1534_oplockbreakwait*: DWORD
  PSERVER_INFO_1534* = ptr SERVER_INFO_1534
  LPSERVER_INFO_1534* = ptr SERVER_INFO_1534
  SERVER_INFO_1535* {.pure.} = object
    sv1535_oplockbreakresponsewait*: DWORD
  PSERVER_INFO_1535* = ptr SERVER_INFO_1535
  LPSERVER_INFO_1535* = ptr SERVER_INFO_1535
  SERVER_INFO_1536* {.pure.} = object
    sv1536_enableoplocks*: WINBOOL
  PSERVER_INFO_1536* = ptr SERVER_INFO_1536
  LPSERVER_INFO_1536* = ptr SERVER_INFO_1536
  SERVER_INFO_1537* {.pure.} = object
    sv1537_enableoplockforceclose*: WINBOOL
  PSERVER_INFO_1537* = ptr SERVER_INFO_1537
  LPSERVER_INFO_1537* = ptr SERVER_INFO_1537
  SERVER_INFO_1538* {.pure.} = object
    sv1538_enablefcbopens*: WINBOOL
  PSERVER_INFO_1538* = ptr SERVER_INFO_1538
  LPSERVER_INFO_1538* = ptr SERVER_INFO_1538
  SERVER_INFO_1539* {.pure.} = object
    sv1539_enableraw*: WINBOOL
  PSERVER_INFO_1539* = ptr SERVER_INFO_1539
  LPSERVER_INFO_1539* = ptr SERVER_INFO_1539
  SERVER_INFO_1540* {.pure.} = object
    sv1540_enablesharednetdrives*: WINBOOL
  PSERVER_INFO_1540* = ptr SERVER_INFO_1540
  LPSERVER_INFO_1540* = ptr SERVER_INFO_1540
  SERVER_INFO_1541* {.pure.} = object
    sv1541_minfreeconnections*: WINBOOL
  PSERVER_INFO_1541* = ptr SERVER_INFO_1541
  LPSERVER_INFO_1541* = ptr SERVER_INFO_1541
  SERVER_INFO_1542* {.pure.} = object
    sv1542_maxfreeconnections*: WINBOOL
  PSERVER_INFO_1542* = ptr SERVER_INFO_1542
  LPSERVER_INFO_1542* = ptr SERVER_INFO_1542
  SERVER_INFO_1543* {.pure.} = object
    sv1543_initsesstable*: DWORD
  PSERVER_INFO_1543* = ptr SERVER_INFO_1543
  LPSERVER_INFO_1543* = ptr SERVER_INFO_1543
  SERVER_INFO_1544* {.pure.} = object
    sv1544_initconntable*: DWORD
  PSERVER_INFO_1544* = ptr SERVER_INFO_1544
  LPSERVER_INFO_1544* = ptr SERVER_INFO_1544
  SERVER_INFO_1545* {.pure.} = object
    sv1545_initfiletable*: DWORD
  PSERVER_INFO_1545* = ptr SERVER_INFO_1545
  LPSERVER_INFO_1545* = ptr SERVER_INFO_1545
  SERVER_INFO_1546* {.pure.} = object
    sv1546_initsearchtable*: DWORD
  PSERVER_INFO_1546* = ptr SERVER_INFO_1546
  LPSERVER_INFO_1546* = ptr SERVER_INFO_1546
  SERVER_INFO_1547* {.pure.} = object
    sv1547_alertschedule*: DWORD
  PSERVER_INFO_1547* = ptr SERVER_INFO_1547
  LPSERVER_INFO_1547* = ptr SERVER_INFO_1547
  SERVER_INFO_1548* {.pure.} = object
    sv1548_errorthreshold*: DWORD
  PSERVER_INFO_1548* = ptr SERVER_INFO_1548
  LPSERVER_INFO_1548* = ptr SERVER_INFO_1548
  SERVER_INFO_1549* {.pure.} = object
    sv1549_networkerrorthreshold*: DWORD
  PSERVER_INFO_1549* = ptr SERVER_INFO_1549
  LPSERVER_INFO_1549* = ptr SERVER_INFO_1549
  SERVER_INFO_1550* {.pure.} = object
    sv1550_diskspacethreshold*: DWORD
  PSERVER_INFO_1550* = ptr SERVER_INFO_1550
  LPSERVER_INFO_1550* = ptr SERVER_INFO_1550
  SERVER_INFO_1552* {.pure.} = object
    sv1552_maxlinkdelay*: DWORD
  PSERVER_INFO_1552* = ptr SERVER_INFO_1552
  LPSERVER_INFO_1552* = ptr SERVER_INFO_1552
  SERVER_INFO_1553* {.pure.} = object
    sv1553_minlinkthroughput*: DWORD
  PSERVER_INFO_1553* = ptr SERVER_INFO_1553
  LPSERVER_INFO_1553* = ptr SERVER_INFO_1553
  SERVER_INFO_1554* {.pure.} = object
    sv1554_linkinfovalidtime*: DWORD
  PSERVER_INFO_1554* = ptr SERVER_INFO_1554
  LPSERVER_INFO_1554* = ptr SERVER_INFO_1554
  SERVER_INFO_1555* {.pure.} = object
    sv1555_scavqosinfoupdatetime*: DWORD
  PSERVER_INFO_1555* = ptr SERVER_INFO_1555
  LPSERVER_INFO_1555* = ptr SERVER_INFO_1555
  SERVER_INFO_1556* {.pure.} = object
    sv1556_maxworkitemidletime*: DWORD
  PSERVER_INFO_1556* = ptr SERVER_INFO_1556
  LPSERVER_INFO_1556* = ptr SERVER_INFO_1556
  SERVER_INFO_1557* {.pure.} = object
    sv1557_maxrawworkitems*: DWORD
  PSERVER_INFO_1557* = ptr SERVER_INFO_1557
  LPSERVER_INFO_1557* = ptr SERVER_INFO_1557
  SERVER_INFO_1560* {.pure.} = object
    sv1560_producttype*: DWORD
  PSERVER_INFO_1560* = ptr SERVER_INFO_1560
  LPSERVER_INFO_1560* = ptr SERVER_INFO_1560
  SERVER_INFO_1561* {.pure.} = object
    sv1561_serversize*: DWORD
  PSERVER_INFO_1561* = ptr SERVER_INFO_1561
  LPSERVER_INFO_1561* = ptr SERVER_INFO_1561
  SERVER_INFO_1562* {.pure.} = object
    sv1562_connectionlessautodisc*: DWORD
  PSERVER_INFO_1562* = ptr SERVER_INFO_1562
  LPSERVER_INFO_1562* = ptr SERVER_INFO_1562
  SERVER_INFO_1563* {.pure.} = object
    sv1563_sharingviolationretries*: DWORD
  PSERVER_INFO_1563* = ptr SERVER_INFO_1563
  LPSERVER_INFO_1563* = ptr SERVER_INFO_1563
  SERVER_INFO_1564* {.pure.} = object
    sv1564_sharingviolationdelay*: DWORD
  PSERVER_INFO_1564* = ptr SERVER_INFO_1564
  LPSERVER_INFO_1564* = ptr SERVER_INFO_1564
  SERVER_INFO_1565* {.pure.} = object
    sv1565_maxglobalopensearch*: DWORD
  PSERVER_INFO_1565* = ptr SERVER_INFO_1565
  LPSERVER_INFO_1565* = ptr SERVER_INFO_1565
  SERVER_INFO_1566* {.pure.} = object
    sv1566_removeduplicatesearches*: WINBOOL
  PSERVER_INFO_1566* = ptr SERVER_INFO_1566
  LPSERVER_INFO_1566* = ptr SERVER_INFO_1566
  SERVER_INFO_1567* {.pure.} = object
    sv1567_lockviolationretries*: DWORD
  PSERVER_INFO_1567* = ptr SERVER_INFO_1567
  LPSERVER_INFO_1567* = ptr SERVER_INFO_1567
  SERVER_INFO_1568* {.pure.} = object
    sv1568_lockviolationoffset*: DWORD
  PSERVER_INFO_1568* = ptr SERVER_INFO_1568
  LPSERVER_INFO_1568* = ptr SERVER_INFO_1568
  SERVER_INFO_1569* {.pure.} = object
    sv1569_lockviolationdelay*: DWORD
  PSERVER_INFO_1569* = ptr SERVER_INFO_1569
  LPSERVER_INFO_1569* = ptr SERVER_INFO_1569
  SERVER_INFO_1570* {.pure.} = object
    sv1570_mdlreadswitchover*: DWORD
  PSERVER_INFO_1570* = ptr SERVER_INFO_1570
  LPSERVER_INFO_1570* = ptr SERVER_INFO_1570
  SERVER_INFO_1571* {.pure.} = object
    sv1571_cachedopenlimit*: DWORD
  PSERVER_INFO_1571* = ptr SERVER_INFO_1571
  LPSERVER_INFO_1571* = ptr SERVER_INFO_1571
  SERVER_INFO_1572* {.pure.} = object
    sv1572_criticalthreads*: DWORD
  PSERVER_INFO_1572* = ptr SERVER_INFO_1572
  LPSERVER_INFO_1572* = ptr SERVER_INFO_1572
  SERVER_INFO_1573* {.pure.} = object
    sv1573_restrictnullsessaccess*: DWORD
  PSERVER_INFO_1573* = ptr SERVER_INFO_1573
  LPSERVER_INFO_1573* = ptr SERVER_INFO_1573
  SERVER_INFO_1574* {.pure.} = object
    sv1574_enablewfw311directipx*: DWORD
  PSERVER_INFO_1574* = ptr SERVER_INFO_1574
  LPSERVER_INFO_1574* = ptr SERVER_INFO_1574
  SERVER_INFO_1575* {.pure.} = object
    sv1575_otherqueueaffinity*: DWORD
  PSERVER_INFO_1575* = ptr SERVER_INFO_1575
  LPSERVER_INFO_1575* = ptr SERVER_INFO_1575
  SERVER_INFO_1576* {.pure.} = object
    sv1576_queuesamplesecs*: DWORD
  PSERVER_INFO_1576* = ptr SERVER_INFO_1576
  LPSERVER_INFO_1576* = ptr SERVER_INFO_1576
  SERVER_INFO_1577* {.pure.} = object
    sv1577_balancecount*: DWORD
  PSERVER_INFO_1577* = ptr SERVER_INFO_1577
  LPSERVER_INFO_1577* = ptr SERVER_INFO_1577
  SERVER_INFO_1578* {.pure.} = object
    sv1578_preferredaffinity*: DWORD
  PSERVER_INFO_1578* = ptr SERVER_INFO_1578
  LPSERVER_INFO_1578* = ptr SERVER_INFO_1578
  SERVER_INFO_1579* {.pure.} = object
    sv1579_maxfreerfcbs*: DWORD
  PSERVER_INFO_1579* = ptr SERVER_INFO_1579
  LPSERVER_INFO_1579* = ptr SERVER_INFO_1579
  SERVER_INFO_1580* {.pure.} = object
    sv1580_maxfreemfcbs*: DWORD
  PSERVER_INFO_1580* = ptr SERVER_INFO_1580
  LPSERVER_INFO_1580* = ptr SERVER_INFO_1580
  SERVER_INFO_1581* {.pure.} = object
    sv1581_maxfreemlcbs*: DWORD
  PSERVER_INFO_1581* = ptr SERVER_INFO_1581
  LPSERVER_INFO_1581* = ptr SERVER_INFO_1581
  SERVER_INFO_1582* {.pure.} = object
    sv1582_maxfreepagedpoolchunks*: DWORD
  PSERVER_INFO_1582* = ptr SERVER_INFO_1582
  LPSERVER_INFO_1582* = ptr SERVER_INFO_1582
  SERVER_INFO_1583* {.pure.} = object
    sv1583_minpagedpoolchunksize*: DWORD
  PSERVER_INFO_1583* = ptr SERVER_INFO_1583
  LPSERVER_INFO_1583* = ptr SERVER_INFO_1583
  SERVER_INFO_1584* {.pure.} = object
    sv1584_maxpagedpoolchunksize*: DWORD
  PSERVER_INFO_1584* = ptr SERVER_INFO_1584
  LPSERVER_INFO_1584* = ptr SERVER_INFO_1584
  SERVER_INFO_1585* {.pure.} = object
    sv1585_sendsfrompreferredprocessor*: WINBOOL
  PSERVER_INFO_1585* = ptr SERVER_INFO_1585
  LPSERVER_INFO_1585* = ptr SERVER_INFO_1585
  SERVER_INFO_1586* {.pure.} = object
    sv1586_maxthreadsperqueue*: DWORD
  PSERVER_INFO_1586* = ptr SERVER_INFO_1586
  LPSERVER_INFO_1586* = ptr SERVER_INFO_1586
  SERVER_INFO_1587* {.pure.} = object
    sv1587_cacheddirectorylimit*: DWORD
  PSERVER_INFO_1587* = ptr SERVER_INFO_1587
  LPSERVER_INFO_1587* = ptr SERVER_INFO_1587
  SERVER_INFO_1588* {.pure.} = object
    sv1588_maxcopylength*: DWORD
  PSERVER_INFO_1588* = ptr SERVER_INFO_1588
  LPSERVER_INFO_1588* = ptr SERVER_INFO_1588
  SERVER_INFO_1590* {.pure.} = object
    sv1590_enablecompression*: DWORD
  PSERVER_INFO_1590* = ptr SERVER_INFO_1590
  LPSERVER_INFO_1590* = ptr SERVER_INFO_1590
  SERVER_INFO_1591* {.pure.} = object
    sv1591_autosharewks*: DWORD
  PSERVER_INFO_1591* = ptr SERVER_INFO_1591
  LPSERVER_INFO_1591* = ptr SERVER_INFO_1591
  SERVER_INFO_1592* {.pure.} = object
    sv1592_autosharewks*: DWORD
  PSERVER_INFO_1592* = ptr SERVER_INFO_1592
  LPSERVER_INFO_1592* = ptr SERVER_INFO_1592
  SERVER_INFO_1593* {.pure.} = object
    sv1593_enablesecuritysignature*: DWORD
  PSERVER_INFO_1593* = ptr SERVER_INFO_1593
  LPSERVER_INFO_1593* = ptr SERVER_INFO_1593
  SERVER_INFO_1594* {.pure.} = object
    sv1594_requiresecuritysignature*: DWORD
  PSERVER_INFO_1594* = ptr SERVER_INFO_1594
  LPSERVER_INFO_1594* = ptr SERVER_INFO_1594
  SERVER_INFO_1595* {.pure.} = object
    sv1595_minclientbuffersize*: DWORD
  PSERVER_INFO_1595* = ptr SERVER_INFO_1595
  LPSERVER_INFO_1595* = ptr SERVER_INFO_1595
  SERVER_INFO_1596* {.pure.} = object
    sv1596_ConnectionNoSessionsTimeout*: DWORD
  PSERVER_INFO_1596* = ptr SERVER_INFO_1596
  LPSERVER_INFO_1596* = ptr SERVER_INFO_1596
  SERVER_INFO_1597* {.pure.} = object
    sv1597_IdleThreadTimeOut*: DWORD
  PSERVER_INFO_1597* = ptr SERVER_INFO_1597
  LPSERVER_INFO_1597* = ptr SERVER_INFO_1597
  SERVER_INFO_1598* {.pure.} = object
    sv1598_enableW9xsecuritysignature*: DWORD
  PSERVER_INFO_1598* = ptr SERVER_INFO_1598
  LPSERVER_INFO_1598* = ptr SERVER_INFO_1598
  SERVER_INFO_1599* {.pure.} = object
    sv1598_enforcekerberosreauthentication*: BOOLEAN
  PSERVER_INFO_1599* = ptr SERVER_INFO_1599
  LPSERVER_INFO_1599* = ptr SERVER_INFO_1599
  SERVER_INFO_1600* {.pure.} = object
    sv1598_disabledos*: BOOLEAN
  PSERVER_INFO_1600* = ptr SERVER_INFO_1600
  LPSERVER_INFO_1600* = ptr SERVER_INFO_1600
  SERVER_INFO_1601* {.pure.} = object
    sv1598_lowdiskspaceminimum*: DWORD
  PSERVER_INFO_1601* = ptr SERVER_INFO_1601
  LPSERVER_INFO_1601* = ptr SERVER_INFO_1601
  SERVER_INFO_1602* {.pure.} = object
    sv_1598_disablestrictnamechecking*: WINBOOL
  PSERVER_INFO_1602* = ptr SERVER_INFO_1602
  LPSERVER_INFO_1602* = ptr SERVER_INFO_1602
  SERVER_TRANSPORT_INFO_0* {.pure.} = object
    svti0_numberofvcs*: DWORD
    svti0_transportname*: LMSTR
    svti0_transportaddress*: LPBYTE
    svti0_transportaddresslength*: DWORD
    svti0_networkaddress*: LMSTR
  PSERVER_TRANSPORT_INFO_0* = ptr SERVER_TRANSPORT_INFO_0
  LPSERVER_TRANSPORT_INFO_0* = ptr SERVER_TRANSPORT_INFO_0
  SERVER_TRANSPORT_INFO_1* {.pure.} = object
    svti1_numberofvcs*: DWORD
    svti1_transportname*: LMSTR
    svti1_transportaddress*: LPBYTE
    svti1_transportaddresslength*: DWORD
    svti1_networkaddress*: LMSTR
    svti1_domain*: LMSTR
  PSERVER_TRANSPORT_INFO_1* = ptr SERVER_TRANSPORT_INFO_1
  LPSERVER_TRANSPORT_INFO_1* = ptr SERVER_TRANSPORT_INFO_1
  SERVER_TRANSPORT_INFO_2* {.pure.} = object
    svti2_numberofvcs*: DWORD
    svti2_transportname*: LMSTR
    svti2_transportaddress*: LPBYTE
    svti2_transportaddresslength*: DWORD
    svti2_networkaddress*: LMSTR
    svti2_domain*: LMSTR
    svti2_flags*: ULONG
  PSERVER_TRANSPORT_INFO_2* = ptr SERVER_TRANSPORT_INFO_2
  LPSERVER_TRANSPORT_INFO_2* = ptr SERVER_TRANSPORT_INFO_2
  SERVER_TRANSPORT_INFO_3* {.pure.} = object
    svti3_numberofvcs*: DWORD
    svti3_transportname*: LMSTR
    svti3_transportaddress*: LPBYTE
    svti3_transportaddresslength*: DWORD
    svti3_networkaddress*: LMSTR
    svti3_domain*: LMSTR
    svti3_flags*: ULONG
    svti3_passwordlength*: DWORD
    svti3_password*: array[256 , BYTE]
  PSERVER_TRANSPORT_INFO_3* = ptr SERVER_TRANSPORT_INFO_3
  LPSERVER_TRANSPORT_INFO_3* = ptr SERVER_TRANSPORT_INFO_3
  SERVICE_INFO_0* {.pure.} = object
    svci0_name*: LPWSTR
  PSERVICE_INFO_0* = ptr SERVICE_INFO_0
  LPSERVICE_INFO_0* = ptr SERVICE_INFO_0
  SERVICE_INFO_1* {.pure.} = object
    svci1_name*: LPWSTR
    svci1_status*: DWORD
    svci1_code*: DWORD
    svci1_pid*: DWORD
  PSERVICE_INFO_1* = ptr SERVICE_INFO_1
  LPSERVICE_INFO_1* = ptr SERVICE_INFO_1
  SERVICE_INFO_2* {.pure.} = object
    svci2_name*: LPWSTR
    svci2_status*: DWORD
    svci2_code*: DWORD
    svci2_pid*: DWORD
    svci2_text*: LPWSTR
    svci2_specific_error*: DWORD
    svci2_display_name*: LPWSTR
  PSERVICE_INFO_2* = ptr SERVICE_INFO_2
  LPSERVICE_INFO_2* = ptr SERVICE_INFO_2
  USE_INFO_0* {.pure.} = object
    ui0_local*: LMSTR
    ui0_remote*: LMSTR
  PUSE_INFO_0* = ptr USE_INFO_0
  LPUSE_INFO_0* = ptr USE_INFO_0
  USE_INFO_1* {.pure.} = object
    ui1_local*: LMSTR
    ui1_remote*: LMSTR
    ui1_password*: LMSTR
    ui1_status*: DWORD
    ui1_asg_type*: DWORD
    ui1_refcount*: DWORD
    ui1_usecount*: DWORD
  PUSE_INFO_1* = ptr USE_INFO_1
  LPUSE_INFO_1* = ptr USE_INFO_1
  USE_INFO_2* {.pure.} = object
    ui2_local*: LMSTR
    ui2_remote*: LMSTR
    ui2_password*: LMSTR
    ui2_status*: DWORD
    ui2_asg_type*: DWORD
    ui2_refcount*: DWORD
    ui2_usecount*: DWORD
    ui2_username*: LMSTR
    ui2_domainname*: LMSTR
  PUSE_INFO_2* = ptr USE_INFO_2
  LPUSE_INFO_2* = ptr USE_INFO_2
  USE_INFO_3* {.pure.} = object
    ui3_ui2*: USE_INFO_2
    ui3_flags*: ULONG
  PUSE_INFO_3* = ptr USE_INFO_3
  LPUSE_INFO_3* = ptr USE_INFO_3
  WKSTA_INFO_100* {.pure.} = object
    wki100_platform_id*: DWORD
    wki100_computername*: LMSTR
    wki100_langroup*: LMSTR
    wki100_ver_major*: DWORD
    wki100_ver_minor*: DWORD
  PWKSTA_INFO_100* = ptr WKSTA_INFO_100
  LPWKSTA_INFO_100* = ptr WKSTA_INFO_100
  WKSTA_INFO_101* {.pure.} = object
    wki101_platform_id*: DWORD
    wki101_computername*: LMSTR
    wki101_langroup*: LMSTR
    wki101_ver_major*: DWORD
    wki101_ver_minor*: DWORD
    wki101_lanroot*: LMSTR
  PWKSTA_INFO_101* = ptr WKSTA_INFO_101
  LPWKSTA_INFO_101* = ptr WKSTA_INFO_101
  WKSTA_INFO_102* {.pure.} = object
    wki102_platform_id*: DWORD
    wki102_computername*: LMSTR
    wki102_langroup*: LMSTR
    wki102_ver_major*: DWORD
    wki102_ver_minor*: DWORD
    wki102_lanroot*: LMSTR
    wki102_logged_on_users*: DWORD
  PWKSTA_INFO_102* = ptr WKSTA_INFO_102
  LPWKSTA_INFO_102* = ptr WKSTA_INFO_102
  WKSTA_INFO_302* {.pure.} = object
    wki302_char_wait*: DWORD
    wki302_collection_time*: DWORD
    wki302_maximum_collection_count*: DWORD
    wki302_keep_conn*: DWORD
    wki302_keep_search*: DWORD
    wki302_max_cmds*: DWORD
    wki302_num_work_buf*: DWORD
    wki302_siz_work_buf*: DWORD
    wki302_max_wrk_cache*: DWORD
    wki302_sess_timeout*: DWORD
    wki302_siz_error*: DWORD
    wki302_num_alerts*: DWORD
    wki302_num_services*: DWORD
    wki302_errlog_sz*: DWORD
    wki302_print_buf_time*: DWORD
    wki302_num_char_buf*: DWORD
    wki302_siz_char_buf*: DWORD
    wki302_wrk_heuristics*: LMSTR
    wki302_mailslots*: DWORD
    wki302_num_dgram_buf*: DWORD
  PWKSTA_INFO_302* = ptr WKSTA_INFO_302
  LPWKSTA_INFO_302* = ptr WKSTA_INFO_302
  WKSTA_INFO_402* {.pure.} = object
    wki402_char_wait*: DWORD
    wki402_collection_time*: DWORD
    wki402_maximum_collection_count*: DWORD
    wki402_keep_conn*: DWORD
    wki402_keep_search*: DWORD
    wki402_max_cmds*: DWORD
    wki402_num_work_buf*: DWORD
    wki402_siz_work_buf*: DWORD
    wki402_max_wrk_cache*: DWORD
    wki402_sess_timeout*: DWORD
    wki402_siz_error*: DWORD
    wki402_num_alerts*: DWORD
    wki402_num_services*: DWORD
    wki402_errlog_sz*: DWORD
    wki402_print_buf_time*: DWORD
    wki402_num_char_buf*: DWORD
    wki402_siz_char_buf*: DWORD
    wki402_wrk_heuristics*: LMSTR
    wki402_mailslots*: DWORD
    wki402_num_dgram_buf*: DWORD
    wki402_max_threads*: DWORD
  PWKSTA_INFO_402* = ptr WKSTA_INFO_402
  LPWKSTA_INFO_402* = ptr WKSTA_INFO_402
  WKSTA_INFO_502* {.pure.} = object
    wki502_char_wait*: DWORD
    wki502_collection_time*: DWORD
    wki502_maximum_collection_count*: DWORD
    wki502_keep_conn*: DWORD
    wki502_max_cmds*: DWORD
    wki502_sess_timeout*: DWORD
    wki502_siz_char_buf*: DWORD
    wki502_max_threads*: DWORD
    wki502_lock_quota*: DWORD
    wki502_lock_increment*: DWORD
    wki502_lock_maximum*: DWORD
    wki502_pipe_increment*: DWORD
    wki502_pipe_maximum*: DWORD
    wki502_cache_file_timeout*: DWORD
    wki502_dormant_file_limit*: DWORD
    wki502_read_ahead_throughput*: DWORD
    wki502_num_mailslot_buffers*: DWORD
    wki502_num_srv_announce_buffers*: DWORD
    wki502_max_illegal_datagram_events*: DWORD
    wki502_illegal_datagram_event_reset_frequency*: DWORD
    wki502_log_election_packets*: WINBOOL
    wki502_use_opportunistic_locking*: WINBOOL
    wki502_use_unlock_behind*: WINBOOL
    wki502_use_close_behind*: WINBOOL
    wki502_buf_named_pipes*: WINBOOL
    wki502_use_lock_read_unlock*: WINBOOL
    wki502_utilize_nt_caching*: WINBOOL
    wki502_use_raw_read*: WINBOOL
    wki502_use_raw_write*: WINBOOL
    wki502_use_write_raw_data*: WINBOOL
    wki502_use_encryption*: WINBOOL
    wki502_buf_files_deny_write*: WINBOOL
    wki502_buf_read_only_files*: WINBOOL
    wki502_force_core_create_mode*: WINBOOL
    wki502_use_512_byte_max_transfer*: WINBOOL
  PWKSTA_INFO_502* = ptr WKSTA_INFO_502
  LPWKSTA_INFO_502* = ptr WKSTA_INFO_502
  WKSTA_INFO_1010* {.pure.} = object
    wki1010_char_wait*: DWORD
  PWKSTA_INFO_1010* = ptr WKSTA_INFO_1010
  LPWKSTA_INFO_1010* = ptr WKSTA_INFO_1010
  WKSTA_INFO_1011* {.pure.} = object
    wki1011_collection_time*: DWORD
  PWKSTA_INFO_1011* = ptr WKSTA_INFO_1011
  LPWKSTA_INFO_1011* = ptr WKSTA_INFO_1011
  WKSTA_INFO_1012* {.pure.} = object
    wki1012_maximum_collection_count*: DWORD
  PWKSTA_INFO_1012* = ptr WKSTA_INFO_1012
  LPWKSTA_INFO_1012* = ptr WKSTA_INFO_1012
  WKSTA_INFO_1027* {.pure.} = object
    wki1027_errlog_sz*: DWORD
  PWKSTA_INFO_1027* = ptr WKSTA_INFO_1027
  LPWKSTA_INFO_1027* = ptr WKSTA_INFO_1027
  WKSTA_INFO_1028* {.pure.} = object
    wki1028_print_buf_time*: DWORD
  PWKSTA_INFO_1028* = ptr WKSTA_INFO_1028
  LPWKSTA_INFO_1028* = ptr WKSTA_INFO_1028
  WKSTA_INFO_1032* {.pure.} = object
    wki1032_wrk_heuristics*: DWORD
  PWKSTA_INFO_1032* = ptr WKSTA_INFO_1032
  LPWKSTA_INFO_1032* = ptr WKSTA_INFO_1032
  WKSTA_INFO_1013* {.pure.} = object
    wki1013_keep_conn*: DWORD
  PWKSTA_INFO_1013* = ptr WKSTA_INFO_1013
  LPWKSTA_INFO_1013* = ptr WKSTA_INFO_1013
  WKSTA_INFO_1018* {.pure.} = object
    wki1018_sess_timeout*: DWORD
  PWKSTA_INFO_1018* = ptr WKSTA_INFO_1018
  LPWKSTA_INFO_1018* = ptr WKSTA_INFO_1018
  WKSTA_INFO_1023* {.pure.} = object
    wki1023_siz_char_buf*: DWORD
  PWKSTA_INFO_1023* = ptr WKSTA_INFO_1023
  LPWKSTA_INFO_1023* = ptr WKSTA_INFO_1023
  WKSTA_INFO_1033* {.pure.} = object
    wki1033_max_threads*: DWORD
  PWKSTA_INFO_1033* = ptr WKSTA_INFO_1033
  LPWKSTA_INFO_1033* = ptr WKSTA_INFO_1033
  WKSTA_INFO_1041* {.pure.} = object
    wki1041_lock_quota*: DWORD
  PWKSTA_INFO_1041* = ptr WKSTA_INFO_1041
  LPWKSTA_INFO_1041* = ptr WKSTA_INFO_1041
  WKSTA_INFO_1042* {.pure.} = object
    wki1042_lock_increment*: DWORD
  PWKSTA_INFO_1042* = ptr WKSTA_INFO_1042
  LPWKSTA_INFO_1042* = ptr WKSTA_INFO_1042
  WKSTA_INFO_1043* {.pure.} = object
    wki1043_lock_maximum*: DWORD
  PWKSTA_INFO_1043* = ptr WKSTA_INFO_1043
  LPWKSTA_INFO_1043* = ptr WKSTA_INFO_1043
  WKSTA_INFO_1044* {.pure.} = object
    wki1044_pipe_increment*: DWORD
  PWKSTA_INFO_1044* = ptr WKSTA_INFO_1044
  LPWKSTA_INFO_1044* = ptr WKSTA_INFO_1044
  WKSTA_INFO_1045* {.pure.} = object
    wki1045_pipe_maximum*: DWORD
  PWKSTA_INFO_1045* = ptr WKSTA_INFO_1045
  LPWKSTA_INFO_1045* = ptr WKSTA_INFO_1045
  WKSTA_INFO_1046* {.pure.} = object
    wki1046_dormant_file_limit*: DWORD
  PWKSTA_INFO_1046* = ptr WKSTA_INFO_1046
  LPWKSTA_INFO_1046* = ptr WKSTA_INFO_1046
  WKSTA_INFO_1047* {.pure.} = object
    wki1047_cache_file_timeout*: DWORD
  PWKSTA_INFO_1047* = ptr WKSTA_INFO_1047
  LPWKSTA_INFO_1047* = ptr WKSTA_INFO_1047
  WKSTA_INFO_1048* {.pure.} = object
    wki1048_use_opportunistic_locking*: WINBOOL
  PWKSTA_INFO_1048* = ptr WKSTA_INFO_1048
  LPWKSTA_INFO_1048* = ptr WKSTA_INFO_1048
  WKSTA_INFO_1049* {.pure.} = object
    wki1049_use_unlock_behind*: WINBOOL
  PWKSTA_INFO_1049* = ptr WKSTA_INFO_1049
  LPWKSTA_INFO_1049* = ptr WKSTA_INFO_1049
  WKSTA_INFO_1050* {.pure.} = object
    wki1050_use_close_behind*: WINBOOL
  PWKSTA_INFO_1050* = ptr WKSTA_INFO_1050
  LPWKSTA_INFO_1050* = ptr WKSTA_INFO_1050
  WKSTA_INFO_1051* {.pure.} = object
    wki1051_buf_named_pipes*: WINBOOL
  PWKSTA_INFO_1051* = ptr WKSTA_INFO_1051
  LPWKSTA_INFO_1051* = ptr WKSTA_INFO_1051
  WKSTA_INFO_1052* {.pure.} = object
    wki1052_use_lock_read_unlock*: WINBOOL
  PWKSTA_INFO_1052* = ptr WKSTA_INFO_1052
  LPWKSTA_INFO_1052* = ptr WKSTA_INFO_1052
  WKSTA_INFO_1053* {.pure.} = object
    wki1053_utilize_nt_caching*: WINBOOL
  PWKSTA_INFO_1053* = ptr WKSTA_INFO_1053
  LPWKSTA_INFO_1053* = ptr WKSTA_INFO_1053
  WKSTA_INFO_1054* {.pure.} = object
    wki1054_use_raw_read*: WINBOOL
  PWKSTA_INFO_1054* = ptr WKSTA_INFO_1054
  LPWKSTA_INFO_1054* = ptr WKSTA_INFO_1054
  WKSTA_INFO_1055* {.pure.} = object
    wki1055_use_raw_write*: WINBOOL
  PWKSTA_INFO_1055* = ptr WKSTA_INFO_1055
  LPWKSTA_INFO_1055* = ptr WKSTA_INFO_1055
  WKSTA_INFO_1056* {.pure.} = object
    wki1056_use_write_raw_data*: WINBOOL
  PWKSTA_INFO_1056* = ptr WKSTA_INFO_1056
  LPWKSTA_INFO_1056* = ptr WKSTA_INFO_1056
  WKSTA_INFO_1057* {.pure.} = object
    wki1057_use_encryption*: WINBOOL
  PWKSTA_INFO_1057* = ptr WKSTA_INFO_1057
  LPWKSTA_INFO_1057* = ptr WKSTA_INFO_1057
  WKSTA_INFO_1058* {.pure.} = object
    wki1058_buf_files_deny_write*: WINBOOL
  PWKSTA_INFO_1058* = ptr WKSTA_INFO_1058
  LPWKSTA_INFO_1058* = ptr WKSTA_INFO_1058
  WKSTA_INFO_1059* {.pure.} = object
    wki1059_buf_read_only_files*: WINBOOL
  PWKSTA_INFO_1059* = ptr WKSTA_INFO_1059
  LPWKSTA_INFO_1059* = ptr WKSTA_INFO_1059
  WKSTA_INFO_1060* {.pure.} = object
    wki1060_force_core_create_mode*: WINBOOL
  PWKSTA_INFO_1060* = ptr WKSTA_INFO_1060
  LPWKSTA_INFO_1060* = ptr WKSTA_INFO_1060
  WKSTA_INFO_1061* {.pure.} = object
    wki1061_use_512_byte_max_transfer*: WINBOOL
  PWKSTA_INFO_1061* = ptr WKSTA_INFO_1061
  LPWKSTA_INFO_1061* = ptr WKSTA_INFO_1061
  WKSTA_INFO_1062* {.pure.} = object
    wki1062_read_ahead_throughput*: DWORD
  PWKSTA_INFO_1062* = ptr WKSTA_INFO_1062
  LPWKSTA_INFO_1062* = ptr WKSTA_INFO_1062
  WKSTA_USER_INFO_0* {.pure.} = object
    wkui0_username*: LMSTR
  PWKSTA_USER_INFO_0* = ptr WKSTA_USER_INFO_0
  LPWKSTA_USER_INFO_0* = ptr WKSTA_USER_INFO_0
  WKSTA_USER_INFO_1* {.pure.} = object
    wkui1_username*: LMSTR
    wkui1_logon_domain*: LMSTR
    wkui1_oth_domains*: LMSTR
    wkui1_logon_server*: LMSTR
  PWKSTA_USER_INFO_1* = ptr WKSTA_USER_INFO_1
  LPWKSTA_USER_INFO_1* = ptr WKSTA_USER_INFO_1
  WKSTA_USER_INFO_1101* {.pure.} = object
    wkui1101_oth_domains*: LMSTR
  PWKSTA_USER_INFO_1101* = ptr WKSTA_USER_INFO_1101
  LPWKSTA_USER_INFO_1101* = ptr WKSTA_USER_INFO_1101
  WKSTA_TRANSPORT_INFO_0* {.pure.} = object
    wkti0_quality_of_service*: DWORD
    wkti0_number_of_vcs*: DWORD
    wkti0_transport_name*: LMSTR
    wkti0_transport_address*: LMSTR
    wkti0_wan_ish*: WINBOOL
  PWKSTA_TRANSPORT_INFO_0* = ptr WKSTA_TRANSPORT_INFO_0
  LPWKSTA_TRANSPORT_INFO_0* = ptr WKSTA_TRANSPORT_INFO_0
  ERROR_LOG* {.pure.} = object
    el_len*: DWORD
    el_reserved*: DWORD
    el_time*: DWORD
    el_error*: DWORD
    el_name*: LPWSTR
    el_text*: LPWSTR
    el_data*: LPBYTE
    el_data_size*: DWORD
    el_nstrings*: DWORD
  PERROR_LOG* = ptr ERROR_LOG
  HLOG* {.pure.} = object
    time*: DWORD
    last_flags*: DWORD
    offset*: DWORD
    rec_offset*: DWORD
  PHLOG* = ptr HLOG
  LPHLOG* = ptr HLOG
  CONFIG_INFO_0* {.pure.} = object
    cfgi0_key*: LPWSTR
    cfgi0_data*: LPWSTR
  PCONFIG_INFO_0* = ptr CONFIG_INFO_0
  LPCONFIG_INFO_0* = ptr CONFIG_INFO_0
  STAT_WORKSTATION_0* {.pure.} = object
    StatisticsStartTime*: LARGE_INTEGER
    BytesReceived*: LARGE_INTEGER
    SmbsReceived*: LARGE_INTEGER
    PagingReadBytesRequested*: LARGE_INTEGER
    NonPagingReadBytesRequested*: LARGE_INTEGER
    CacheReadBytesRequested*: LARGE_INTEGER
    NetworkReadBytesRequested*: LARGE_INTEGER
    BytesTransmitted*: LARGE_INTEGER
    SmbsTransmitted*: LARGE_INTEGER
    PagingWriteBytesRequested*: LARGE_INTEGER
    NonPagingWriteBytesRequested*: LARGE_INTEGER
    CacheWriteBytesRequested*: LARGE_INTEGER
    NetworkWriteBytesRequested*: LARGE_INTEGER
    InitiallyFailedOperations*: DWORD
    FailedCompletionOperations*: DWORD
    ReadOperations*: DWORD
    RandomReadOperations*: DWORD
    ReadSmbs*: DWORD
    LargeReadSmbs*: DWORD
    SmallReadSmbs*: DWORD
    WriteOperations*: DWORD
    RandomWriteOperations*: DWORD
    WriteSmbs*: DWORD
    LargeWriteSmbs*: DWORD
    SmallWriteSmbs*: DWORD
    RawReadsDenied*: DWORD
    RawWritesDenied*: DWORD
    NetworkErrors*: DWORD
    Sessions*: DWORD
    FailedSessions*: DWORD
    Reconnects*: DWORD
    CoreConnects*: DWORD
    Lanman20Connects*: DWORD
    Lanman21Connects*: DWORD
    LanmanNtConnects*: DWORD
    ServerDisconnects*: DWORD
    HungSessions*: DWORD
    UseCount*: DWORD
    FailedUseCount*: DWORD
    CurrentCommands*: DWORD
  PSTAT_WORKSTATION_0* = ptr STAT_WORKSTATION_0
  LPSTAT_WORKSTATION_0* = ptr STAT_WORKSTATION_0
  STAT_SERVER_0* {.pure.} = object
    sts0_start*: DWORD
    sts0_fopens*: DWORD
    sts0_devopens*: DWORD
    sts0_jobsqueued*: DWORD
    sts0_sopens*: DWORD
    sts0_stimedout*: DWORD
    sts0_serrorout*: DWORD
    sts0_pwerrors*: DWORD
    sts0_permerrors*: DWORD
    sts0_syserrors*: DWORD
    sts0_bytessent_low*: DWORD
    sts0_bytessent_high*: DWORD
    sts0_bytesrcvd_low*: DWORD
    sts0_bytesrcvd_high*: DWORD
    sts0_avresponse*: DWORD
    sts0_reqbufneed*: DWORD
    sts0_bigbufneed*: DWORD
  PSTAT_SERVER_0* = ptr STAT_SERVER_0
  LPSTAT_SERVER_0* = ptr STAT_SERVER_0
  AUDIT_ENTRY* {.pure.} = object
    ae_len*: DWORD
    ae_reserved*: DWORD
    ae_time*: DWORD
    ae_type*: DWORD
    ae_data_offset*: DWORD
    ae_data_size*: DWORD
  PAUDIT_ENTRY* = ptr AUDIT_ENTRY
  LPAUDIT_ENTRY* = ptr AUDIT_ENTRY
  TAE_SRVSTATUS* {.pure.} = object
    ae_sv_status*: DWORD
  PAE_SRVSTATUS* = ptr TAE_SRVSTATUS
  LPAE_SRVSTATUS* = ptr TAE_SRVSTATUS
  TAE_SESSLOGON* {.pure.} = object
    ae_so_compname*: DWORD
    ae_so_username*: DWORD
    ae_so_privilege*: DWORD
  PAE_SESSLOGON* = ptr TAE_SESSLOGON
  LPAE_SESSLOGON* = ptr TAE_SESSLOGON
  TAE_SESSLOGOFF* {.pure.} = object
    ae_sf_compname*: DWORD
    ae_sf_username*: DWORD
    ae_sf_reason*: DWORD
  PAE_SESSLOGOFF* = ptr TAE_SESSLOGOFF
  LPAE_SESSLOGOFF* = ptr TAE_SESSLOGOFF
  TAE_SESSPWERR* {.pure.} = object
    ae_sp_compname*: DWORD
    ae_sp_username*: DWORD
  PAE_SESSPWERR* = ptr TAE_SESSPWERR
  LPAE_SESSPWERR* = ptr TAE_SESSPWERR
  TAE_CONNSTART* {.pure.} = object
    ae_ct_compname*: DWORD
    ae_ct_username*: DWORD
    ae_ct_netname*: DWORD
    ae_ct_connid*: DWORD
  PAE_CONNSTART* = ptr TAE_CONNSTART
  LPAE_CONNSTART* = ptr TAE_CONNSTART
  TAE_CONNSTOP* {.pure.} = object
    ae_cp_compname*: DWORD
    ae_cp_username*: DWORD
    ae_cp_netname*: DWORD
    ae_cp_connid*: DWORD
    ae_cp_reason*: DWORD
  PAE_CONNSTOP* = ptr TAE_CONNSTOP
  LPAE_CONNSTOP* = ptr TAE_CONNSTOP
  TAE_CONNREJ* {.pure.} = object
    ae_cr_compname*: DWORD
    ae_cr_username*: DWORD
    ae_cr_netname*: DWORD
    ae_cr_reason*: DWORD
  PAE_CONNREJ* = ptr TAE_CONNREJ
  LPAE_CONNREJ* = ptr TAE_CONNREJ
  TAE_RESACCESS* {.pure.} = object
    ae_ra_compname*: DWORD
    ae_ra_username*: DWORD
    ae_ra_resname*: DWORD
    ae_ra_operation*: DWORD
    ae_ra_returncode*: DWORD
    ae_ra_restype*: DWORD
    ae_ra_fileid*: DWORD
  PAE_RESACCESS* = ptr TAE_RESACCESS
  LPAE_RESACCESS* = ptr TAE_RESACCESS
  TAE_RESACCESSREJ* {.pure.} = object
    ae_rr_compname*: DWORD
    ae_rr_username*: DWORD
    ae_rr_resname*: DWORD
    ae_rr_operation*: DWORD
  PAE_RESACCESSREJ* = ptr TAE_RESACCESSREJ
  LPAE_RESACCESSREJ* = ptr TAE_RESACCESSREJ
  TAE_CLOSEFILE* {.pure.} = object
    ae_cf_compname*: DWORD
    ae_cf_username*: DWORD
    ae_cf_resname*: DWORD
    ae_cf_fileid*: DWORD
    ae_cf_duration*: DWORD
    ae_cf_reason*: DWORD
  PAE_CLOSEFILE* = ptr TAE_CLOSEFILE
  LPAE_CLOSEFILE* = ptr TAE_CLOSEFILE
  TAE_SERVICESTAT* {.pure.} = object
    ae_ss_compname*: DWORD
    ae_ss_username*: DWORD
    ae_ss_svcname*: DWORD
    ae_ss_status*: DWORD
    ae_ss_code*: DWORD
    ae_ss_text*: DWORD
    ae_ss_returnval*: DWORD
  PAE_SERVICESTAT* = ptr TAE_SERVICESTAT
  LPAE_SERVICESTAT* = ptr TAE_SERVICESTAT
  TAE_ACLMOD* {.pure.} = object
    ae_am_compname*: DWORD
    ae_am_username*: DWORD
    ae_am_resname*: DWORD
    ae_am_action*: DWORD
    ae_am_datalen*: DWORD
  PAE_ACLMOD* = ptr TAE_ACLMOD
  LPAE_ACLMOD* = ptr TAE_ACLMOD
  TAE_UASMOD* {.pure.} = object
    ae_um_compname*: DWORD
    ae_um_username*: DWORD
    ae_um_resname*: DWORD
    ae_um_rectype*: DWORD
    ae_um_action*: DWORD
    ae_um_datalen*: DWORD
  PAE_UASMOD* = ptr TAE_UASMOD
  LPAE_UASMOD* = ptr TAE_UASMOD
  TAE_NETLOGON* {.pure.} = object
    ae_no_compname*: DWORD
    ae_no_username*: DWORD
    ae_no_privilege*: DWORD
    ae_no_authflags*: DWORD
  PAE_NETLOGON* = ptr TAE_NETLOGON
  LPAE_NETLOGON* = ptr TAE_NETLOGON
  TAE_NETLOGOFF* {.pure.} = object
    ae_nf_compname*: DWORD
    ae_nf_username*: DWORD
    ae_nf_reserved1*: DWORD
    ae_nf_reserved2*: DWORD
  PAE_NETLOGOFF* = ptr TAE_NETLOGOFF
  LPAE_NETLOGOFF* = ptr TAE_NETLOGOFF
  AE_ACCLIM* {.pure.} = object
    ae_al_compname*: DWORD
    ae_al_username*: DWORD
    ae_al_resname*: DWORD
    ae_al_limit*: DWORD
  PAE_ACCLIM* = ptr AE_ACCLIM
  LPAE_ACCLIM* = ptr AE_ACCLIM
  TAE_LOCKOUT* {.pure.} = object
    ae_lk_compname*: DWORD
    ae_lk_username*: DWORD
    ae_lk_action*: DWORD
    ae_lk_bad_pw_count*: DWORD
  PAE_LOCKOUT* = ptr TAE_LOCKOUT
  LPAE_LOCKOUT* = ptr TAE_LOCKOUT
  AE_GENERIC* {.pure.} = object
    ae_ge_msgfile*: DWORD
    ae_ge_msgnum*: DWORD
    ae_ge_params*: DWORD
    ae_ge_param1*: DWORD
    ae_ge_param2*: DWORD
    ae_ge_param3*: DWORD
    ae_ge_param4*: DWORD
    ae_ge_param5*: DWORD
    ae_ge_param6*: DWORD
    ae_ge_param7*: DWORD
    ae_ge_param8*: DWORD
    ae_ge_param9*: DWORD
  PAE_GENERIC* = ptr AE_GENERIC
  LPAE_GENERIC* = ptr AE_GENERIC
  AT_INFO* {.pure.} = object
    JobTime*: DWORD_PTR
    DaysOfMonth*: DWORD
    DaysOfWeek*: UCHAR
    Flags*: UCHAR
    Command*: LPWSTR
  PAT_INFO* = ptr AT_INFO
  LPAT_INFO* = ptr AT_INFO
  AT_ENUM* {.pure.} = object
    JobId*: DWORD
    JobTime*: DWORD_PTR
    DaysOfMonth*: DWORD
    DaysOfWeek*: UCHAR
    Flags*: UCHAR
    Command*: LPWSTR
  PAT_ENUM* = ptr AT_ENUM
  LPAT_ENUM* = ptr AT_ENUM
  DFS_TARGET_PRIORITY* {.pure.} = object
    TargetPriorityClass*: DFS_TARGET_PRIORITY_CLASS
    TargetPriorityRank*: USHORT
    Reserved*: USHORT
  PDFS_TARGET_PRIORITY* = ptr DFS_TARGET_PRIORITY
  DFS_INFO_1* {.pure.} = object
    EntryPath*: LPWSTR
  PDFS_INFO_1* = ptr DFS_INFO_1
  LPDFS_INFO_1* = ptr DFS_INFO_1
  DFS_INFO_2* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    NumberOfStorages*: DWORD
  PDFS_INFO_2* = ptr DFS_INFO_2
  LPDFS_INFO_2* = ptr DFS_INFO_2
  DFS_STORAGE_INFO* {.pure.} = object
    State*: ULONG
    ServerName*: LPWSTR
    ShareName*: LPWSTR
  PDFS_STORAGE_INFO* = ptr DFS_STORAGE_INFO
  LPDFS_STORAGE_INFO* = ptr DFS_STORAGE_INFO
  DFS_STORAGE_INFO_1* {.pure.} = object
    State*: ULONG
    ServerName*: LPWSTR
    ShareName*: LPWSTR
    TargetPriority*: DFS_TARGET_PRIORITY
  PDFS_STORAGE_INFO_1* = ptr DFS_STORAGE_INFO_1
  LPDFS_STORAGE_INFO_1* = ptr DFS_STORAGE_INFO_1
  DFS_INFO_3* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    NumberOfStorages*: DWORD
    Storage*: LPDFS_STORAGE_INFO
  PDFS_INFO_3* = ptr DFS_INFO_3
  LPDFS_INFO_3* = ptr DFS_INFO_3
  DFS_INFO_4* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    Guid*: GUID
    NumberOfStorages*: DWORD
    Storage*: LPDFS_STORAGE_INFO
  PDFS_INFO_4* = ptr DFS_INFO_4
  LPDFS_INFO_4* = ptr DFS_INFO_4
  DFS_INFO_5* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    Guid*: GUID
    PropertyFlags*: ULONG
    MetadataSize*: ULONG
    NumberOfStorages*: DWORD
  PDFS_INFO_5* = ptr DFS_INFO_5
  LPDFS_INFO_5* = ptr DFS_INFO_5
  DFS_INFO_6* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    Guid*: GUID
    PropertyFlags*: ULONG
    MetadataSize*: ULONG
    NumberOfStorages*: DWORD
    Storage*: LPDFS_STORAGE_INFO_1
  PDFS_INFO_6* = ptr DFS_INFO_6
  LPDFS_INFO_6* = ptr DFS_INFO_6
  DFS_INFO_7* {.pure.} = object
    GenerationGuid*: GUID
  PDFS_INFO_7* = ptr DFS_INFO_7
  LPDFS_INFO_7* = ptr DFS_INFO_7
  DFS_INFO_100* {.pure.} = object
    Comment*: LPWSTR
  PDFS_INFO_100* = ptr DFS_INFO_100
  LPDFS_INFO_100* = ptr DFS_INFO_100
  DFS_INFO_101* {.pure.} = object
    State*: DWORD
  PDFS_INFO_101* = ptr DFS_INFO_101
  LPDFS_INFO_101* = ptr DFS_INFO_101
  DFS_INFO_102* {.pure.} = object
    Timeout*: ULONG
  PDFS_INFO_102* = ptr DFS_INFO_102
  LPDFS_INFO_102* = ptr DFS_INFO_102
  DFS_INFO_103* {.pure.} = object
    PropertyFlagMask*: ULONG
    PropertyFlags*: ULONG
  PDFS_INFO_103* = ptr DFS_INFO_103
  LPDFS_INFO_103* = ptr DFS_INFO_103
  DFS_INFO_104* {.pure.} = object
    TargetPriority*: DFS_TARGET_PRIORITY
  PDFS_INFO_104* = ptr DFS_INFO_104
  LPDFS_INFO_104* = ptr DFS_INFO_104
  DFS_INFO_105* {.pure.} = object
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    PropertyFlagMask*: ULONG
    PropertyFlags*: ULONG
  PDFS_INFO_105* = ptr DFS_INFO_105
  LPDFS_INFO_105* = ptr DFS_INFO_105
  DFS_INFO_106* {.pure.} = object
    State*: DWORD
    TargetPriority*: DFS_TARGET_PRIORITY
  PDFS_INFO_106* = ptr DFS_INFO_106
  LPDFS_INFO_106* = ptr DFS_INFO_106
  DFS_SUPPORTED_NAMESPACE_VERSION_INFO* {.pure.} = object
    DomainDfsMajorVersion*: ULONG
    NamespaceMinorVersion*: ULONG
    DomainDfsCapabilities*: ULONGLONG
    StandaloneDfsMajorVersion*: ULONG
    StandaloneDfsMinorVersion*: ULONG
    StandaloneDfsCapabilities*: ULONGLONG
  PDFS_SUPPORTED_NAMESPACE_VERSION_INFO* = ptr DFS_SUPPORTED_NAMESPACE_VERSION_INFO
  DFS_INFO_8* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    Guid*: GUID
    PropertyFlags*: ULONG
    MetadataSize*: ULONG
    SdLengthReserved*: ULONG
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    NumberOfStorages*: DWORD
  PDFS_INFO_8* = ptr DFS_INFO_8
  DFS_INFO_9* {.pure.} = object
    EntryPath*: LPWSTR
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    Guid*: GUID
    PropertyFlags*: ULONG
    MetadataSize*: ULONG
    SdLengthReserved*: ULONG
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
    NumberOfStorages*: DWORD
    Storage*: LPDFS_STORAGE_INFO_1
  PDFS_INFO_9* = ptr DFS_INFO_9
  DFS_INFO_50* {.pure.} = object
    NamespaceMajorVersion*: ULONG
    NamespaceMinorVersion*: ULONG
    NamespaceCapabilities*: ULONGLONG
  PDFS_INFO_50* = ptr DFS_INFO_50
  DFS_INFO_107* {.pure.} = object
    Comment*: LPWSTR
    State*: DWORD
    Timeout*: ULONG
    PropertyFlagMask*: ULONG
    PropertyFlags*: ULONG
    SdLengthReserved*: ULONG
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
  PDFS_INFO_107* = ptr DFS_INFO_107
  DFS_INFO_150* {.pure.} = object
    SdLengthReserved*: ULONG
    pSecurityDescriptor*: PSECURITY_DESCRIPTOR
  PDFS_INFO_150* = ptr DFS_INFO_150
  DFS_INFO_200* {.pure.} = object
    FtDfsName*: LPWSTR
  PDFS_INFO_200* = ptr DFS_INFO_200
  LPDFS_INFO_200* = ptr DFS_INFO_200
  DFS_INFO_300* {.pure.} = object
    Flags*: DWORD
    DfsName*: LPWSTR
  PDFS_INFO_300* = ptr DFS_INFO_300
  LPDFS_INFO_300* = ptr DFS_INFO_300
  DFS_SITENAME_INFO* {.pure.} = object
    SiteFlags*: ULONG
    SiteName*: LPWSTR
  PDFS_SITENAME_INFO* = ptr DFS_SITENAME_INFO
  LPDFS_SITENAME_INFO* = ptr DFS_SITENAME_INFO
  DFS_SITELIST_INFO* {.pure.} = object
    cSites*: ULONG
    Site*: array[1, DFS_SITENAME_INFO]
  PDFS_SITELIST_INFO* = ptr DFS_SITELIST_INFO
  LPDFS_SITELIST_INFO* = ptr DFS_SITELIST_INFO
  PORT_INFO_FFW* {.pure.} = object
    pName*: LPWSTR
    cbMonitorData*: DWORD
    pMonitorData*: LPBYTE
  PPORT_INFO_FFW* = ptr PORT_INFO_FFW
  LPPORT_INFO_FFW* = ptr PORT_INFO_FFW
  PORT_INFO_FFA* {.pure.} = object
    pName*: LPSTR
    cbMonitorData*: DWORD
    pMonitorData*: LPBYTE
  PPORT_INFO_FFA* = ptr PORT_INFO_FFA
  LPPORT_INFO_FFA* = ptr PORT_INFO_FFA
const
  CNLEN* = 15
  LM20_CNLEN* = 15
  DNLEN* = CNLEN
  LM20_DNLEN* = LM20_CNLEN
  UNCLEN* = CNLEN+2
  LM20_UNCLEN* = LM20_CNLEN+2
  NNLEN* = 80
  LM20_NNLEN* = 12
  RMLEN* = UNCLEN+1+NNLEN
  LM20_RMLEN* = LM20_UNCLEN+1+LM20_NNLEN
  LM20_SNLEN* = 15
  STXTLEN* = 256
  LM20_STXTLEN* = 63
  PATHLEN* = 256
  LM20_PATHLEN* = 256
  DEVLEN* = 80
  LM20_DEVLEN* = 8
  UNLEN* = 256
  LM20_UNLEN* = 20
  GNLEN* = UNLEN
  LM20_GNLEN* = LM20_UNLEN
  PWLEN* = 256
  LM20_PWLEN* = 14
  SHPWLEN* = 8
  CLTYPE_LEN* = 12
  MAXCOMMENTSZ* = 256
  LM20_MAXCOMMENTSZ* = 48
  QNLEN* = NNLEN
  LM20_QNLEN* = LM20_NNLEN
  ALERTSZ* = 128
  NETBIOS_NAME_LEN* = 16
  MAX_PREFERRED_LENGTH* = DWORD(-1)
  CRYPT_KEY_LEN* = 7
  CRYPT_TXT_LEN* = 8
  SESSION_PWLEN* = 24
  SESSION_CRYPT_KLEN* = 21
  PARMNUM_ALL* = 0
  PARM_ERROR_NONE* = 0
  PARMNUM_BASE_INFOLEVEL* = 1000
  MESSAGE_FILENAME* = "NETMSG"
  OS2MSG_FILENAME* = "BASE"
  HELP_MSG_FILENAME* = "NETH"
  BACKUP_MSG_FILENAME* = "BAK.MSG"
  PLATFORM_ID_DOS* = 300
  PLATFORM_ID_OS2* = 400
  PLATFORM_ID_NT* = 500
  PLATFORM_ID_OSF* = 600
  PLATFORM_ID_VMS* = 700
  NERR_BASE* = 2100
  MIN_LANMAN_MESSAGE_ID* = NERR_BASE
  MAX_LANMAN_MESSAGE_ID* = 5899
  NERR_Success* = 0
  NERR_NetNotStarted* = NERR_BASE+2
  NERR_UnknownServer* = NERR_BASE+3
  NERR_ShareMem* = NERR_BASE+4
  NERR_NoNetworkResource* = NERR_BASE+5
  NERR_RemoteOnly* = NERR_BASE+6
  NERR_DevNotRedirected* = NERR_BASE+7
  NERR_ServerNotStarted* = NERR_BASE+14
  NERR_ItemNotFound* = NERR_BASE+15
  NERR_UnknownDevDir* = NERR_BASE+16
  NERR_RedirectedPath* = NERR_BASE+17
  NERR_DuplicateShare* = NERR_BASE+18
  NERR_NoRoom* = NERR_BASE+19
  NERR_TooManyItems* = NERR_BASE+21
  NERR_InvalidMaxUsers* = NERR_BASE+22
  NERR_BufTooSmall* = NERR_BASE+23
  NERR_RemoteErr* = NERR_BASE+27
  NERR_LanmanIniError* = NERR_BASE+31
  NERR_NetworkError* = NERR_BASE+36
  NERR_WkstaInconsistentState* = NERR_BASE+37
  NERR_WkstaNotStarted* = NERR_BASE+38
  NERR_BrowserNotStarted* = NERR_BASE+39
  NERR_InternalError* = NERR_BASE+40
  NERR_BadTransactConfig* = NERR_BASE+41
  NERR_InvalidAPI* = NERR_BASE+42
  NERR_BadEventName* = NERR_BASE+43
  NERR_DupNameReboot* = NERR_BASE+44
  NERR_CfgCompNotFound* = NERR_BASE+46
  NERR_CfgParamNotFound* = NERR_BASE+47
  NERR_LineTooLong* = NERR_BASE+49
  NERR_QNotFound* = NERR_BASE+50
  NERR_JobNotFound* = NERR_BASE+51
  NERR_DestNotFound* = NERR_BASE+52
  NERR_DestExists* = NERR_BASE+53
  NERR_QExists* = NERR_BASE+54
  NERR_QNoRoom* = NERR_BASE+55
  NERR_JobNoRoom* = NERR_BASE+56
  NERR_DestNoRoom* = NERR_BASE+57
  NERR_DestIdle* = NERR_BASE+58
  NERR_DestInvalidOp* = NERR_BASE+59
  NERR_ProcNoRespond* = NERR_BASE+60
  NERR_SpoolerNotLoaded* = NERR_BASE+61
  NERR_DestInvalidState* = NERR_BASE+62
  NERR_QInvalidState* = NERR_BASE+63
  NERR_JobInvalidState* = NERR_BASE+64
  NERR_SpoolNoMemory* = NERR_BASE+65
  NERR_DriverNotFound* = NERR_BASE+66
  NERR_DataTypeInvalid* = NERR_BASE+67
  NERR_ProcNotFound* = NERR_BASE+68
  NERR_ServiceTableLocked* = NERR_BASE+80
  NERR_ServiceTableFull* = NERR_BASE+81
  NERR_ServiceInstalled* = NERR_BASE+82
  NERR_ServiceEntryLocked* = NERR_BASE+83
  NERR_ServiceNotInstalled* = NERR_BASE+84
  NERR_BadServiceName* = NERR_BASE+85
  NERR_ServiceCtlTimeout* = NERR_BASE+86
  NERR_ServiceCtlBusy* = NERR_BASE+87
  NERR_BadServiceProgName* = NERR_BASE+88
  NERR_ServiceNotCtrl* = NERR_BASE+89
  NERR_ServiceKillProc* = NERR_BASE+90
  NERR_ServiceCtlNotValid* = NERR_BASE+91
  NERR_NotInDispatchTbl* = NERR_BASE+92
  NERR_BadControlRecv* = NERR_BASE+93
  NERR_ServiceNotStarting* = NERR_BASE+94
  NERR_AlreadyLoggedOn* = NERR_BASE+100
  NERR_NotLoggedOn* = NERR_BASE+101
  NERR_BadUsername* = NERR_BASE+102
  NERR_BadPassword* = NERR_BASE+103
  NERR_UnableToAddName_W* = NERR_BASE+104
  NERR_UnableToAddName_F* = NERR_BASE+105
  NERR_UnableToDelName_W* = NERR_BASE+106
  NERR_UnableToDelName_F* = NERR_BASE+107
  NERR_LogonsPaused* = NERR_BASE+109
  NERR_LogonServerConflict* = NERR_BASE+110
  NERR_LogonNoUserPath* = NERR_BASE+111
  NERR_LogonScriptError* = NERR_BASE+112
  NERR_StandaloneLogon* = NERR_BASE+114
  NERR_LogonServerNotFound* = NERR_BASE+115
  NERR_LogonDomainExists* = NERR_BASE+116
  NERR_NonValidatedLogon* = NERR_BASE+117
  NERR_ACFNotFound* = NERR_BASE+119
  NERR_GroupNotFound* = NERR_BASE+120
  NERR_UserNotFound* = NERR_BASE+121
  NERR_ResourceNotFound* = NERR_BASE+122
  NERR_GroupExists* = NERR_BASE+123
  NERR_UserExists* = NERR_BASE+124
  NERR_ResourceExists* = NERR_BASE+125
  NERR_NotPrimary* = NERR_BASE+126
  NERR_ACFNotLoaded* = NERR_BASE+127
  NERR_ACFNoRoom* = NERR_BASE+128
  NERR_ACFFileIOFail* = NERR_BASE+129
  NERR_ACFTooManyLists* = NERR_BASE+130
  NERR_UserLogon* = NERR_BASE+131
  NERR_ACFNoParent* = NERR_BASE+132
  NERR_CanNotGrowSegment* = NERR_BASE+133
  NERR_SpeGroupOp* = NERR_BASE+134
  NERR_NotInCache* = NERR_BASE+135
  NERR_UserInGroup* = NERR_BASE+136
  NERR_UserNotInGroup* = NERR_BASE+137
  NERR_AccountUndefined* = NERR_BASE+138
  NERR_AccountExpired* = NERR_BASE+139
  NERR_InvalidWorkstation* = NERR_BASE+140
  NERR_InvalidLogonHours* = NERR_BASE+141
  NERR_PasswordExpired* = NERR_BASE+142
  NERR_PasswordCantChange* = NERR_BASE+143
  NERR_PasswordHistConflict* = NERR_BASE+144
  NERR_PasswordTooShort* = NERR_BASE+145
  NERR_PasswordTooRecent* = NERR_BASE+146
  NERR_InvalidDatabase* = NERR_BASE+147
  NERR_DatabaseUpToDate* = NERR_BASE+148
  NERR_SyncRequired* = NERR_BASE+149
  NERR_UseNotFound* = NERR_BASE+150
  NERR_BadAsgType* = NERR_BASE+151
  NERR_DeviceIsShared* = NERR_BASE+152
  NERR_NoComputerName* = NERR_BASE+170
  NERR_MsgAlreadyStarted* = NERR_BASE+171
  NERR_MsgInitFailed* = NERR_BASE+172
  NERR_NameNotFound* = NERR_BASE+173
  NERR_AlreadyForwarded* = NERR_BASE+174
  NERR_AddForwarded* = NERR_BASE+175
  NERR_AlreadyExists* = NERR_BASE+176
  NERR_TooManyNames* = NERR_BASE+177
  NERR_DelComputerName* = NERR_BASE+178
  NERR_LocalForward* = NERR_BASE+179
  NERR_GrpMsgProcessor* = NERR_BASE+180
  NERR_PausedRemote* = NERR_BASE+181
  NERR_BadReceive* = NERR_BASE+182
  NERR_NameInUse* = NERR_BASE+183
  NERR_MsgNotStarted* = NERR_BASE+184
  NERR_NotLocalName* = NERR_BASE+185
  NERR_NoForwardName* = NERR_BASE+186
  NERR_RemoteFull* = NERR_BASE+187
  NERR_NameNotForwarded* = NERR_BASE+188
  NERR_TruncatedBroadcast* = NERR_BASE+189
  NERR_InvalidDevice* = NERR_BASE+194
  NERR_WriteFault* = NERR_BASE+195
  NERR_DuplicateName* = NERR_BASE+197
  NERR_DeleteLater* = NERR_BASE+198
  NERR_IncompleteDel* = NERR_BASE+199
  NERR_MultipleNets* = NERR_BASE+200
  NERR_NetNameNotFound* = NERR_BASE+210
  NERR_DeviceNotShared* = NERR_BASE+211
  NERR_ClientNameNotFound* = NERR_BASE+212
  NERR_FileIdNotFound* = NERR_BASE+214
  NERR_ExecFailure* = NERR_BASE+215
  NERR_TmpFile* = NERR_BASE+216
  NERR_TooMuchData* = NERR_BASE+217
  NERR_DeviceShareConflict* = NERR_BASE+218
  NERR_BrowserTableIncomplete* = NERR_BASE+219
  NERR_NotLocalDomain* = NERR_BASE+220
  NERR_IsDfsShare* = NERR_BASE+221
  NERR_DevInvalidOpCode* = NERR_BASE+231
  NERR_DevNotFound* = NERR_BASE+232
  NERR_DevNotOpen* = NERR_BASE+233
  NERR_BadQueueDevString* = NERR_BASE+234
  NERR_BadQueuePriority* = NERR_BASE+235
  NERR_NoCommDevs* = NERR_BASE+237
  NERR_QueueNotFound* = NERR_BASE+238
  NERR_BadDevString* = NERR_BASE+240
  NERR_BadDev* = NERR_BASE+241
  NERR_InUseBySpooler* = NERR_BASE+242
  NERR_CommDevInUse* = NERR_BASE+243
  NERR_InvalidComputer* = NERR_BASE+251
  NERR_MaxLenExceeded* = NERR_BASE+254
  NERR_BadComponent* = NERR_BASE+256
  NERR_CantType* = NERR_BASE+257
  NERR_TooManyEntries* = NERR_BASE+262
  NERR_ProfileFileTooBig* = NERR_BASE+270
  NERR_ProfileOffset* = NERR_BASE+271
  NERR_ProfileCleanup* = NERR_BASE+272
  NERR_ProfileUnknownCmd* = NERR_BASE+273
  NERR_ProfileLoadErr* = NERR_BASE+274
  NERR_ProfileSaveErr* = NERR_BASE+275
  NERR_LogOverflow* = NERR_BASE+277
  NERR_LogFileChanged* = NERR_BASE+278
  NERR_LogFileCorrupt* = NERR_BASE+279
  NERR_SourceIsDir* = NERR_BASE+280
  NERR_BadSource* = NERR_BASE+281
  NERR_BadDest* = NERR_BASE+282
  NERR_DifferentServers* = NERR_BASE+283
  NERR_RunSrvPaused* = NERR_BASE+285
  NERR_ErrCommRunSrv* = NERR_BASE+289
  NERR_ErrorExecingGhost* = NERR_BASE+291
  NERR_ShareNotFound* = NERR_BASE+292
  NERR_InvalidLana* = NERR_BASE+300
  NERR_OpenFiles* = NERR_BASE+301
  NERR_ActiveConns* = NERR_BASE+302
  NERR_BadPasswordCore* = NERR_BASE+303
  NERR_DevInUse* = NERR_BASE+304
  NERR_LocalDrive* = NERR_BASE+305
  NERR_AlertExists* = NERR_BASE+330
  NERR_TooManyAlerts* = NERR_BASE+331
  NERR_NoSuchAlert* = NERR_BASE+332
  NERR_BadRecipient* = NERR_BASE+333
  NERR_AcctLimitExceeded* = NERR_BASE+334
  NERR_InvalidLogSeek* = NERR_BASE+340
  NERR_BadUasConfig* = NERR_BASE+350
  NERR_InvalidUASOp* = NERR_BASE+351
  NERR_LastAdmin* = NERR_BASE+352
  NERR_DCNotFound* = NERR_BASE+353
  NERR_LogonTrackingError* = NERR_BASE+354
  NERR_NetlogonNotStarted* = NERR_BASE+355
  NERR_CanNotGrowUASFile* = NERR_BASE+356
  NERR_TimeDiffAtDC* = NERR_BASE+357
  NERR_PasswordMismatch* = NERR_BASE+358
  NERR_NoSuchServer* = NERR_BASE+360
  NERR_NoSuchSession* = NERR_BASE+361
  NERR_NoSuchConnection* = NERR_BASE+362
  NERR_TooManyServers* = NERR_BASE+363
  NERR_TooManySessions* = NERR_BASE+364
  NERR_TooManyConnections* = NERR_BASE+365
  NERR_TooManyFiles* = NERR_BASE+366
  NERR_NoAlternateServers* = NERR_BASE+367
  NERR_TryDownLevel* = NERR_BASE+370
  NERR_UPSDriverNotStarted* = NERR_BASE+380
  NERR_UPSInvalidConfig* = NERR_BASE+381
  NERR_UPSInvalidCommPort* = NERR_BASE+382
  NERR_UPSSignalAsserted* = NERR_BASE+383
  NERR_UPSShutdownFailed* = NERR_BASE+384
  NERR_BadDosRetCode* = NERR_BASE+400
  NERR_ProgNeedsExtraMem* = NERR_BASE+401
  NERR_BadDosFunction* = NERR_BASE+402
  NERR_RemoteBootFailed* = NERR_BASE+403
  NERR_BadFileCheckSum* = NERR_BASE+404
  NERR_NoRplBootSystem* = NERR_BASE+405
  NERR_RplLoadrNetBiosErr* = NERR_BASE+406
  NERR_RplLoadrDiskErr* = NERR_BASE+407
  NERR_ImageParamErr* = NERR_BASE+408
  NERR_TooManyImageParams* = NERR_BASE+409
  NERR_NonDosFloppyUsed* = NERR_BASE+410
  NERR_RplBootRestart* = NERR_BASE+411
  NERR_RplSrvrCallFailed* = NERR_BASE+412
  NERR_CantConnectRplSrvr* = NERR_BASE+413
  NERR_CantOpenImageFile* = NERR_BASE+414
  NERR_CallingRplSrvr* = NERR_BASE+415
  NERR_StartingRplBoot* = NERR_BASE+416
  NERR_RplBootServiceTerm* = NERR_BASE+417
  NERR_RplBootStartFailed* = NERR_BASE+418
  NERR_RPL_CONNECTED* = NERR_BASE+419
  NERR_BrowserConfiguredToNotRun* = NERR_BASE+450
  NERR_RplNoAdaptersStarted* = NERR_BASE+510
  NERR_RplBadRegistry* = NERR_BASE+511
  NERR_RplBadDatabase* = NERR_BASE+512
  NERR_RplRplfilesShare* = NERR_BASE+513
  NERR_RplNotRplServer* = NERR_BASE+514
  NERR_RplCannotEnum* = NERR_BASE+515
  NERR_RplWkstaInfoCorrupted* = NERR_BASE+516
  NERR_RplWkstaNotFound* = NERR_BASE+517
  NERR_RplWkstaNameUnavailable* = NERR_BASE+518
  NERR_RplProfileInfoCorrupted* = NERR_BASE+519
  NERR_RplProfileNotFound* = NERR_BASE+520
  NERR_RplProfileNameUnavailable* = NERR_BASE+521
  NERR_RplProfileNotEmpty* = NERR_BASE+522
  NERR_RplConfigInfoCorrupted* = NERR_BASE+523
  NERR_RplConfigNotFound* = NERR_BASE+524
  NERR_RplAdapterInfoCorrupted* = NERR_BASE+525
  NERR_RplInternal* = NERR_BASE+526
  NERR_RplVendorInfoCorrupted* = NERR_BASE+527
  NERR_RplBootInfoCorrupted* = NERR_BASE+528
  NERR_RplWkstaNeedsUserAcct* = NERR_BASE+529
  NERR_RplNeedsRPLUSERAcct* = NERR_BASE+530
  NERR_RplBootNotFound* = NERR_BASE+531
  NERR_RplIncompatibleProfile* = NERR_BASE+532
  NERR_RplAdapterNameUnavailable* = NERR_BASE+533
  NERR_RplConfigNotEmpty* = NERR_BASE+534
  NERR_RplBootInUse* = NERR_BASE+535
  NERR_RplBackupDatabase* = NERR_BASE+536
  NERR_RplAdapterNotFound* = NERR_BASE+537
  NERR_RplVendorNotFound* = NERR_BASE+538
  NERR_RplVendorNameUnavailable* = NERR_BASE+539
  NERR_RplBootNameUnavailable* = NERR_BASE+540
  NERR_RplConfigNameUnavailable* = NERR_BASE+541
  NERR_DfsInternalCorruption* = NERR_BASE+560
  NERR_DfsVolumeDataCorrupt* = NERR_BASE+561
  NERR_DfsNoSuchVolume* = NERR_BASE+562
  NERR_DfsVolumeAlreadyExists* = NERR_BASE+563
  NERR_DfsAlreadyShared* = NERR_BASE+564
  NERR_DfsNoSuchShare* = NERR_BASE+565
  NERR_DfsNotALeafVolume* = NERR_BASE+566
  NERR_DfsLeafVolume* = NERR_BASE+567
  NERR_DfsVolumeHasMultipleServers* = NERR_BASE+568
  NERR_DfsCantCreateJunctionPoint* = NERR_BASE+569
  NERR_DfsServerNotDfsAware* = NERR_BASE+570
  NERR_DfsBadRenamePath* = NERR_BASE+571
  NERR_DfsVolumeIsOffline* = NERR_BASE+572
  NERR_DfsNoSuchServer* = NERR_BASE+573
  NERR_DfsCyclicalName* = NERR_BASE+574
  NERR_DfsNotSupportedInServerDfs* = NERR_BASE+575
  NERR_DfsDuplicateService* = NERR_BASE+576
  NERR_DfsCantRemoveLastServerShare* = NERR_BASE+577
  NERR_DfsVolumeIsInterDfs* = NERR_BASE+578
  NERR_DfsInconsistent* = NERR_BASE+579
  NERR_DfsServerUpgraded* = NERR_BASE+580
  NERR_DfsDataIsIdentical* = NERR_BASE+581
  NERR_DfsCantRemoveDfsRoot* = NERR_BASE+582
  NERR_DfsChildOrParentInDfs* = NERR_BASE+583
  NERR_DfsInternalError* = NERR_BASE+590
  NERR_SetupAlreadyJoined* = NERR_BASE+591
  NERR_SetupNotJoined* = NERR_BASE+592
  NERR_SetupDomainController* = NERR_BASE+593
  NERR_DefaultJoinRequired* = NERR_BASE+594
  NERR_InvalidWorkgroupName* = NERR_BASE+595
  NERR_NameUsesIncompatibleCodePage* = NERR_BASE+596
  NERR_ComputerAccountNotFound* = NERR_BASE+597
  NERR_PersonalSku* = NERR_BASE+598
  NERR_PasswordMustChange* = NERR_BASE+601
  NERR_AccountLockedOut* = NERR_BASE+602
  NERR_PasswordTooLong* = NERR_BASE+603
  NERR_PasswordNotComplexEnough* = NERR_BASE+604
  NERR_PasswordFilterError* = NERR_BASE+605
  MAX_NERR* = NERR_BASE+899
  UF_SCRIPT* = 0x0001
  UF_ACCOUNTDISABLE* = 0x0002
  UF_HOMEDIR_REQUIRED* = 0x0008
  UF_LOCKOUT* = 0x0010
  UF_PASSWD_NOTREQD* = 0x0020
  UF_PASSWD_CANT_CHANGE* = 0x0040
  UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED* = 0x0080
  UF_TEMP_DUPLICATE_ACCOUNT* = 0x0100
  UF_NORMAL_ACCOUNT* = 0x0200
  UF_INTERDOMAIN_TRUST_ACCOUNT* = 0x0800
  UF_WORKSTATION_TRUST_ACCOUNT* = 0x1000
  UF_SERVER_TRUST_ACCOUNT* = 0x2000
  UF_MACHINE_ACCOUNT_MASK* = UF_INTERDOMAIN_TRUST_ACCOUNT or UF_WORKSTATION_TRUST_ACCOUNT or UF_SERVER_TRUST_ACCOUNT
  UF_ACCOUNT_TYPE_MASK* = UF_TEMP_DUPLICATE_ACCOUNT or UF_NORMAL_ACCOUNT or UF_INTERDOMAIN_TRUST_ACCOUNT or UF_WORKSTATION_TRUST_ACCOUNT or UF_SERVER_TRUST_ACCOUNT
  UF_DONT_EXPIRE_PASSWD* = 0x10000
  UF_MNS_LOGON_ACCOUNT* = 0x20000
  UF_SMARTCARD_REQUIRED* = 0x40000
  UF_TRUSTED_FOR_DELEGATION* = 0x80000
  UF_NOT_DELEGATED* = 0x100000
  UF_USE_DES_KEY_ONLY* = 0x200000
  UF_DONT_REQUIRE_PREAUTH* = 0x400000
  UF_PASSWORD_EXPIRED* = 0x800000
  UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION* = 0x1000000
  UF_NO_AUTH_DATA_REQUIRED* = 0x2000000
  UF_SETTABLE_BITS* = UF_SCRIPT or UF_ACCOUNTDISABLE or UF_LOCKOUT or UF_HOMEDIR_REQUIRED or UF_PASSWD_NOTREQD or UF_PASSWD_CANT_CHANGE or UF_ACCOUNT_TYPE_MASK or UF_DONT_EXPIRE_PASSWD or UF_MNS_LOGON_ACCOUNT or UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED or UF_SMARTCARD_REQUIRED or UF_TRUSTED_FOR_DELEGATION or UF_NOT_DELEGATED or UF_USE_DES_KEY_ONLY or UF_DONT_REQUIRE_PREAUTH or UF_PASSWORD_EXPIRED or UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION or UF_NO_AUTH_DATA_REQUIRED
  FILTER_TEMP_DUPLICATE_ACCOUNT* = 0x0001
  FILTER_NORMAL_ACCOUNT* = 0x0002
  FILTER_INTERDOMAIN_TRUST_ACCOUNT* = 0x0008
  FILTER_WORKSTATION_TRUST_ACCOUNT* = 0x0010
  FILTER_SERVER_TRUST_ACCOUNT* = 0x0020
  LG_INCLUDE_INDIRECT* = 0x0001
  AF_OP_PRINT* = 0x1
  AF_OP_COMM* = 0x2
  AF_OP_SERVER* = 0x4
  AF_OP_ACCOUNTS* = 0x8
  AF_SETTABLE_BITS* = AF_OP_PRINT or AF_OP_COMM or AF_OP_SERVER or AF_OP_ACCOUNTS
  UAS_ROLE_STANDALONE* = 0
  UAS_ROLE_MEMBER* = 1
  UAS_ROLE_BACKUP* = 2
  UAS_ROLE_PRIMARY* = 3
  USER_NAME_PARMNUM* = 1
  USER_PASSWORD_PARMNUM* = 3
  USER_PASSWORD_AGE_PARMNUM* = 4
  USER_PRIV_PARMNUM* = 5
  USER_HOME_DIR_PARMNUM* = 6
  USER_COMMENT_PARMNUM* = 7
  USER_FLAGS_PARMNUM* = 8
  USER_SCRIPT_PATH_PARMNUM* = 9
  USER_AUTH_FLAGS_PARMNUM* = 10
  USER_FULL_NAME_PARMNUM* = 11
  USER_USR_COMMENT_PARMNUM* = 12
  USER_PARMS_PARMNUM* = 13
  USER_WORKSTATIONS_PARMNUM* = 14
  USER_LAST_LOGON_PARMNUM* = 15
  USER_LAST_LOGOFF_PARMNUM* = 16
  USER_ACCT_EXPIRES_PARMNUM* = 17
  USER_MAX_STORAGE_PARMNUM* = 18
  USER_UNITS_PER_WEEK_PARMNUM* = 19
  USER_LOGON_HOURS_PARMNUM* = 20
  USER_PAD_PW_COUNT_PARMNUM* = 21
  USER_NUM_LOGONS_PARMNUM* = 22
  USER_LOGON_SERVER_PARMNUM* = 23
  USER_COUNTRY_CODE_PARMNUM* = 24
  USER_CODE_PAGE_PARMNUM* = 25
  USER_PRIMARY_GROUP_PARMNUM* = 51
  USER_PROFILE* = 52
  USER_PROFILE_PARMNUM* = 52
  USER_HOME_DIR_DRIVE_PARMNUM* = 53
  USER_NAME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_NAME_PARMNUM
  USER_PASSWORD_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PASSWORD_PARMNUM
  USER_PASSWORD_AGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PASSWORD_AGE_PARMNUM
  USER_PRIV_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PRIV_PARMNUM
  USER_HOME_DIR_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_HOME_DIR_PARMNUM
  USER_COMMENT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_COMMENT_PARMNUM
  USER_FLAGS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_FLAGS_PARMNUM
  USER_SCRIPT_PATH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_SCRIPT_PATH_PARMNUM
  USER_AUTH_FLAGS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_AUTH_FLAGS_PARMNUM
  USER_FULL_NAME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_FULL_NAME_PARMNUM
  USER_USR_COMMENT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_USR_COMMENT_PARMNUM
  USER_PARMS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PARMS_PARMNUM
  USER_WORKSTATIONS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_WORKSTATIONS_PARMNUM
  USER_LAST_LOGON_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_LAST_LOGON_PARMNUM
  USER_LAST_LOGOFF_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_LAST_LOGOFF_PARMNUM
  USER_ACCT_EXPIRES_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_ACCT_EXPIRES_PARMNUM
  USER_MAX_STORAGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_MAX_STORAGE_PARMNUM
  USER_UNITS_PER_WEEK_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_UNITS_PER_WEEK_PARMNUM
  USER_LOGON_HOURS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_LOGON_HOURS_PARMNUM
  USER_PAD_PW_COUNT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PAD_PW_COUNT_PARMNUM
  USER_NUM_LOGONS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_NUM_LOGONS_PARMNUM
  USER_LOGON_SERVER_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_LOGON_SERVER_PARMNUM
  USER_COUNTRY_CODE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_COUNTRY_CODE_PARMNUM
  USER_CODE_PAGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_CODE_PAGE_PARMNUM
  USER_PRIMARY_GROUP_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_PRIMARY_GROUP_PARMNUM
  USER_HOME_DIR_DRIVE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+USER_HOME_DIR_DRIVE_PARMNUM
  NULL_USERSETINFO_PASSWD* = "              "
  TIMEQ_FOREVER* = -1
  USER_MAXSTORAGE_UNLIMITED* = -1
  USER_NO_LOGOFF* = -1
  UNITS_PER_DAY* = 24
  UNITS_PER_WEEK* = UNITS_PER_DAY*7
  USER_PRIV_MASK* = 0x3
  USER_PRIV_GUEST* = 0
  USER_PRIV_USER* = 1
  USER_PRIV_ADMIN* = 2
  MAX_PASSWD_LEN* = PWLEN
  DEF_MIN_PWLEN* = 6
  DEF_PWUNIQUENESS* = 5
  DEF_MAX_PWHIST* = 8
  DEF_MAX_PWAGE* = TIMEQ_FOREVER
  DEF_MIN_PWAGE* = 0
  DEF_FORCE_LOGOFF* = 0xffffffff'i32
  DEF_MAX_BADPW* = 0
  ONE_DAY* = 01*24*3600
  VALIDATED_LOGON* = 0
  PASSWORD_EXPIRED* = 2
  NON_VALIDATED_LOGON* = 3
  VALID_LOGOFF* = 1
  MODALS_MIN_PASSWD_LEN_PARMNUM* = 1
  MODALS_MAX_PASSWD_AGE_PARMNUM* = 2
  MODALS_MIN_PASSWD_AGE_PARMNUM* = 3
  MODALS_FORCE_LOGOFF_PARMNUM* = 4
  MODALS_PASSWD_HIST_LEN_PARMNUM* = 5
  MODALS_ROLE_PARMNUM* = 6
  MODALS_PRIMARY_PARMNUM* = 7
  MODALS_DOMAIN_NAME_PARMNUM* = 8
  MODALS_DOMAIN_ID_PARMNUM* = 9
  MODALS_LOCKOUT_DURATION_PARMNUM* = 10
  MODALS_LOCKOUT_OBSERVATION_WINDOW_PARMNUM* = 11
  MODALS_LOCKOUT_THRESHOLD_PARMNUM* = 12
  MODALS_MIN_PASSWD_LEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_MIN_PASSWD_LEN_PARMNUM
  MODALS_MAX_PASSWD_AGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_MAX_PASSWD_AGE_PARMNUM
  MODALS_MIN_PASSWD_AGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_MIN_PASSWD_AGE_PARMNUM
  MODALS_FORCE_LOGOFF_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_FORCE_LOGOFF_PARMNUM
  MODALS_PASSWD_HIST_LEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_PASSWD_HIST_LEN_PARMNUM
  MODALS_ROLE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_ROLE_PARMNUM
  MODALS_PRIMARY_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_PRIMARY_PARMNUM
  MODALS_DOMAIN_NAME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_DOMAIN_NAME_PARMNUM
  MODALS_DOMAIN_ID_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+MODALS_DOMAIN_ID_PARMNUM
  GROUPIDMASK* = 0x8000
  GROUP_SPECIALGRP_USERS* = "USERS"
  GROUP_SPECIALGRP_ADMINS* = "ADMINS"
  GROUP_SPECIALGRP_GUESTS* = "GUESTS"
  GROUP_SPECIALGRP_LOCAL* = "LOCA"
  GROUP_ALL_PARMNUM* = 0
  GROUP_NAME_PARMNUM* = 1
  GROUP_COMMENT_PARMNUM* = 2
  GROUP_ATTRIBUTES_PARMNUM* = 3
  GROUP_ALL_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+GROUP_ALL_PARMNUM
  GROUP_NAME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+GROUP_NAME_PARMNUM
  GROUP_COMMENT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+GROUP_COMMENT_PARMNUM
  GROUP_ATTRIBUTES_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+GROUP_ATTRIBUTES_PARMNUM
  LOCALGROUP_NAME_PARMNUM* = 1
  LOCALGROUP_COMMENT_PARMNUM* = 2
  MAXPERMENTRIES* = 64
  ACCESS_NONE* = 0
  ACCESS_READ* = 0x01
  ACCESS_WRITE* = 0x02
  ACCESS_CREATE* = 0x04
  ACCESS_EXEC* = 0x08
  ACCESS_DELETE* = 0x10
  ACCESS_ATRIB* = 0x20
  ACCESS_PERM* = 0x40
  ACCESS_ALL* = ACCESS_READ or ACCESS_WRITE or ACCESS_CREATE or ACCESS_EXEC or ACCESS_DELETE or ACCESS_ATRIB or ACCESS_PERM
  ACCESS_GROUP* = 0x8000
  ACCESS_AUDIT* = 0x1
  ACCESS_SUCCESS_OPEN* = 0x10
  ACCESS_SUCCESS_WRITE* = 0x20
  ACCESS_SUCCESS_DELETE* = 0x40
  ACCESS_SUCCESS_ACL* = 0x80
  ACCESS_SUCCESS_MASK* = 0xF0
  ACCESS_FAIL_OPEN* = 0x100
  ACCESS_FAIL_WRITE* = 0x200
  ACCESS_FAIL_DELETE* = 0x400
  ACCESS_FAIL_ACL* = 0x800
  ACCESS_FAIL_MASK* = 0xF00
  ACCESS_FAIL_SHIFT* = 4
  ACCESS_RESOURCE_NAME_PARMNUM* = 1
  ACCESS_ATTR_PARMNUM* = 2
  ACCESS_COUNT_PARMNUM* = 3
  ACCESS_ACCESS_LIST_PARMNUM* = 4
  ACCESS_RESOURCE_NAME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+ACCESS_RESOURCE_NAME_PARMNUM
  ACCESS_ATTR_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+ACCESS_ATTR_PARMNUM
  ACCESS_COUNT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+ACCESS_COUNT_PARMNUM
  ACCESS_ACCESS_LIST_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+ACCESS_ACCESS_LIST_PARMNUM
  ACCESS_LETTERS* = "RWCXDAP         "
  netValidateAuthentication* = 1
  netValidatePasswordChange* = 2
  netValidatePasswordReset* = 3
  NET_VALIDATE_PASSWORD_LAST_SET* = 0x00000001
  NET_VALIDATE_BAD_PASSWORD_TIME* = 0x00000002
  NET_VALIDATE_LOCKOUT_TIME* = 0x00000004
  NET_VALIDATE_BAD_PASSWORD_COUNT* = 0x00000008
  NET_VALIDATE_PASSWORD_HISTORY_LENGTH* = 0x00000010
  NET_VALIDATE_PASSWORD_HISTORY* = 0x00000020
  NETLOGON_CONTROL_QUERY* = 1
  NETLOGON_CONTROL_REPLICATE* = 2
  NETLOGON_CONTROL_SYNCHRONIZE* = 3
  NETLOGON_CONTROL_PDC_REPLICATE* = 4
  NETLOGON_CONTROL_REDISCOVER* = 5
  NETLOGON_CONTROL_TC_QUERY* = 6
  NETLOGON_CONTROL_TRANSPORT_NOTIFY* = 7
  NETLOGON_CONTROL_FIND_USER* = 8
  NETLOGON_CONTROL_CHANGE_PASSWORD* = 9
  NETLOGON_CONTROL_TC_VERIFY* = 10
  NETLOGON_CONTROL_FORCE_DNS_REG* = 11
  NETLOGON_CONTROL_QUERY_DNS_REG* = 12
  NETLOGON_CONTROL_UNLOAD_NETLOGON_DLL* = 0xFFFB
  NETLOGON_CONTROL_BACKUP_CHANGE_LOG* = 0xFFFC
  NETLOGON_CONTROL_TRUNCATE_LOG* = 0xFFFD
  NETLOGON_CONTROL_SET_DBFLAG* = 0xFFFE
  NETLOGON_CONTROL_BREAKPOINT* = 0xFFFF
  NETLOGON_REPLICATION_NEEDED* = 0x01
  NETLOGON_REPLICATION_IN_PROGRESS* = 0x02
  NETLOGON_FULL_SYNC_REPLICATION* = 0x04
  NETLOGON_REDO_NEEDED* = 0x08
  NETLOGON_HAS_IP* = 0x10
  NETLOGON_HAS_TIMESERV* = 0x20
  NETLOGON_DNS_UPDATE_FAILURE* = 0x40
  NETLOGON_VERIFY_STATUS_RETURNED* = 0x80
  msaInfoNotExist* = 1
  msaInfoNotService* = 2
  msaInfoCannotInstall* = 3
  msaInfoCanInstall* = 4
  msaInfoInstalled* = 5
  SERVICE_ACCOUNT_FLAG_LINK_TO_HOST_ONLY* = 0x00000001
  ALERTER_MAILSLOT* = "\\\\.\\MAILSLOT\\Alerter"
  ALERT_PRINT_EVENT* = "PRINTING"
  ALERT_MESSAGE_EVENT* = "MESSAGE"
  ALERT_ERRORLOG_EVENT* = "ERRORLOG"
  ALERT_ADMIN_EVENT* = "ADMIN"
  ALERT_USER_EVENT* = "USER"
  PRJOB_QSTATUS* = 0x3
  PRJOB_DEVSTATUS* = 0x1fc
  PRJOB_COMPLETE* = 0x4
  PRJOB_INTERV* = 0x8
  PRJOB_ERROR* = 0x10
  PRJOB_DESTOFFLINE* = 0x20
  PRJOB_DESTPAUSED* = 0x40
  PRJOB_NOTIFY* = 0x80
  PRJOB_DESTNOPAPER* = 0x100
  PRJOB_DELETED* = 0x8000
  PRJOB_QS_QUEUED* = 0
  PRJOB_QS_PAUSED* = 1
  PRJOB_QS_SPOOLING* = 2
  PRJOB_QS_PRINTING* = 3
  SHARE_NETNAME_PARMNUM* = 1
  SHARE_TYPE_PARMNUM* = 3
  SHARE_REMARK_PARMNUM* = 4
  SHARE_PERMISSIONS_PARMNUM* = 5
  SHARE_MAX_USES_PARMNUM* = 6
  SHARE_CURRENT_USES_PARMNUM* = 7
  SHARE_PATH_PARMNUM* = 8
  SHARE_PASSWD_PARMNUM* = 9
  SHARE_FILE_SD_PARMNUM* = 501
  SHARE_REMARK_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SHARE_REMARK_PARMNUM
  SHARE_MAX_USES_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SHARE_MAX_USES_PARMNUM
  SHARE_FILE_SD_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SHARE_FILE_SD_PARMNUM
  SHI1_NUM_ELEMENTS* = 4
  SHI2_NUM_ELEMENTS* = 10
  STYPE_DISKTREE* = 0
  STYPE_PRINTQ* = 1
  STYPE_DEVICE* = 2
  STYPE_IPC* = 3
  STYPE_TEMPORARY* = 0x40000000
  STYPE_SPECIAL* = 0x80000000'i32
  SHI_USES_UNLIMITED* = DWORD(-1)
  SHI1005_FLAGS_DFS* = 0x01
  SHI1005_FLAGS_DFS_ROOT* = 0x02
  CSC_MASK* = 0x30
  CSC_CACHE_MANUAL_REINT* = 0x00
  CSC_CACHE_AUTO_REINT* = 0x10
  CSC_CACHE_VDO* = 0x20
  CSC_CACHE_NONE* = 0x30
  SHI1005_FLAGS_RESTRICT_EXCLUSIVE_OPENS* = 0x0100
  SHI1005_FLAGS_FORCE_SHARED_DELETE* = 0x0200
  SHI1005_FLAGS_ALLOW_NAMESPACE_CACHING* = 0x0400
  SHI1005_FLAGS_ACCESS_BASED_DIRECTORY_ENUM* = 0x0800
  SHI1005_VALID_FLAGS_SET* = CSC_MASK or SHI1005_FLAGS_RESTRICT_EXCLUSIVE_OPENS or SHI1005_FLAGS_FORCE_SHARED_DELETE or SHI1005_FLAGS_ALLOW_NAMESPACE_CACHING or SHI1005_FLAGS_ACCESS_BASED_DIRECTORY_ENUM
  SESS_GUEST* = 0x00000001
  SESS_NOENCRYPTION* = 0x00000002
  SESI1_NUM_ELEMENTS* = 8
  SESI2_NUM_ELEMENTS* = 9
  PERM_FILE_READ* = 0x1
  PERM_FILE_WRITE* = 0x2
  PERM_FILE_CREATE* = 0x4
  MSGNAME_NOT_FORWARDED* = 0
  MSGNAME_FORWARDED_TO* = 0x04
  MSGNAME_FORWARDED_FROM* = 0x10
  SUPPORTS_REMOTE_ADMIN_PROTOCOL* = 0x00000002
  SUPPORTS_RPC* = 0x00000004
  SUPPORTS_SAM_PROTOCOL* = 0x00000008
  SUPPORTS_UNICODE* = 0x00000010
  SUPPORTS_LOCAL* = 0x00000020
  SUPPORTS_ANY* = 0xFFFFFFFF'i32
  NO_PERMISSION_REQUIRED* = 0x00000001
  ALLOCATE_RESPONSE* = 0x00000002
  USE_SPECIFIC_TRANSPORT* = 0x80000000'i32
  REPL_ROLE_EXPORT* = 1
  REPL_ROLE_IMPORT* = 2
  REPL_ROLE_BOTH* = 3
  REPL_INTERVAL_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+0
  REPL_PULSE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+1
  REPL_GUARDTIME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+2
  REPL_RANDOM_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+3
  REPL_INTEGRITY_FILE* = 1
  REPL_INTEGRITY_TREE* = 2
  REPL_EXTENT_FILE* = 1
  REPL_EXTENT_TREE* = 2
  REPL_EXPORT_INTEGRITY_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+0
  REPL_EXPORT_EXTENT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+1
  REPL_UNLOCK_NOFORCE* = 0
  REPL_UNLOCK_FORCE* = 1
  REPL_STATE_OK* = 0
  REPL_STATE_NO_MASTER* = 1
  REPL_STATE_NO_SYNC* = 2
  REPL_STATE_NEVER_REPLICATED* = 3
  SV_PLATFORM_ID_OS2* = 400
  SV_PLATFORM_ID_NT* = 500
  MAJOR_VERSION_MASK* = 0x0F
  SV_TYPE_WORKSTATION* = 0x00000001
  SV_TYPE_SERVER* = 0x00000002
  SV_TYPE_SQLSERVER* = 0x00000004
  SV_TYPE_DOMAIN_CTRL* = 0x00000008
  SV_TYPE_DOMAIN_BAKCTRL* = 0x00000010
  SV_TYPE_TIME_SOURCE* = 0x00000020
  SV_TYPE_AFP* = 0x00000040
  SV_TYPE_NOVELL* = 0x00000080
  SV_TYPE_DOMAIN_MEMBER* = 0x00000100
  SV_TYPE_PRINTQ_SERVER* = 0x00000200
  SV_TYPE_DIALIN_SERVER* = 0x00000400
  SV_TYPE_XENIX_SERVER* = 0x00000800
  SV_TYPE_SERVER_UNIX* = SV_TYPE_XENIX_SERVER
  SV_TYPE_NT* = 0x00001000
  SV_TYPE_WFW* = 0x00002000
  SV_TYPE_SERVER_MFPN* = 0x00004000
  SV_TYPE_SERVER_NT* = 0x00008000
  SV_TYPE_POTENTIAL_BROWSER* = 0x00010000
  SV_TYPE_BACKUP_BROWSER* = 0x00020000
  SV_TYPE_MASTER_BROWSER* = 0x00040000
  SV_TYPE_DOMAIN_MASTER* = 0x00080000
  SV_TYPE_SERVER_OSF* = 0x00100000
  SV_TYPE_SERVER_VMS* = 0x00200000
  SV_TYPE_WINDOWS* = 0x00400000
  SV_TYPE_DFS* = 0x00800000
  SV_TYPE_CLUSTER_NT* = 0x01000000
  SV_TYPE_TERMINALSERVER* = 0x02000000
  SV_TYPE_CLUSTER_VS_NT* = 0x04000000
  SV_TYPE_DCE* = 0x10000000
  SV_TYPE_ALTERNATE_XPORT* = 0x20000000
  SV_TYPE_LOCAL_LIST_ONLY* = 0x40000000
  SV_TYPE_DOMAIN_ENUM* = 0x80000000'i32
  SV_TYPE_ALL* = 0xFFFFFFFF'i32
  SV_NODISC* = -1
  SV_USERSECURITY* = 1
  SV_SHARESECURITY* = 0
  SV_HIDDEN* = 1
  SV_VISIBLE* = 0
  SV_PLATFORM_ID_PARMNUM* = 101
  SV_NAME_PARMNUM* = 102
  SV_VERSION_MAJOR_PARMNUM* = 103
  SV_VERSION_MINOR_PARMNUM* = 104
  SV_TYPE_PARMNUM* = 105
  SV_COMMENT_PARMNUM* = 5
  SV_USERS_PARMNUM* = 107
  SV_DISC_PARMNUM* = 10
  SV_HIDDEN_PARMNUM* = 16
  SV_ANNOUNCE_PARMNUM* = 17
  SV_ANNDELTA_PARMNUM* = 18
  SV_USERPATH_PARMNUM* = 112
  SV_ULIST_MTIME_PARMNUM* = 401
  SV_GLIST_MTIME_PARMNUM* = 402
  SV_ALIST_MTIME_PARMNUM* = 403
  SV_ALERTS_PARMNUM* = 11
  SV_SECURITY_PARMNUM* = 405
  SV_NUMADMIN_PARMNUM* = 406
  SV_LANMASK_PARMNUM* = 407
  SV_GUESTACC_PARMNUM* = 408
  SV_CHDEVQ_PARMNUM* = 410
  SV_CHDEVJOBS_PARMNUM* = 411
  SV_CONNECTIONS_PARMNUM* = 412
  SV_SHARES_PARMNUM* = 413
  SV_OPENFILES_PARMNUM* = 414
  SV_SESSREQS_PARMNUM* = 417
  SV_ACTIVELOCKS_PARMNUM* = 419
  SV_NUMREQBUF_PARMNUM* = 420
  SV_NUMBIGBUF_PARMNUM* = 422
  SV_NUMFILETASKS_PARMNUM* = 423
  SV_ALERTSCHED_PARMNUM* = 37
  SV_ERRORALERT_PARMNUM* = 38
  SV_LOGONALERT_PARMNUM* = 39
  SV_ACCESSALERT_PARMNUM* = 40
  SV_DISKALERT_PARMNUM* = 41
  SV_NETIOALERT_PARMNUM* = 42
  SV_MAXAUDITSZ_PARMNUM* = 43
  SV_SRVHEURISTICS_PARMNUM* = 431
  SV_SESSOPENS_PARMNUM* = 501
  SV_SESSVCS_PARMNUM* = 502
  SV_OPENSEARCH_PARMNUM* = 503
  SV_SIZREQBUF_PARMNUM* = 504
  SV_INITWORKITEMS_PARMNUM* = 505
  SV_MAXWORKITEMS_PARMNUM* = 506
  SV_RAWWORKITEMS_PARMNUM* = 507
  SV_IRPSTACKSIZE_PARMNUM* = 508
  SV_MAXRAWBUFLEN_PARMNUM* = 509
  SV_SESSUSERS_PARMNUM* = 510
  SV_SESSCONNS_PARMNUM* = 511
  SV_MAXNONPAGEDMEMORYUSAGE_PARMNUM* = 512
  SV_MAXPAGEDMEMORYUSAGE_PARMNUM* = 513
  SV_ENABLESOFTCOMPAT_PARMNUM* = 514
  SV_ENABLEFORCEDLOGOFF_PARMNUM* = 515
  SV_TIMESOURCE_PARMNUM* = 516
  SV_ACCEPTDOWNLEVELAPIS_PARMNUM* = 517
  SV_LMANNOUNCE_PARMNUM* = 518
  SV_DOMAIN_PARMNUM* = 519
  SV_MAXCOPYREADLEN_PARMNUM* = 520
  SV_MAXCOPYWRITELEN_PARMNUM* = 521
  SV_MINKEEPSEARCH_PARMNUM* = 522
  SV_MAXKEEPSEARCH_PARMNUM* = 523
  SV_MINKEEPCOMPLSEARCH_PARMNUM* = 524
  SV_MAXKEEPCOMPLSEARCH_PARMNUM* = 525
  SV_THREADCOUNTADD_PARMNUM* = 526
  SV_NUMBLOCKTHREADS_PARMNUM* = 527
  SV_SCAVTIMEOUT_PARMNUM* = 528
  SV_MINRCVQUEUE_PARMNUM* = 529
  SV_MINFREEWORKITEMS_PARMNUM* = 530
  SV_XACTMEMSIZE_PARMNUM* = 531
  SV_THREADPRIORITY_PARMNUM* = 532
  SV_MAXMPXCT_PARMNUM* = 533
  SV_OPLOCKBREAKWAIT_PARMNUM* = 534
  SV_OPLOCKBREAKRESPONSEWAIT_PARMNUM* = 535
  SV_ENABLEOPLOCKS_PARMNUM* = 536
  SV_ENABLEOPLOCKFORCECLOSE_PARMNUM* = 537
  SV_ENABLEFCBOPENS_PARMNUM* = 538
  SV_ENABLERAW_PARMNUM* = 539
  SV_ENABLESHAREDNETDRIVES_PARMNUM* = 540
  SV_MINFREECONNECTIONS_PARMNUM* = 541
  SV_MAXFREECONNECTIONS_PARMNUM* = 542
  SV_INITSESSTABLE_PARMNUM* = 543
  SV_INITCONNTABLE_PARMNUM* = 544
  SV_INITFILETABLE_PARMNUM* = 545
  SV_INITSEARCHTABLE_PARMNUM* = 546
  SV_ALERTSCHEDULE_PARMNUM* = 547
  SV_ERRORTHRESHOLD_PARMNUM* = 548
  SV_NETWORKERRORTHRESHOLD_PARMNUM* = 549
  SV_DISKSPACETHRESHOLD_PARMNUM* = 550
  SV_MAXLINKDELAY_PARMNUM* = 552
  SV_MINLINKTHROUGHPUT_PARMNUM* = 553
  SV_LINKINFOVALIDTIME_PARMNUM* = 554
  SV_SCAVQOSINFOUPDATETIME_PARMNUM* = 555
  SV_MAXWORKITEMIDLETIME_PARMNUM* = 556
  SV_MAXRAWWORKITEMS_PARMNUM* = 557
  SV_PRODUCTTYPE_PARMNUM* = 560
  SV_SERVERSIZE_PARMNUM* = 561
  SV_CONNECTIONLESSAUTODISC_PARMNUM* = 562
  SV_SHARINGVIOLATIONRETRIES_PARMNUM* = 563
  SV_SHARINGVIOLATIONDELAY_PARMNUM* = 564
  SV_MAXGLOBALOPENSEARCH_PARMNUM* = 565
  SV_REMOVEDUPLICATESEARCHES_PARMNUM* = 566
  SV_LOCKVIOLATIONRETRIES_PARMNUM* = 567
  SV_LOCKVIOLATIONOFFSET_PARMNUM* = 568
  SV_LOCKVIOLATIONDELAY_PARMNUM* = 569
  SV_MDLREADSWITCHOVER_PARMNUM* = 570
  SV_CACHEDOPENLIMIT_PARMNUM* = 571
  SV_CRITICALTHREADS_PARMNUM* = 572
  SV_RESTRICTNULLSESSACCESS_PARMNUM* = 573
  SV_ENABLEWFW311DIRECTIPX_PARMNUM* = 574
  SV_OTHERQUEUEAFFINITY_PARMNUM* = 575
  SV_QUEUESAMPLESECS_PARMNUM* = 576
  SV_BALANCECOUNT_PARMNUM* = 577
  SV_PREFERREDAFFINITY_PARMNUM* = 578
  SV_MAXFREERFCBS_PARMNUM* = 579
  SV_MAXFREEMFCBS_PARMNUM* = 580
  SV_MAXFREELFCBS_PARMNUM* = 581
  SV_MAXFREEPAGEDPOOLCHUNKS_PARMNUM* = 582
  SV_MINPAGEDPOOLCHUNKSIZE_PARMNUM* = 583
  SV_MAXPAGEDPOOLCHUNKSIZE_PARMNUM* = 584
  SV_SENDSFROMPREFERREDPROCESSOR_PARMNUM* = 585
  SV_MAXTHREADSPERQUEUE_PARMNUM* = 586
  SV_CACHEDDIRECTORYLIMIT_PARMNUM* = 587
  SV_MAXCOPYLENGTH_PARMNUM* = 588
  SV_ENABLECOMPRESSION_PARMNUM* = 590
  SV_AUTOSHAREWKS_PARMNUM* = 591
  SV_AUTOSHARESERVER_PARMNUM* = 592
  SV_ENABLESECURITYSIGNATURE_PARMNUM* = 593
  SV_REQUIRESECURITYSIGNATURE_PARMNUM* = 594
  SV_MINCLIENTBUFFERSIZE_PARMNUM* = 595
  SV_CONNECTIONNOSESSIONSTIMEOUT_PARMNUM* = 596
  SV_IDLETHREADTIMEOUT_PARMNUM* = 597
  SV_ENABLEW9XSECURITYSIGNATURE_PARMNUM* = 598
  SV_ENFORCEKERBEROSREAUTHENTICATION_PARMNUM* = 599
  SV_DISABLEDOS_PARMNUM* = 600
  SV_LOWDISKSPACEMINIMUM_PARMNUM* = 601
  SV_DISABLESTRICTNAMECHECKING_PARMNUM* = 602
  SV_COMMENT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_COMMENT_PARMNUM
  SV_USERS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_USERS_PARMNUM
  SV_DISC_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_DISC_PARMNUM
  SV_HIDDEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_HIDDEN_PARMNUM
  SV_ANNOUNCE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ANNOUNCE_PARMNUM
  SV_ANNDELTA_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ANNDELTA_PARMNUM
  SV_SESSOPENS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SESSOPENS_PARMNUM
  SV_SESSVCS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SESSVCS_PARMNUM
  SV_OPENSEARCH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_OPENSEARCH_PARMNUM
  SV_MAXWORKITEMS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXWORKITEMS_PARMNUM
  SV_MAXRAWBUFLEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXRAWBUFLEN_PARMNUM
  SV_SESSUSERS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SESSUSERS_PARMNUM
  SV_SESSCONNS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SESSCONNS_PARMNUM
  SV_MAXNONPAGEDMEMORYUSAGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXNONPAGEDMEMORYUSAGE_PARMNUM
  SV_MAXPAGEDMEMORYUSAGE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXPAGEDMEMORYUSAGE_PARMNUM
  SV_ENABLESOFTCOMPAT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLESOFTCOMPAT_PARMNUM
  SV_ENABLEFORCEDLOGOFF_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEFORCEDLOGOFF_PARMNUM
  SV_TIMESOURCE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_TIMESOURCE_PARMNUM
  SV_LMANNOUNCE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LMANNOUNCE_PARMNUM
  SV_MAXCOPYREADLEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXCOPYREADLEN_PARMNUM
  SV_MAXCOPYWRITELEN_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXCOPYWRITELEN_PARMNUM
  SV_MINKEEPSEARCH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINKEEPSEARCH_PARMNUM
  SV_MAXKEEPSEARCH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXKEEPSEARCH_PARMNUM
  SV_MINKEEPCOMPLSEARCH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINKEEPCOMPLSEARCH_PARMNUM
  SV_MAXKEEPCOMPLSEARCH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXKEEPCOMPLSEARCH_PARMNUM
  SV_SCAVTIMEOUT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SCAVTIMEOUT_PARMNUM
  SV_MINRCVQUEUE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINRCVQUEUE_PARMNUM
  SV_MINFREEWORKITEMS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINFREEWORKITEMS_PARMNUM
  SV_MAXMPXCT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXMPXCT_PARMNUM
  SV_OPLOCKBREAKWAIT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_OPLOCKBREAKWAIT_PARMNUM
  SV_OPLOCKBREAKRESPONSEWAIT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_OPLOCKBREAKRESPONSEWAIT_PARMNUM
  SV_ENABLEOPLOCKS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEOPLOCKS_PARMNUM
  SV_ENABLEOPLOCKFORCECLOSE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEOPLOCKFORCECLOSE_PARMNUM
  SV_ENABLEFCBOPENS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEFCBOPENS_PARMNUM
  SV_ENABLERAW_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLERAW_PARMNUM
  SV_ENABLESHAREDNETDRIVES_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLESHAREDNETDRIVES_PARMNUM
  SV_MINFREECONNECTIONS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINFREECONNECTIONS_PARMNUM
  SV_MAXFREECONNECTIONS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXFREECONNECTIONS_PARMNUM
  SV_INITSESSTABLE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_INITSESSTABLE_PARMNUM
  SV_INITCONNTABLE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_INITCONNTABLE_PARMNUM
  SV_INITFILETABLE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_INITFILETABLE_PARMNUM
  SV_INITSEARCHTABLE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_INITSEARCHTABLE_PARMNUM
  SV_ALERTSCHEDULE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ALERTSCHEDULE_PARMNUM
  SV_ERRORTHRESHOLD_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ERRORTHRESHOLD_PARMNUM
  SV_NETWORKERRORTHRESHOLD_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_NETWORKERRORTHRESHOLD_PARMNUM
  SV_DISKSPACETHRESHOLD_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_DISKSPACETHRESHOLD_PARMNUM
  SV_MAXLINKDELAY_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXLINKDELAY_PARMNUM
  SV_MINLINKTHROUGHPUT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINLINKTHROUGHPUT_PARMNUM
  SV_LINKINFOVALIDTIME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LINKINFOVALIDTIME_PARMNUM
  SV_SCAVQOSINFOUPDATETIME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SCAVQOSINFOUPDATETIME_PARMNUM
  SV_MAXWORKITEMIDLETIME_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXWORKITEMIDLETIME_PARMNUM
  SV_MAXRAWWORKITEMS_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXRAWWORKITEMS_PARMNUM
  SV_PRODUCTTYPE_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_PRODUCTTYPE_PARMNUM
  SV_SERVERSIZE_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SERVERSIZE_PARMNUM
  SV_CONNECTIONLESSAUTODISC_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_CONNECTIONLESSAUTODISC_PARMNUM
  SV_SHARINGVIOLATIONRETRIES_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SHARINGVIOLATIONRETRIES_PARMNUM
  SV_SHARINGVIOLATIONDELAY_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SHARINGVIOLATIONDELAY_PARMNUM
  SV_MAXGLOBALOPENSEARCH_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXGLOBALOPENSEARCH_PARMNUM
  SV_REMOVEDUPLICATESEARCHES_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_REMOVEDUPLICATESEARCHES_PARMNUM
  SV_LOCKVIOLATIONRETRIES_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LOCKVIOLATIONRETRIES_PARMNUM
  SV_LOCKVIOLATIONOFFSET_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LOCKVIOLATIONOFFSET_PARMNUM
  SV_LOCKVIOLATIONDELAY_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LOCKVIOLATIONDELAY_PARMNUM
  SV_MDLREADSWITCHOVER_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MDLREADSWITCHOVER_PARMNUM
  SV_CACHEDOPENLIMIT_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_CACHEDOPENLIMIT_PARMNUM
  SV_CRITICALTHREADS_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_CRITICALTHREADS_PARMNUM
  SV_RESTRICTNULLSESSACCESS_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_RESTRICTNULLSESSACCESS_PARMNUM
  SV_ENABLEWFW311DIRECTIPX_INFOLOEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEWFW311DIRECTIPX_PARMNUM
  SV_OTHERQUEUEAFFINITY_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_OTHERQUEUEAFFINITY_PARMNUM
  SV_QUEUESAMPLESECS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_QUEUESAMPLESECS_PARMNUM
  SV_BALANCECOUNT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_BALANCECOUNT_PARMNUM
  SV_PREFERREDAFFINITY_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_PREFERREDAFFINITY_PARMNUM
  SV_MAXFREERFCBS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXFREERFCBS_PARMNUM
  SV_MAXFREEMFCBS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXFREEMFCBS_PARMNUM
  SV_MAXFREELFCBS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXFREELFCBS_PARMNUM
  SV_MAXFREEPAGEDPOOLCHUNKS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXFREEPAGEDPOOLCHUNKS_PARMNUM
  SV_MINPAGEDPOOLCHUNKSIZE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINPAGEDPOOLCHUNKSIZE_PARMNUM
  SV_MAXPAGEDPOOLCHUNKSIZE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXPAGEDPOOLCHUNKSIZE_PARMNUM
  SV_SENDSFROMPREFERREDPROCESSOR_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_SENDSFROMPREFERREDPROCESSOR_PARMNUM
  SV_MAXTHREADSPERQUEUE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXTHREADSPERQUEUE_PARMNUM
  SV_CACHEDDIRECTORYLIMIT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_CACHEDDIRECTORYLIMIT_PARMNUM
  SV_MAXCOPYLENGTH_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MAXCOPYLENGTH_PARMNUM
  SV_ENABLECOMPRESSION_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLECOMPRESSION_PARMNUM
  SV_AUTOSHAREWKS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_AUTOSHAREWKS_PARMNUM
  SV_AUTOSHARESERVER_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_AUTOSHARESERVER_PARMNUM
  SV_ENABLESECURITYSIGNATURE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLESECURITYSIGNATURE_PARMNUM
  SV_REQUIRESECURITYSIGNATURE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_REQUIRESECURITYSIGNATURE_PARMNUM
  SV_MINCLIENTBUFFERSIZE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_MINCLIENTBUFFERSIZE_PARMNUM
  SV_CONNECTIONNOSESSIONSTIMEOUT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_CONNECTIONNOSESSIONSTIMEOUT_PARMNUM
  SV_IDLETHREADTIMEOUT_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_IDLETHREADTIMEOUT_PARMNUM
  SV_ENABLEW9XSECURITYSIGNATURE_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENABLEW9XSECURITYSIGNATURE_PARMNUM
  SV_ENFORCEKERBEROSREAUTHENTICATION_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_ENFORCEKERBEROSREAUTHENTICATION_PARMNUM
  SV_DISABLEDOS_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_DISABLEDOS_PARMNUM
  SV_LOWDISKSPACEMINIMUM_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_LOWDISKSPACEMINIMUM_PARMNUM
  SV_DISABLESTRICTNAMECHECKING_INFOLEVEL* = PARMNUM_BASE_INFOLEVEL+SV_DISABLESTRICTNAMECHECKING_PARMNUM
  SVI1_NUM_ELEMENTS* = 5
  SVI2_NUM_ELEMENTS* = 40
  SVI3_NUM_ELEMENTS* = 44
  SV_MAX_CMD_LEN* = PATHLEN
  SW_AUTOPROF_LOAD_MASK* = 0x1
  SW_AUTOPROF_SAVE_MASK* = 0x2
  SV_MAX_SRV_HEUR_LEN* = 32
  SV_USERS_PER_LICENSE* = 5
  SVTI2_REMAP_PIPE_NAMES* = 0x2
  SERVICE_WORKSTATION* = "LanmanWorkstation"
  SERVICE_LM20_WORKSTATION* = "WORKSTATION"
  WORKSTATION_DISPLAY_NAME* = "Workstation"
  SERVICE_SERVER* = "LanmanServer"
  SERVICE_LM20_SERVER* = "SERVER"
  SERVER_DISPLAY_NAME* = "Server"
  SERVICE_BROWSER* = "BROWSER"
  SERVICE_LM20_BROWSER* = SERVICE_BROWSER
  SERVICE_MESSENGER* = "MESSENGER"
  SERVICE_LM20_MESSENGER* = SERVICE_MESSENGER
  SERVICE_NETRUN* = "NETRUN"
  SERVICE_LM20_NETRUN* = SERVICE_NETRUN
  SERVICE_SPOOLER* = "SPOOLER"
  SERVICE_LM20_SPOOLER* = SERVICE_SPOOLER
  SERVICE_ALERTER* = "ALERTER"
  SERVICE_LM20_ALERTER* = SERVICE_ALERTER
  SERVICE_NETLOGON* = "NETLOGON"
  SERVICE_LM20_NETLOGON* = SERVICE_NETLOGON
  SERVICE_NETPOPUP* = "NETPOPUP"
  SERVICE_LM20_NETPOPUP* = SERVICE_NETPOPUP
  SERVICE_SQLSERVER* = "SQLSERVER"
  SERVICE_LM20_SQLSERVER* = SERVICE_SQLSERVER
  SERVICE_REPL* = "REPLICATOR"
  SERVICE_LM20_REPL* = SERVICE_REPL
  SERVICE_RIPL* = "REMOTEBOOT"
  SERVICE_LM20_RIPL* = SERVICE_RIPL
  SERVICE_TIMESOURCE* = "TIMESOURCE"
  SERVICE_LM20_TIMESOURCE* = SERVICE_TIMESOURCE
  SERVICE_AFP* = "AFP"
  SERVICE_LM20_AFP* = SERVICE_AFP
  SERVICE_UPS* = "UPS"
  SERVICE_LM20_UPS* = SERVICE_UPS
  SERVICE_XACTSRV* = "XACTSRV"
  SERVICE_LM20_XACTSRV* = SERVICE_XACTSRV
  SERVICE_TCPIP* = "TCPIP"
  SERVICE_LM20_TCPIP* = SERVICE_TCPIP
  SERVICE_NBT* = "NBT"
  SERVICE_LM20_NBT* = SERVICE_NBT
  SERVICE_LMHOSTS* = "LMHOSTS"
  SERVICE_LM20_LMHOSTS* = SERVICE_LMHOSTS
  SERVICE_TELNET* = "Telnet"
  SERVICE_LM20_TELNET* = SERVICE_TELNET
  SERVICE_SCHEDULE* = "Schedule"
  SERVICE_LM20_SCHEDULE* = SERVICE_SCHEDULE
  SERVICE_NTLMSSP* = "NtLmSsp"
  SERVICE_DHCP* = "DHCP"
  SERVICE_LM20_DHCP* = SERVICE_DHCP
  SERVICE_NWSAP* = "NwSapAgent"
  SERVICE_LM20_NWSAP* = SERVICE_NWSAP
  NWSAP_DISPLAY_NAME* = "NW Sap Agent"
  SERVICE_NWCS* = "NWCWorkstation"
  SERVICE_DNS_CACHE* = "DnsCache"
  SERVICE_W32TIME* = "w32time"
  SERVCE_LM20_W32TIME* = SERVICE_W32TIME
  SERVICE_KDC* = "kdc"
  SERVICE_LM20_KDC* = SERVICE_KDC
  SERVICE_RPCLOCATOR* = "RPCLOCATOR"
  SERVICE_LM20_RPCLOCATOR* = SERVICE_RPCLOCATOR
  SERVICE_TRKSVR* = "TrkSvr"
  SERVICE_LM20_TRKSVR* = SERVICE_TRKSVR
  SERVICE_TRKWKS* = "TrkWks"
  SERVICE_LM20_TRKWKS* = SERVICE_TRKWKS
  SERVICE_NTFRS* = "NtFrs"
  SERVICE_LM20_NTFRS* = SERVICE_NTFRS
  SERVICE_ISMSERV* = "IsmServ"
  SERVICE_LM20_ISMSERV* = SERVICE_ISMSERV
  SERVICE_INSTALL_STATE* = 0x03
  SERVICE_UNINSTALLED* = 0x00
  SERVICE_INSTALL_PENDING* = 0x01
  SERVICE_UNINSTALL_PENDING* = 0x02
  SERVICE_INSTALLED* = 0x03
  SERVICE_PAUSE_STATE* = 0x0C
  LM20_SERVICE_ACTIVE* = 0x00
  LM20_SERVICE_CONTINUE_PENDING* = 0x04
  LM20_SERVICE_PAUSE_PENDING* = 0x08
  LM20_SERVICE_PAUSED* = 0x0C
  SERVICE_NOT_UNINSTALLABLE* = 0x00
  SERVICE_UNINSTALLABLE* = 0x10
  SERVICE_NOT_PAUSABLE* = 0x00
  SERVICE_PAUSABLE* = 0x20
  SERVICE_REDIR_PAUSED* = 0x700
  SERVICE_REDIR_DISK_PAUSED* = 0x100
  SERVICE_REDIR_PRINT_PAUSED* = 0x200
  SERVICE_REDIR_COMM_PAUSED* = 0x400
  SERVICE_DOS_ENCRYPTION* = "ENCRYPT"
  SERVICE_CTRL_INTERROGATE* = 0
  SERVICE_CTRL_PAUSE* = 1
  SERVICE_CTRL_CONTINUE* = 2
  SERVICE_CTRL_UNINSTALL* = 3
  SERVICE_CTRL_REDIR_DISK* = 0x1
  SERVICE_CTRL_REDIR_PRINT* = 0x2
  SERVICE_CTRL_REDIR_COMM* = 0x4
  SERVICE_IP_NO_HINT* = 0x0
  SERVICE_CCP_NO_HINT* = 0x0
  SERVICE_IP_QUERY_HINT* = 0x10000
  SERVICE_CCP_QUERY_HINT* = 0x10000
  SERVICE_IP_CHKPT_NUM* = 0x0FF
  SERVICE_CCP_CHKPT_NUM* = 0x0FF
  SERVICE_IP_WAIT_TIME* = 0x0FF00
  SERVICE_CCP_WAIT_TIME* = 0x0FF00
  SERVICE_IP_WAITTIME_SHIFT* = 8
  SERVICE_NTIP_WAITTIME_SHIFT* = 12
  UPPER_HINT_MASK* = 0x0000FF00
  LOWER_HINT_MASK* = 0x000000FF
  UPPER_GET_HINT_MASK* = 0x0FF00000
  LOWER_GET_HINT_MASK* = 0x0000FF00
  SERVICE_NT_MAXTIME* = 0x0000FFFF
  SERVICE_RESRV_MASK* = 0x0001FFFF
  SERVICE_MAXTIME* = 0x000000FF
  SERVICE_BASE* = 3050
  SERVICE_UIC_NORMAL* = 0
  SERVICE_UIC_BADPARMVAL* = SERVICE_BASE+1
  SERVICE_UIC_MISSPARM* = SERVICE_BASE+2
  SERVICE_UIC_UNKPARM* = SERVICE_BASE+3
  SERVICE_UIC_RESOURCE* = SERVICE_BASE+4
  SERVICE_UIC_CONFIG* = SERVICE_BASE+5
  SERVICE_UIC_SYSTEM* = SERVICE_BASE+6
  SERVICE_UIC_INTERNAL* = SERVICE_BASE+7
  SERVICE_UIC_AMBIGPARM* = SERVICE_BASE+8
  SERVICE_UIC_DUPPARM* = SERVICE_BASE+9
  SERVICE_UIC_KILL* = SERVICE_BASE+10
  SERVICE_UIC_EXEC* = SERVICE_BASE+11
  SERVICE_UIC_SUBSERV* = SERVICE_BASE+12
  SERVICE_UIC_CONFLPARM* = SERVICE_BASE+13
  SERVICE_UIC_FILE* = SERVICE_BASE+14
  SERVICE_UIC_M_NULL* = 0
  SERVICE_UIC_M_MEMORY* = SERVICE_BASE+20
  SERVICE_UIC_M_DISK* = SERVICE_BASE+21
  SERVICE_UIC_M_THREADS* = SERVICE_BASE+22
  SERVICE_UIC_M_PROCESSES* = SERVICE_BASE+23
  SERVICE_UIC_M_SECURITY* = SERVICE_BASE+24
  SERVICE_UIC_M_LANROOT* = SERVICE_BASE+25
  SERVICE_UIC_M_REDIR* = SERVICE_BASE+26
  SERVICE_UIC_M_SERVER* = SERVICE_BASE+27
  SERVICE_UIC_M_SEC_FILE_ERR* = SERVICE_BASE+28
  SERVICE_UIC_M_FILES* = SERVICE_BASE+29
  SERVICE_UIC_M_LOGS* = SERVICE_BASE+30
  SERVICE_UIC_M_LANGROUP* = SERVICE_BASE+31
  SERVICE_UIC_M_MSGNAME* = SERVICE_BASE+32
  SERVICE_UIC_M_ANNOUNCE* = SERVICE_BASE+33
  SERVICE_UIC_M_UAS* = SERVICE_BASE+34
  SERVICE_UIC_M_SERVER_SEC_ERR* = SERVICE_BASE+35
  SERVICE_UIC_M_WKSTA* = SERVICE_BASE+37
  SERVICE_UIC_M_ERRLOG* = SERVICE_BASE+38
  SERVICE_UIC_M_FILE_UW* = SERVICE_BASE+39
  SERVICE_UIC_M_ADDPAK* = SERVICE_BASE+40
  SERVICE_UIC_M_LAZY* = SERVICE_BASE+41
  SERVICE_UIC_M_UAS_MACHINE_ACCT* = SERVICE_BASE+42
  SERVICE_UIC_M_UAS_SERVERS_NMEMB* = SERVICE_BASE+43
  SERVICE_UIC_M_UAS_SERVERS_NOGRP* = SERVICE_BASE+44
  SERVICE_UIC_M_UAS_INVALID_ROLE* = SERVICE_BASE+45
  SERVICE_UIC_M_NETLOGON_NO_DC* = SERVICE_BASE+46
  SERVICE_UIC_M_NETLOGON_DC_CFLCT* = SERVICE_BASE+47
  SERVICE_UIC_M_NETLOGON_AUTH* = SERVICE_BASE+48
  SERVICE_UIC_M_UAS_PROLOG* = SERVICE_BASE+49
  SERVICE2_BASE* = 5600
  SERVICE_UIC_M_NETLOGON_MPATH* = SERVICE2_BASE+0
  SERVICE_UIC_M_LSA_MACHINE_ACCT* = SERVICE2_BASE+1
  SERVICE_UIC_M_DATABASE_ERROR* = SERVICE2_BASE+2
  USE_NOFORCE* = 0
  USE_FORCE* = 1
  USE_LOTS_OF_FORCE* = 2
  USE_LOCAL_PARMNUM* = 1
  USE_REMOTE_PARMNUM* = 2
  USE_PASSWORD_PARMNUM* = 3
  USE_ASGTYPE_PARMNUM* = 4
  USE_USERNAME_PARMNUM* = 5
  USE_DOMAINNAME_PARMNUM* = 6
  USE_OK* = 0
  USE_PAUSED* = 1
  USE_SESSLOST* = 2
  USE_DISCONN* = 2
  USE_NETERR* = 3
  USE_CONN* = 4
  USE_RECONN* = 5
  USE_DISKDEV* = 0
  USE_SPOOLDEV* = 1
  USE_CHARDEV* = 2
  USE_IPC* = 3
  CREATE_NO_CONNECT* = 0x1
  CREATE_BYPASS_CSC* = 0x2
  USE_DEFAULT_CREDENTIALS* = 0x4
  WKSTA_PLATFORM_ID_PARMNUM* = 100
  WKSTA_COMPUTERNAME_PARMNUM* = 1
  WKSTA_LANGROUP_PARMNUM* = 2
  WKSTA_VER_MAJOR_PARMNUM* = 4
  WKSTA_VER_MINOR_PARMNUM* = 5
  WKSTA_LOGGED_ON_USERS_PARMNUM* = 6
  WKSTA_LANROOT_PARMNUM* = 7
  WKSTA_LOGON_DOMAIN_PARMNUM* = 8
  WKSTA_LOGON_SERVER_PARMNUM* = 9
  WKSTA_CHARWAIT_PARMNUM* = 10
  WKSTA_CHARTIME_PARMNUM* = 11
  WKSTA_CHARCOUNT_PARMNUM* = 12
  WKSTA_KEEPCONN_PARMNUM* = 13
  WKSTA_KEEPSEARCH_PARMNUM* = 14
  WKSTA_MAXCMDS_PARMNUM* = 15
  WKSTA_NUMWORKBUF_PARMNUM* = 16
  WKSTA_MAXWRKCACHE_PARMNUM* = 17
  WKSTA_SESSTIMEOUT_PARMNUM* = 18
  WKSTA_SIZERROR_PARMNUM* = 19
  WKSTA_NUMALERTS_PARMNUM* = 20
  WKSTA_NUMSERVICES_PARMNUM* = 21
  WKSTA_NUMCHARBUF_PARMNUM* = 22
  WKSTA_SIZCHARBUF_PARMNUM* = 23
  WKSTA_ERRLOGSZ_PARMNUM* = 27
  WKSTA_PRINTBUFTIME_PARMNUM* = 28
  WKSTA_SIZWORKBUF_PARMNUM* = 29
  WKSTA_MAILSLOTS_PARMNUM* = 30
  WKSTA_NUMDGRAMBUF_PARMNUM* = 31
  WKSTA_WRKHEURISTICS_PARMNUM* = 32
  WKSTA_MAXTHREADS_PARMNUM* = 33
  WKSTA_LOCKQUOTA_PARMNUM* = 41
  WKSTA_LOCKINCREMENT_PARMNUM* = 42
  WKSTA_LOCKMAXIMUM_PARMNUM* = 43
  WKSTA_PIPEINCREMENT_PARMNUM* = 44
  WKSTA_PIPEMAXIMUM_PARMNUM* = 45
  WKSTA_DORMANTFILELIMIT_PARMNUM* = 46
  WKSTA_CACHEFILETIMEOUT_PARMNUM* = 47
  WKSTA_USEOPPORTUNISTICLOCKING_PARMNUM* = 48
  WKSTA_USEUNLOCKBEHIND_PARMNUM* = 49
  WKSTA_USECLOSEBEHIND_PARMNUM* = 50
  WKSTA_BUFFERNAMEDPIPES_PARMNUM* = 51
  WKSTA_USELOCKANDREADANDUNLOCK_PARMNUM* = 52
  WKSTA_UTILIZENTCACHING_PARMNUM* = 53
  WKSTA_USERAWREAD_PARMNUM* = 54
  WKSTA_USERAWWRITE_PARMNUM* = 55
  WKSTA_USEWRITERAWWITHDATA_PARMNUM* = 56
  WKSTA_USEENCRYPTION_PARMNUM* = 57
  WKSTA_BUFFILESWITHDENYWRITE_PARMNUM* = 58
  WKSTA_BUFFERREADONLYFILES_PARMNUM* = 59
  WKSTA_FORCECORECREATEMODE_PARMNUM* = 60
  WKSTA_USE512BYTESMAXTRANSFER_PARMNUM* = 61
  WKSTA_READAHEADTHRUPUT_PARMNUM* = 62
  WKSTA_OTH_DOMAINS_PARMNUM* = 101
  TRANSPORT_QUALITYOFSERVICE_PARMNUM* = 201
  TRANSPORT_NAME_PARMNUM* = 202
  LOGFLAGS_FORWARD* = 0
  LOGFLAGS_BACKWARD* = 0x1
  LOGFLAGS_SEEK* = 0x2
  ERRLOG_BASE* = 3100
  NELOG_Internal_Error* = ERRLOG_BASE+0
  NELOG_Resource_Shortage* = ERRLOG_BASE+1
  NELOG_Unable_To_Lock_Segment* = ERRLOG_BASE+2
  NELOG_Unable_To_Unlock_Segment* = ERRLOG_BASE+3
  NELOG_Uninstall_Service* = ERRLOG_BASE+4
  NELOG_Init_Exec_Fail* = ERRLOG_BASE+5
  NELOG_Ncb_Error* = ERRLOG_BASE+6
  NELOG_Net_Not_Started* = ERRLOG_BASE+7
  NELOG_Ioctl_Error* = ERRLOG_BASE+8
  NELOG_System_Semaphore* = ERRLOG_BASE+9
  NELOG_Init_OpenCreate_Err* = ERRLOG_BASE+10
  NELOG_NetBios* = ERRLOG_BASE+11
  NELOG_SMB_Illegal* = ERRLOG_BASE+12
  NELOG_Service_Fail* = ERRLOG_BASE+13
  NELOG_Entries_Lost* = ERRLOG_BASE+14
  NELOG_Init_Seg_Overflow* = ERRLOG_BASE+20
  NELOG_Srv_No_Mem_Grow* = ERRLOG_BASE+21
  NELOG_Access_File_Bad* = ERRLOG_BASE+22
  NELOG_Srvnet_Not_Started* = ERRLOG_BASE+23
  NELOG_Init_Chardev_Err* = ERRLOG_BASE+24
  NELOG_Remote_API* = ERRLOG_BASE+25
  NELOG_Ncb_TooManyErr* = ERRLOG_BASE+26
  NELOG_Mailslot_err* = ERRLOG_BASE+27
  NELOG_ReleaseMem_Alert* = ERRLOG_BASE+28
  NELOG_AT_cannot_write* = ERRLOG_BASE+29
  NELOG_Cant_Make_Msg_File* = ERRLOG_BASE+30
  NELOG_Exec_Netservr_NoMem* = ERRLOG_BASE+31
  NELOG_Server_Lock_Failure* = ERRLOG_BASE+32
  NELOG_Msg_Shutdown* = ERRLOG_BASE+40
  NELOG_Msg_Sem_Shutdown* = ERRLOG_BASE+41
  NELOG_Msg_Log_Err* = ERRLOG_BASE+50
  NELOG_VIO_POPUP_ERR* = ERRLOG_BASE+51
  NELOG_Msg_Unexpected_SMB_Type* = ERRLOG_BASE+52
  NELOG_Wksta_Infoseg* = ERRLOG_BASE+60
  NELOG_Wksta_Compname* = ERRLOG_BASE+61
  NELOG_Wksta_BiosThreadFailure* = ERRLOG_BASE+62
  NELOG_Wksta_IniSeg* = ERRLOG_BASE+63
  NELOG_Wksta_HostTab_Full* = ERRLOG_BASE+64
  NELOG_Wksta_Bad_Mailslot_SMB* = ERRLOG_BASE+65
  NELOG_Wksta_UASInit* = ERRLOG_BASE+66
  NELOG_Wksta_SSIRelogon* = ERRLOG_BASE+67
  NELOG_Build_Name* = ERRLOG_BASE+70
  NELOG_Name_Expansion* = ERRLOG_BASE+71
  NELOG_Message_Send* = ERRLOG_BASE+72
  NELOG_Mail_Slt_Err* = ERRLOG_BASE+73
  NELOG_AT_cannot_read* = ERRLOG_BASE+74
  NELOG_AT_sched_err* = ERRLOG_BASE+75
  NELOG_AT_schedule_file_created* = ERRLOG_BASE+76
  NELOG_Srvnet_NB_Open* = ERRLOG_BASE+77
  NELOG_AT_Exec_Err* = ERRLOG_BASE+78
  NELOG_Lazy_Write_Err* = ERRLOG_BASE+80
  NELOG_HotFix* = ERRLOG_BASE+81
  NELOG_HardErr_From_Server* = ERRLOG_BASE+82
  NELOG_LocalSecFail1* = ERRLOG_BASE+83
  NELOG_LocalSecFail2* = ERRLOG_BASE+84
  NELOG_LocalSecFail3* = ERRLOG_BASE+85
  NELOG_LocalSecGeneralFail* = ERRLOG_BASE+86
  NELOG_NetWkSta_Internal_Error* = ERRLOG_BASE+90
  NELOG_NetWkSta_No_Resource* = ERRLOG_BASE+91
  NELOG_NetWkSta_SMB_Err* = ERRLOG_BASE+92
  NELOG_NetWkSta_VC_Err* = ERRLOG_BASE+93
  NELOG_NetWkSta_Stuck_VC_Err* = ERRLOG_BASE+94
  NELOG_NetWkSta_NCB_Err* = ERRLOG_BASE+95
  NELOG_NetWkSta_Write_Behind_Err* = ERRLOG_BASE+96
  NELOG_NetWkSta_Reset_Err* = ERRLOG_BASE+97
  NELOG_NetWkSta_Too_Many* = ERRLOG_BASE+98
  NELOG_Srv_Thread_Failure* = ERRLOG_BASE+104
  NELOG_Srv_Close_Failure* = ERRLOG_BASE+105
  NELOG_ReplUserCurDir* = ERRLOG_BASE+106
  NELOG_ReplCannotMasterDir* = ERRLOG_BASE+107
  NELOG_ReplUpdateError* = ERRLOG_BASE+108
  NELOG_ReplLostMaster* = ERRLOG_BASE+109
  NELOG_NetlogonAuthDCFail* = ERRLOG_BASE+110
  NELOG_ReplLogonFailed* = ERRLOG_BASE+111
  NELOG_ReplNetErr* = ERRLOG_BASE+112
  NELOG_ReplMaxFiles* = ERRLOG_BASE+113
  NELOG_ReplMaxTreeDepth* = ERRLOG_BASE+114
  NELOG_ReplBadMsg* = ERRLOG_BASE+115
  NELOG_ReplSysErr* = ERRLOG_BASE+116
  NELOG_ReplUserLoged* = ERRLOG_BASE+117
  NELOG_ReplBadImport* = ERRLOG_BASE+118
  NELOG_ReplBadExport* = ERRLOG_BASE+119
  NELOG_ReplSignalFileErr* = ERRLOG_BASE+120
  NELOG_DiskFT* = ERRLOG_BASE+121
  NELOG_ReplAccessDenied* = ERRLOG_BASE+122
  NELOG_NetlogonFailedPrimary* = ERRLOG_BASE+123
  NELOG_NetlogonPasswdSetFailed* = ERRLOG_BASE+124
  NELOG_NetlogonTrackingError* = ERRLOG_BASE+125
  NELOG_NetlogonSyncError* = ERRLOG_BASE+126
  NELOG_NetlogonRequireSignOrSealError* = ERRLOG_BASE+127
  NELOG_UPS_PowerOut* = ERRLOG_BASE+130
  NELOG_UPS_Shutdown* = ERRLOG_BASE+131
  NELOG_UPS_CmdFileError* = ERRLOG_BASE+132
  NELOG_UPS_CannotOpenDriver* = ERRLOG_BASE+133
  NELOG_UPS_PowerBack* = ERRLOG_BASE+134
  NELOG_UPS_CmdFileConfig* = ERRLOG_BASE+135
  NELOG_UPS_CmdFileExec* = ERRLOG_BASE+136
  NELOG_Missing_Parameter* = ERRLOG_BASE+150
  NELOG_Invalid_Config_Line* = ERRLOG_BASE+151
  NELOG_Invalid_Config_File* = ERRLOG_BASE+152
  NELOG_File_Changed* = ERRLOG_BASE+153
  NELOG_Files_Dont_Fit* = ERRLOG_BASE+154
  NELOG_Wrong_DLL_Version* = ERRLOG_BASE+155
  NELOG_Error_in_DLL* = ERRLOG_BASE+156
  NELOG_System_Error* = ERRLOG_BASE+157
  NELOG_FT_ErrLog_Too_Large* = ERRLOG_BASE+158
  NELOG_FT_Update_In_Progress* = ERRLOG_BASE+159
  NELOG_Joined_Domain* = ERRLOG_BASE+160
  NELOG_Joined_Workgroup* = ERRLOG_BASE+161
  NELOG_OEM_Code* = ERRLOG_BASE+199
  ERRLOG2_BASE* = 5700
  NELOG_NetlogonSSIInitError* = ERRLOG2_BASE+0
  NELOG_NetlogonFailedToUpdateTrustList* = ERRLOG2_BASE+1
  NELOG_NetlogonFailedToAddRpcInterface* = ERRLOG2_BASE+2
  NELOG_NetlogonFailedToReadMailslot* = ERRLOG2_BASE+3
  NELOG_NetlogonFailedToRegisterSC* = ERRLOG2_BASE+4
  NELOG_NetlogonChangeLogCorrupt* = ERRLOG2_BASE+5
  NELOG_NetlogonFailedToCreateShare* = ERRLOG2_BASE+6
  NELOG_NetlogonDownLevelLogonFailed* = ERRLOG2_BASE+7
  NELOG_NetlogonDownLevelLogoffFailed* = ERRLOG2_BASE+8
  NELOG_NetlogonNTLogonFailed* = ERRLOG2_BASE+9
  NELOG_NetlogonNTLogoffFailed* = ERRLOG2_BASE+10
  NELOG_NetlogonPartialSyncCallSuccess* = ERRLOG2_BASE+11
  NELOG_NetlogonPartialSyncCallFailed* = ERRLOG2_BASE+12
  NELOG_NetlogonFullSyncCallSuccess* = ERRLOG2_BASE+13
  NELOG_NetlogonFullSyncCallFailed* = ERRLOG2_BASE+14
  NELOG_NetlogonPartialSyncSuccess* = ERRLOG2_BASE+15
  NELOG_NetlogonPartialSyncFailed* = ERRLOG2_BASE+16
  NELOG_NetlogonFullSyncSuccess* = ERRLOG2_BASE+17
  NELOG_NetlogonFullSyncFailed* = ERRLOG2_BASE+18
  NELOG_NetlogonAuthNoDomainController* = ERRLOG2_BASE+19
  NELOG_NetlogonAuthNoTrustLsaSecret* = ERRLOG2_BASE+20
  NELOG_NetlogonAuthNoTrustSamAccount* = ERRLOG2_BASE+21
  NELOG_NetlogonServerAuthFailed* = ERRLOG2_BASE+22
  NELOG_NetlogonServerAuthNoTrustSamAccount* = ERRLOG2_BASE+23
  NELOG_FailedToRegisterSC* = ERRLOG2_BASE+24
  NELOG_FailedToSetServiceStatus* = ERRLOG2_BASE+25
  NELOG_FailedToGetComputerName* = ERRLOG2_BASE+26
  NELOG_DriverNotLoaded* = ERRLOG2_BASE+27
  NELOG_NoTranportLoaded* = ERRLOG2_BASE+28
  NELOG_NetlogonFailedDomainDelta* = ERRLOG2_BASE+29
  NELOG_NetlogonFailedGlobalGroupDelta* = ERRLOG2_BASE+30
  NELOG_NetlogonFailedLocalGroupDelta* = ERRLOG2_BASE+31
  NELOG_NetlogonFailedUserDelta* = ERRLOG2_BASE+32
  NELOG_NetlogonFailedPolicyDelta* = ERRLOG2_BASE+33
  NELOG_NetlogonFailedTrustedDomainDelta* = ERRLOG2_BASE+34
  NELOG_NetlogonFailedAccountDelta* = ERRLOG2_BASE+35
  NELOG_NetlogonFailedSecretDelta* = ERRLOG2_BASE+36
  NELOG_NetlogonSystemError* = ERRLOG2_BASE+37
  NELOG_NetlogonDuplicateMachineAccounts* = ERRLOG2_BASE+38
  NELOG_NetlogonTooManyGlobalGroups* = ERRLOG2_BASE+39
  NELOG_NetlogonBrowserDriver* = ERRLOG2_BASE+40
  NELOG_NetlogonAddNameFailure* = ERRLOG2_BASE+41
  NELOG_RplMessages* = ERRLOG2_BASE+42
  NELOG_RplXnsBoot* = ERRLOG2_BASE+43
  NELOG_RplSystem* = ERRLOG2_BASE+44
  NELOG_RplWkstaTimeout* = ERRLOG2_BASE+45
  NELOG_RplWkstaFileOpen* = ERRLOG2_BASE+46
  NELOG_RplWkstaFileRead* = ERRLOG2_BASE+47
  NELOG_RplWkstaMemory* = ERRLOG2_BASE+48
  NELOG_RplWkstaFileChecksum* = ERRLOG2_BASE+49
  NELOG_RplWkstaFileLineCount* = ERRLOG2_BASE+50
  NELOG_RplWkstaBbcFile* = ERRLOG2_BASE+51
  NELOG_RplWkstaFileSize* = ERRLOG2_BASE+52
  NELOG_RplWkstaInternal* = ERRLOG2_BASE+53
  NELOG_RplWkstaWrongVersion* = ERRLOG2_BASE+54
  NELOG_RplWkstaNetwork* = ERRLOG2_BASE+55
  NELOG_RplAdapterResource* = ERRLOG2_BASE+56
  NELOG_RplFileCopy* = ERRLOG2_BASE+57
  NELOG_RplFileDelete* = ERRLOG2_BASE+58
  NELOG_RplFilePerms* = ERRLOG2_BASE+59
  NELOG_RplCheckConfigs* = ERRLOG2_BASE+60
  NELOG_RplCreateProfiles* = ERRLOG2_BASE+61
  NELOG_RplRegistry* = ERRLOG2_BASE+62
  NELOG_RplReplaceRPLDISK* = ERRLOG2_BASE+63
  NELOG_RplCheckSecurity* = ERRLOG2_BASE+64
  NELOG_RplBackupDatabase* = ERRLOG2_BASE+65
  NELOG_RplInitDatabase* = ERRLOG2_BASE+66
  NELOG_RplRestoreDatabaseFailure* = ERRLOG2_BASE+67
  NELOG_RplRestoreDatabaseSuccess* = ERRLOG2_BASE+68
  NELOG_RplInitRestoredDatabase* = ERRLOG2_BASE+69
  NELOG_NetlogonSessionTypeWrong* = ERRLOG2_BASE+70
  NELOG_RplUpgradeDBTo40* = ERRLOG2_BASE+71
  NELOG_NetlogonLanmanBdcsNotAllowed* = ERRLOG2_BASE+72
  NELOG_NetlogonNoDynamicDns* = ERRLOG2_BASE+73
  NELOG_NetlogonDynamicDnsRegisterFailure* = ERRLOG2_BASE+74
  NELOG_NetlogonDynamicDnsDeregisterFailure* = ERRLOG2_BASE+75
  NELOG_NetlogonFailedFileCreate* = ERRLOG2_BASE+76
  NELOG_NetlogonGetSubnetToSite* = ERRLOG2_BASE+77
  NELOG_NetlogonNoSiteForClient* = ERRLOG2_BASE+78
  NELOG_NetlogonBadSiteName* = ERRLOG2_BASE+79
  NELOG_NetlogonBadSubnetName* = ERRLOG2_BASE+80
  NELOG_NetlogonDynamicDnsServerFailure* = ERRLOG2_BASE+81
  NELOG_NetlogonDynamicDnsFailure* = ERRLOG2_BASE+82
  NELOG_NetlogonRpcCallCancelled* = ERRLOG2_BASE+83
  NELOG_NetlogonDcSiteCovered* = ERRLOG2_BASE+84
  NELOG_NetlogonDcSiteNotCovered* = ERRLOG2_BASE+85
  NELOG_NetlogonGcSiteCovered* = ERRLOG2_BASE+86
  NELOG_NetlogonGcSiteNotCovered* = ERRLOG2_BASE+87
  NELOG_NetlogonFailedSpnUpdate* = ERRLOG2_BASE+88
  NELOG_NetlogonFailedDnsHostNameUpdate* = ERRLOG2_BASE+89
  NELOG_NetlogonAuthNoUplevelDomainController* = ERRLOG2_BASE+90
  NELOG_NetlogonAuthDomainDowngraded* = ERRLOG2_BASE+91
  NELOG_NetlogonNdncSiteCovered* = ERRLOG2_BASE+92
  NELOG_NetlogonNdncSiteNotCovered* = ERRLOG2_BASE+93
  NELOG_NetlogonDcOldSiteCovered* = ERRLOG2_BASE+94
  NELOG_NetlogonDcSiteNotCoveredAuto* = ERRLOG2_BASE+95
  NELOG_NetlogonGcOldSiteCovered* = ERRLOG2_BASE+96
  NELOG_NetlogonGcSiteNotCoveredAuto* = ERRLOG2_BASE+97
  NELOG_NetlogonNdncOldSiteCovered* = ERRLOG2_BASE+98
  NELOG_NetlogonNdncSiteNotCoveredAuto* = ERRLOG2_BASE+99
  NELOG_NetlogonSpnMultipleSamAccountNames* = ERRLOG2_BASE+100
  NELOG_NetlogonSpnCrackNamesFailure* = ERRLOG2_BASE+101
  NELOG_NetlogonNoAddressToSiteMapping* = ERRLOG2_BASE+102
  NELOG_NetlogonInvalidGenericParameterValue* = ERRLOG2_BASE+103
  NELOG_NetlogonInvalidDwordParameterValue* = ERRLOG2_BASE+104
  NELOG_NetlogonServerAuthFailedNoAccount* = ERRLOG2_BASE+105
  NELOG_NetlogonNoDynamicDnsManual* = ERRLOG2_BASE+106
  NELOG_NetlogonNoSiteForClients* = ERRLOG2_BASE+107
  NELOG_NetlogonDnsDeregAborted* = ERRLOG2_BASE+108
  NELOG_NetlogonRpcPortRequestFailure* = ERRLOG2_BASE+109
  STATSOPT_CLR* = 1
  STATS_NO_VALUE* = -1
  STATS_OVERFLOW* = -2
  ACTION_LOCKOUT* = 00
  ACTION_ADMINUNLOCK* = 01
  AE_SRVSTATUS* = 0
  AE_SESSLOGON* = 1
  AE_SESSLOGOFF* = 2
  AE_SESSPWERR* = 3
  AE_CONNSTART* = 4
  AE_CONNSTOP* = 5
  AE_CONNREJ* = 6
  AE_RESACCESS* = 7
  AE_RESACCESSREJ* = 8
  AE_CLOSEFILE* = 9
  AE_SERVICESTAT* = 11
  AE_ACLMOD* = 12
  AE_UASMOD* = 13
  AE_NETLOGON* = 14
  AE_NETLOGOFF* = 15
  AE_NETLOGDENIED* = 16
  AE_ACCLIMITEXCD* = 17
  AE_RESACCESS2* = 18
  AE_ACLMODFAIL* = 19
  AE_LOCKOUT* = 20
  AE_GENERIC_TYPE* = 21
  AE_SRVSTART* = 0
  AE_SRVPAUSED* = 1
  AE_SRVCONT* = 2
  AE_SRVSTOP* = 3
  AE_GUEST* = 0
  AE_USER* = 1
  AE_ADMIN* = 2
  AE_NORMAL* = 0
  AE_USERLIMIT* = 0
  AE_GENERAL* = 0
  AE_ERROR* = 1
  AE_SESSDIS* = 1
  AE_BADPW* = 1
  AE_AUTODIS* = 2
  AE_UNSHARE* = 2
  AE_ADMINPRIVREQD* = 2
  AE_ADMINDIS* = 3
  AE_NOACCESSPERM* = 3
  AE_ACCRESTRICT* = 4
  AE_NORMAL_CLOSE* = 0
  AE_SES_CLOSE* = 1
  AE_ADMIN_CLOSE* = 2
  AE_LIM_UNKNOWN* = 0
  AE_LIM_LOGONHOURS* = 1
  AE_LIM_EXPIRED* = 2
  AE_LIM_INVAL_WKSTA* = 3
  AE_LIM_DISABLED* = 4
  AE_LIM_DELETED* = 5
  AE_MOD* = 0
  AE_DELETE* = 1
  AE_ADD* = 2
  AE_UAS_USER* = 0
  AE_UAS_GROUP* = 1
  AE_UAS_MODALS* = 2
  SVAUD_SERVICE* = 0x1
  SVAUD_GOODSESSLOGON* = 0x6
  SVAUD_BADSESSLOGON* = 0x18
  SVAUD_SESSLOGON* = SVAUD_GOODSESSLOGON or SVAUD_BADSESSLOGON
  SVAUD_GOODNETLOGON* = 0x60
  SVAUD_BADNETLOGON* = 0x180
  SVAUD_NETLOGON* = SVAUD_GOODNETLOGON or SVAUD_BADNETLOGON
  SVAUD_LOGON* = SVAUD_NETLOGON or SVAUD_SESSLOGON
  SVAUD_GOODUSE* = 0x600
  SVAUD_BADUSE* = 0x1800
  SVAUD_USE* = SVAUD_GOODUSE or SVAUD_BADUSE
  SVAUD_USERLIST* = 0x2000
  SVAUD_PERMISSIONS* = 0x4000
  SVAUD_RESOURCE* = 0x8000
  SVAUD_LOGONLIM* = 0x00010000
  AA_AUDIT_ALL* = 0x0001
  AA_A_OWNER* = 0x0004
  AA_CLOSE* = 0x0008
  AA_S_OPEN* = 0x0010
  AA_S_WRITE* = 0x0020
  AA_S_CREATE* = 0x0020
  AA_S_DELETE* = 0x0040
  AA_S_ACL* = 0x0080
  AA_S_ALL* = AA_S_OPEN or AA_S_WRITE or AA_S_DELETE or AA_S_ACL
  AA_F_OPEN* = 0x0100
  AA_F_WRITE* = 0x0200
  AA_F_CREATE* = 0x0200
  AA_F_DELETE* = 0x0400
  AA_F_ACL* = 0x0800
  AA_F_ALL* = AA_F_OPEN or AA_F_WRITE or AA_F_DELETE or AA_F_ACL
  AA_A_OPEN* = 0x1000
  AA_A_WRITE* = 0x2000
  AA_A_CREATE* = 0x2000
  AA_A_DELETE* = 0x4000
  AA_A_ACL* = 0x8000
  AA_A_ALL* = AA_F_OPEN or AA_F_WRITE or AA_F_DELETE or AA_F_ACL
  netSetupUnknown* = 0
  netSetupMachine* = 1
  netSetupWorkgroup* = 2
  netSetupDomain* = 3
  netSetupNonExistentDomain* = 4
  netSetupDnsMachine* = 5
  netSetupUnknownStatus* = 0
  netSetupUnjoined* = 1
  netSetupWorkgroupName* = 2
  netSetupDomainName* = 3
  NETSETUP_JOIN_DOMAIN* = 0x00000001
  NETSETUP_ACCT_CREATE* = 0x00000002
  NETSETUP_ACCT_DELETE* = 0x00000004
  NETSETUP_WIN9X_UPGRADE* = 0x00000010
  NETSETUP_DOMAIN_JOIN_IF_JOINED* = 0x00000020
  NETSETUP_JOIN_UNSECURE* = 0x00000040
  NETSETUP_MACHINE_PWD_PASSED* = 0x00000080
  NETSETUP_DEFER_SPN_SET* = 0x00000100
  NETSETUP_INSTALL_INVOCATION* = 0x00040000
  NETSETUP_IGNORE_UNSUPPORTED_FLAGS* = 0x10000000
  NETSETUP_VALID_UNJOIN_FLAGS* = NETSETUP_ACCT_DELETE or NETSETUP_IGNORE_UNSUPPORTED_FLAGS
  NET_IGNORE_UNSUPPORTED_FLAGS* = 0x01
  netPrimaryComputerName* = 0
  netAlternateComputerNames* = 1
  netAllComputerNames* = 2
  netComputerNameTypeMax* = 3
  JOB_RUN_PERIODICALLY* = 0x01
  JOB_EXEC_ERROR* = 0x02
  JOB_RUNS_TODAY* = 0x04
  JOB_ADD_CURRENT_DATE* = 0x08
  JOB_NONINTERACTIVE* = 0x10
  JOB_INPUT_FLAGS* = JOB_RUN_PERIODICALLY or JOB_ADD_CURRENT_DATE or JOB_NONINTERACTIVE
  JOB_OUTPUT_FLAGS* = JOB_RUN_PERIODICALLY or JOB_EXEC_ERROR or JOB_RUNS_TODAY or JOB_NONINTERACTIVE
  DFS_VOLUME_STATES* = 0xF
  DFS_VOLUME_STATE_OK* = 1
  DFS_VOLUME_STATE_INCONSISTENT* = 2
  DFS_VOLUME_STATE_OFFLINE* = 3
  DFS_VOLUME_STATE_ONLINE* = 4
  DFS_VOLUME_STATE_RESYNCHRONIZE* = 0x10
  DFS_VOLUME_STATE_STANDBY* = 0x20
  DFS_VOLUME_FLAVORS* = 0x0300
  DFS_VOLUME_FLAVOR_UNUSED1* = 0x0000
  DFS_VOLUME_FLAVOR_STANDALONE* = 0x0100
  DFS_VOLUME_FLAVOR_AD_BLOB* = 0x0200
  DFS_STORAGE_FLAVOR_UNUSED2* = 0x0300
  DFS_STORAGE_STATES* = 0xF
  DFS_STORAGE_STATE_OFFLINE* = 1
  DFS_STORAGE_STATE_ONLINE* = 2
  DFS_STORAGE_STATE_ACTIVE* = 4
  dfsInvalidPriorityClass* = -1
  dfsSiteCostNormalPriorityClass* = 0
  dfsGlobalHighPriorityClass* = 1
  dfsSiteCostHighPriorityClass* = 2
  dfsSiteCostLowPriorityClass* = 3
  dfsGlobalLowPriorityClass* = 4
  DFS_PROPERTY_FLAG_INSITE_REFERRALS* = 0x00000001
  DFS_PROPERTY_FLAG_ROOT_SCALABILITY* = 0x00000002
  DFS_PROPERTY_FLAG_SITE_COSTING* = 0x00000004
  DFS_PROPERTY_FLAG_TARGET_FAILBACK* = 0x00000008
  DFS_PROPERTY_FLAG_CLUSTER_ENABLED* = 0x00000010
  DFS_PROPERTY_FLAG_ABDE* = 0x00000020
  DFS_NAMESPACE_CAPABILITY_ABDE* = 0x0000000000000001
  DFS_NAMESPACE_VERSION_ORIGIN_COMBINED* = 0
  DFS_NAMESPACE_VERSION_ORIGIN_SERVER* = 1
  DFS_NAMESPACE_VERSION_ORIGIN_DOMAIN* = 2
  DFS_ADD_VOLUME* = 1
  DFS_RESTORE_VOLUME* = 2
  NET_DFS_SETDC_FLAGS* = 0x00000000
  NET_DFS_SETDC_TIMEOUT* = 0x00000001
  NET_DFS_SETDC_INITPKT* = 0x00000002
  DFS_SITE_PRIMARY* = 0x1
  DFS_MOVE_FLAG_REPLACE_IF_EXISTS* = 0x00000001
  PARM_ERROR_UNKNOWN* = DWORD(-1)
  USE_WILDCARD* = DWORD(-1)
  MAXDEVENTRIES* = sizeof(int32)*8
proc NetUserAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserEnum*(servername: LPCWSTR, level: DWORD, filter: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserGetInfo*(servername: LPCWSTR, username: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserSetInfo*(servername: LPCWSTR, username: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserDel*(servername: LPCWSTR, username: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserGetGroups*(servername: LPCWSTR, username: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserSetGroups*(servername: LPCWSTR, username: LPCWSTR, level: DWORD, buf: LPBYTE, num_entries: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserGetLocalGroups*(servername: LPCWSTR, username: LPCWSTR, level: DWORD, flags: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserModalsGet*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserModalsSet*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUserChangePassword*(domainname: LPCWSTR, username: LPCWSTR, oldpassword: LPCWSTR, newpassword: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupAddUser*(servername: LPCWSTR, GroupName: LPCWSTR, username: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: PDWORD_PTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupGetInfo*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupSetInfo*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupDel*(servername: LPCWSTR, groupname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupDelUser*(servername: LPCWSTR, GroupName: LPCWSTR, Username: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupGetUsers*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, ResumeHandle: PDWORD_PTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGroupSetUsers*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, totalentries: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupAddMember*(servername: LPCWSTR, groupname: LPCWSTR, membersid: PSID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: PDWORD_PTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupGetInfo*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupSetInfo*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupDel*(servername: LPCWSTR, groupname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupDelMember*(servername: LPCWSTR, groupname: LPCWSTR, membersid: PSID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupGetMembers*(servername: LPCWSTR, localgroupname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: PDWORD_PTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupSetMembers*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, totalentries: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupAddMembers*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, totalentries: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetLocalGroupDelMembers*(servername: LPCWSTR, groupname: LPCWSTR, level: DWORD, buf: LPBYTE, totalentries: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetQueryDisplayInformation*(ServerName: LPCWSTR, Level: DWORD, Index: DWORD, EntriesRequested: DWORD, PreferredMaximumLength: DWORD, ReturnedEntryCount: LPDWORD, SortedBuffer: ptr PVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGetDisplayInformationIndex*(ServerName: LPCWSTR, Level: DWORD, Prefix: LPCWSTR, Index: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessEnum*(servername: LPCWSTR, BasePath: LPCWSTR, Recursive: DWORD, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessGetInfo*(servername: LPCWSTR, resource: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessSetInfo*(servername: LPCWSTR, resource: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessDel*(servername: LPCWSTR, resource: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc RxNetAccessGetUserPerms*(servername: LPCWSTR, UGname: LPCWSTR, resource: LPCWSTR, Perms: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetValidatePasswordPolicy*(ServerName: LPCWSTR, Qualifier: LPVOID, ValidationType: NET_VALIDATE_PASSWORD_TYPE, InputArg: LPVOID, OutputArg: ptr LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetValidatePasswordPolicyFree*(OutputArg: ptr LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGetDCName*(servername: LPCWSTR, domainname: LPCWSTR, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGetAnyDCName*(servername: LPCWSTR, domainname: LPCWSTR, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc I_NetLogonControl*(ServerName: LPCWSTR, FunctionCode: DWORD, QueryLevel: DWORD, Buffer: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc I_NetLogonControl2*(ServerName: LPCWSTR, FunctionCode: DWORD, QueryLevel: DWORD, Data: LPBYTE, Buffer: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetEnumerateTrustedDomains*(ServerName: LPWSTR, DomainNames: ptr LPWSTR): NTSTATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAddServiceAccount*(ServerName: LPWSTR, AccountName: LPWSTR, Reserved: LPWSTR, Flags: DWORD): NTSTATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRemoveServiceAccount*(ServerName: LPWSTR, AccountName: LPWSTR, Flags: DWORD): NTSTATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetIsServiceAccount*(ServerName: LPWSTR, AccountName: LPWSTR, IsService: ptr BOOL): NTSTATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetEnumerateServiceAccounts*(ServerName: LPWSTR, Flags: DWORD, AccountsCount: ptr DWORD, Accounts: ptr PZPWSTR): NTSTATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAlertRaise*(AlertEventName: LPCWSTR, Buffer: LPVOID, BufferSize: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAlertRaiseEx*(AlertEventName: LPCWSTR, VariableInfo: LPVOID, VariableInfoSize: DWORD, ServiceName: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareAdd*(servername: LMSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareEnum*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareEnumSticky*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareGetInfo*(servername: LMSTR, netname: LMSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareSetInfo*(servername: LMSTR, netname: LMSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareDel*(servername: LMSTR, netname: LMSTR, reserved: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareDelSticky*(servername: LMSTR, netname: LMSTR, reserved: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareCheck*(servername: LMSTR, device: LMSTR, `type`: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetSessionEnum*(servername: LMSTR, UncClientName: LMSTR, username: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetSessionDel*(servername: LMSTR, UncClientName: LMSTR, username: LMSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetSessionGetInfo*(servername: LMSTR, UncClientName: LMSTR, username: LMSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetConnectionEnum*(servername: LMSTR, qualifier: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetFileClose*(servername: LMSTR, fileid: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetFileEnum*(servername: LMSTR, basepath: LMSTR, username: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: PDWORD_PTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetFileGetInfo*(servername: LMSTR, fileid: DWORD, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetMessageNameAdd*(servername: LPCWSTR, msgname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetMessageNameEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetMessageNameGetInfo*(servername: LPCWSTR, msgname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetMessageNameDel*(servername: LPCWSTR, msgname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetMessageBufferSend*(servername: LPCWSTR, msgname: LPCWSTR, fromname: LPCWSTR, buf: LPBYTE, buflen: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRemoteTOD*(UncServerName: LPCWSTR, BufferPtr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRemoteComputerSupports*(UncServerName: LPCWSTR, OptionsWanted: DWORD, OptionsSupported: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplGetInfo*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplSetInfo*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirDel*(servername: LPCWSTR, dirname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirGetInfo*(servername: LPCWSTR, dirname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirSetInfo*(servername: LPCWSTR, dirname: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirLock*(servername: LPCWSTR, dirname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplExportDirUnlock*(servername: LPCWSTR, dirname: LPCWSTR, unlockforce: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirDel*(servername: LPCWSTR, dirname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirGetInfo*(servername: LPCWSTR, dirname: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirLock*(servername: LPCWSTR, dirname: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetReplImportDirUnlock*(servername: LPCWSTR, dirname: LPCWSTR, unlockforce: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerEnum*(servername: LMCSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, servertype: DWORD, domain: LMCSTR, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerEnumEx*(ServerName: LMCSTR, Level: DWORD, Bufptr: ptr LPBYTE, PrefMaxlen: DWORD, EntriesRead: LPDWORD, totalentries: LPDWORD, servertype: DWORD, domain: LMCSTR, FirstNameToReturn: LMCSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerGetInfo*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerSetInfo*(servername: LMSTR, level: DWORD, buf: LPBYTE, ParmError: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerDiskEnum*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerComputerNameAdd*(ServerName: LMSTR, EmulatedDomainName: LMSTR, EmulatedServerName: LMSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerComputerNameDel*(ServerName: LMSTR, EmulatedServerName: LMSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerTransportAdd*(servername: LMSTR, level: DWORD, bufptr: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerTransportAddEx*(servername: LMSTR, level: DWORD, bufptr: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerTransportDel*(servername: LMSTR, level: DWORD, bufptr: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServerTransportEnum*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc SetServiceBits*(hServiceStatus: SERVICE_STATUS_HANDLE, dwServiceBits: DWORD, bSetBitsOn: WINBOOL, bUpdateImmediately: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "advapi32", importc.}
proc NetServiceControl*(servername: LPCWSTR, service: LPCWSTR, opcode: DWORD, arg: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServiceEnum*(servername: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServiceGetInfo*(servername: LPCWSTR, service: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetServiceInstall*(servername: LPCWSTR, service: LPCWSTR, argc: DWORD, argv: ptr LPCWSTR, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUseAdd*(UncServerName: LMSTR, Level: DWORD, Buf: LPBYTE, ParmError: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUseDel*(UncServerName: LMSTR, UseName: LMSTR, ForceCond: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUseEnum*(UncServerName: LMSTR, Level: DWORD, BufPtr: ptr LPBYTE, PreferedMaximumSize: DWORD, EntriesRead: LPDWORD, TotalEntries: LPDWORD, ResumeHandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUseGetInfo*(UncServerName: LMSTR, UseName: LMSTR, Level: DWORD, BufPtr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaGetInfo*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaSetInfo*(servername: LMSTR, level: DWORD, buffer: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaUserGetInfo*(reserved: LMSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaUserSetInfo*(reserved: LMSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaUserEnum*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaTransportAdd*(servername: LMSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaTransportDel*(servername: LMSTR, transportname: LMSTR, ucond: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetWkstaTransportEnum*(servername: LMSTR, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resumehandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetApiBufferAllocate*(ByteCount: DWORD, Buffer: ptr LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetApiBufferFree*(Buffer: LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetApiBufferReallocate*(OldBuffer: LPVOID, NewByteCount: DWORD, NewBuffer: ptr LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetApiBufferSize*(Buffer: LPVOID, ByteCount: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetapipBufferAllocate*(ByteCount: DWORD, Buffer: ptr LPVOID): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetErrorLogClear*(server: LPCWSTR, backupfile: LPCWSTR, reserved: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetErrorLogRead*(server: LPCWSTR, reserved1: LPWSTR, errloghandle: LPHLOG, offset: DWORD, reserved2: LPDWORD, reserved3: DWORD, offsetflag: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, bytesread: LPDWORD, totalbytes: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetErrorLogWrite*(reserved1: LPBYTE, code: DWORD, component: LPCWSTR, buffer: LPBYTE, numbytes: DWORD, msgbuf: LPBYTE, strcount: DWORD, reserved2: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetConfigGet*(server: LPCWSTR, component: LPCWSTR, parameter: LPCWSTR, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetConfigGetAll*(server: LPCWSTR, component: LPCWSTR, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetConfigSet*(server: LPCWSTR, reserved1: LPCWSTR, component: LPCWSTR, level: DWORD, reserved2: DWORD, buf: LPBYTE, reserved3: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRegisterDomainNameChangeNotification*(NotificationEventHandle: PHANDLE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUnregisterDomainNameChangeNotification*(NotificationEventHandle: HANDLE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetStatisticsGet*(server: LMSTR, service: LMSTR, level: DWORD, options: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAuditClear*(server: LPCWSTR, backupfile: LPCWSTR, service: LPCWSTR): DWORD {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAuditRead*(server: LPCWSTR, service: LPCWSTR, auditloghandle: LPHLOG, offset: DWORD, reserved1: LPDWORD, reserved2: DWORD, offsetflag: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, bytesread: LPDWORD, totalavailable: LPDWORD): DWORD {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAuditWrite*(`type`: DWORD, buf: LPBYTE, numbytes: DWORD, service: LPCWSTR, reserved: LPBYTE): DWORD {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetJoinDomain*(lpServer: LPCWSTR, lpDomain: LPCWSTR, lpAccountOU: LPCWSTR, lpAccount: LPCWSTR, lpPassword: LPCWSTR, fJoinOptions: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetUnjoinDomain*(lpServer: LPCWSTR, lpAccount: LPCWSTR, lpPassword: LPCWSTR, fUnjoinOptions: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRenameMachineInDomain*(lpServer: LPCWSTR, lpNewMachineName: LPCWSTR, lpAccount: LPCWSTR, lpPassword: LPCWSTR, fRenameOptions: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetValidateName*(lpServer: LPCWSTR, lpName: LPCWSTR, lpAccount: LPCWSTR, lpPassword: LPCWSTR, NameType: NETSETUP_NAME_TYPE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGetJoinInformation*(lpServer: LPCWSTR, lpNameBuffer: ptr LPWSTR, BufferType: PNETSETUP_JOIN_STATUS): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetGetJoinableOUs*(lpServer: LPCWSTR, lpDomain: LPCWSTR, lpAccount: LPCWSTR, lpPassword: LPCWSTR, OUCount: ptr DWORD, OUs: ptr ptr LPWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAddAlternateComputerName*(Server: LPCWSTR, AlternateName: LPCWSTR, DomainAccount: LPCWSTR, DomainAccountPassword: LPCWSTR, Reserved: ULONG): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetRemoveAlternateComputerName*(Server: LPCWSTR, AlternateName: LPCWSTR, DomainAccount: LPCWSTR, DomainAccountPassword: LPCWSTR, Reserved: ULONG): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetSetPrimaryComputerName*(Server: LPCWSTR, PrimaryName: LPCWSTR, DomainAccount: LPCWSTR, DomainAccountPassword: LPCWSTR, Reserved: ULONG): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetEnumerateComputerNames*(Server: LPCWSTR, NameType: NET_COMPUTER_NAME_TYPE, Reserved: ULONG, EntryCount: PDWORD, ComputerNames: ptr ptr LPWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetScheduleJobAdd*(Servername: LPCWSTR, Buffer: LPBYTE, JobId: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetScheduleJobDel*(Servername: LPCWSTR, MinJobId: DWORD, MaxJobId: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetScheduleJobEnum*(Servername: LPCWSTR, PointerToBuffer: ptr LPBYTE, PrefferedMaximumLength: DWORD, EntriesRead: LPDWORD, TotalEntries: LPDWORD, ResumeHandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetScheduleJobGetInfo*(Servername: LPCWSTR, JobId: DWORD, PointerToBuffer: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetShareDelEx*(servername: LMSTR, level: DWORD, buf: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsAdd*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR, Comment: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsAddStdRoot*(ServerName: LPWSTR, RootShare: LPWSTR, Comment: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsRemoveStdRoot*(ServerName: LPWSTR, RootShare: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsAddFtRoot*(ServerName: LPWSTR, RootShare: LPWSTR, FtDfsName: LPWSTR, Comment: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsRemoveFtRoot*(ServerName: LPWSTR, RootShare: LPWSTR, FtDfsName: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsRemoveFtRootForced*(DomainName: LPWSTR, ServerName: LPWSTR, RootShare: LPWSTR, FtDfsName: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsManagerInitialize*(ServerName: LPWSTR, Flags: DWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsAddStdRootForced*(ServerName: LPWSTR, RootShare: LPWSTR, Comment: LPWSTR, Store: LPWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetDcAddress*(ServerName: LPWSTR, DcIpAddress: ptr LPWSTR, IsRoot: ptr BOOLEAN, Timeout: ptr ULONG): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsRemove*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsEnum*(DfsName: LPWSTR, Level: DWORD, PrefMaxLen: DWORD, Buffer: ptr LPBYTE, EntriesRead: LPDWORD, ResumeHandle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetInfo*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR, Level: DWORD, Buffer: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsSetInfo*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR, Level: DWORD, Buffer: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetClientInfo*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR, Level: DWORD, Buffer: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsSetClientInfo*(DfsEntryPath: LPWSTR, ServerName: LPWSTR, ShareName: LPWSTR, Level: DWORD, Buffer: LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsMove*(DfsEntryPath: LPWSTR, DfsNewEntryPath: LPWSTR, Flags: ULONG): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsRename*(Path: LPWSTR, NewPath: LPWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetSecurity*(DfsEntryPath: LPWSTR, SecurityInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, lpcbSecurityDescriptor: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsSetSecurity*(DfsEntryPath: LPWSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetStdContainerSecurity*(MachineName: LPWSTR, SecurityInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, lpcbSecurityDescriptor: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsSetStdContainerSecurity*(MachineName: LPWSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsGetFtContainerSecurity*(DomainName: LPWSTR, SecurityInformation: SECURITY_INFORMATION, ppSecurityDescriptor: ptr PSECURITY_DESCRIPTOR, lpcbSecurityDescriptor: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetDfsSetFtContainerSecurity*(DomainName: LPWSTR, SecurityInformation: SECURITY_INFORMATION, pSecurityDescriptor: PSECURITY_DESCRIPTOR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc.}
proc NetAccessAdd*(servername: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessAdd".}
proc NetAccessEnum*(servername: LPCWSTR, BasePath: LPCWSTR, Recursive: DWORD, level: DWORD, bufptr: ptr LPBYTE, prefmaxlen: DWORD, entriesread: LPDWORD, totalentries: LPDWORD, resume_handle: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessEnum".}
proc NetAccessGetInfo*(servername: LPCWSTR, resource: LPCWSTR, level: DWORD, bufptr: ptr LPBYTE): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessGetInfo".}
proc NetAccessSetInfo*(servername: LPCWSTR, resource: LPCWSTR, level: DWORD, buf: LPBYTE, parm_err: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessSetInfo".}
proc NetAccessDel*(servername: LPCWSTR, resource: LPCWSTR): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessDel".}
proc NetAccessGetUserPerms*(servername: LPCWSTR, UGname: LPCWSTR, resource: LPCWSTR, Perms: LPDWORD): NET_API_STATUS {.winapi, stdcall, dynlib: "netapi32", importc: "RxNetAccessGetUserPerms".}
when winimUnicode:
  type
    PORT_INFO_FF* = PORT_INFO_FFW
    PPORT_INFO_FF* = PPORT_INFO_FFW
    LPPORT_INFO_FF* = LPPORT_INFO_FFW
when winimAnsi:
  type
    PORT_INFO_FF* = PORT_INFO_FFA
    PPORT_INFO_FF* = PPORT_INFO_FFA
    LPPORT_INFO_FF* = LPPORT_INFO_FFA
when winimCpu64:
  type
    DFS_STORAGE_INFO_0_32* {.pure.} = object
      State*: ULONG
      ServerName*: ULONG
      ShareName*: ULONG
    PDFS_STORAGE_INFO_0_32* = ptr DFS_STORAGE_INFO_0_32
    LPDFS_STORAGE_INFO_0_32* = ptr DFS_STORAGE_INFO_0_32
    DFS_INFO_3_32* {.pure.} = object
      EntryPath*: ULONG
      Comment*: ULONG
      State*: DWORD
      NumberOfStorages*: DWORD
      Storage*: ULONG
    PDFS_INFO_3_32* = ptr DFS_INFO_3_32
    LPDFS_INFO_3_32* = ptr DFS_INFO_3_32
    DFS_INFO_4_32* {.pure.} = object
      EntryPath*: ULONG
      Comment*: ULONG
      State*: DWORD
      Timeout*: ULONG
      Guid*: GUID
      NumberOfStorages*: DWORD
      Storage*: ULONG
    PDFS_INFO_4_32* = ptr DFS_INFO_4_32
    LPDFS_INFO_4_32* = ptr DFS_INFO_4_32
