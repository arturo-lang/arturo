######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/dialogs.nim
######################################################

#=======================================
# Libraries
#=======================================

import extras/pfd

export pfd

#=======================================
# Helpers
#=======================================

proc getLiteralDialogResult*(dialog: DialogType, res: DialogResult): string =
    case dialog:
        of OKDialog: result = "ok"
        of OKCancelDialog: result = if res == OKResult: "ok" else: "cancel"
        of YesNoDialog: result = if res == YesResult: "yes" else: "no"
        of YesNoCancelDialog:
            if res == YesResult: result = "yes"
            elif res == NoResult: result = "no"
            else: result = "cancel"
        of RetryCancelDialog: result = if res == RetryResult: "retry" else: "cancel"
        of RetryAbortIgnoreDialog:
            if res == CancelResult: result = "retry"
            elif res == AbortResult: result = "abort"
            else: result = "ignore"

proc getBooleanDialogResult*(dialog: DialogType, res: DialogResult): bool =
    case dialog:
        of OKDialog: result = true
        of OKCancelDialog: result = res == OKResult
        of YesNoDialog: result = res == YesResult
        of YesNoCancelDialog: result = res == YesResult
        of RetryCancelDialog: result = res == RetryResult
        of RetryAbortIgnoreDialog: result = res == CancelResult

#=======================================
# Methods
#=======================================

proc showAlertDialog*(title: string, msg: string, icon: DialogIcon = NoIcon) =
    pfd_notification(title.cstring, msg.cstring, icon)

proc showPopupDialog*(title: string, msg: string, dialog: DialogType, icon: DialogIcon = NoIcon): DialogResult =
    pfd_message(title.cstring, msg.cstring, dialog, icon)

proc showSelectionDialog*(title: string, path: string, files = true): string =
    var cresult: cstring
    if files:
        cresult = pfd_select_file(title.cstring, path.cstring)
    else:
        cresult = pfd_select_folder(title.cstring, path.cstring)
    result = $cresult