#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wingdi
import winuser
import objbase
#include <richedit.h>
#include <richole.h>
type
  TEXTMODE* = int32
  UNDONAMEID* = int32
  KHYPH* = int32
  REOBJECT* {.pure.} = object
    cbStruct*: DWORD
    cp*: LONG
    clsid*: CLSID
    poleobj*: LPOLEOBJECT
    pstg*: LPSTORAGE
    polesite*: LPOLECLIENTSITE
    sizel*: SIZEL
    dvaspect*: DWORD
    dwFlags*: DWORD
    dwUser*: DWORD
  CHARRANGE* {.pure.} = object
    cpMin*: LONG
    cpMax*: LONG
  IRichEditOle* {.pure.} = object
    lpVtbl*: ptr IRichEditOleVtbl
  IRichEditOleVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetClientSite*: proc(self: ptr IRichEditOle, lplpolesite: ptr LPOLECLIENTSITE): HRESULT {.stdcall.}
    GetObjectCount*: proc(self: ptr IRichEditOle): LONG {.stdcall.}
    GetLinkCount*: proc(self: ptr IRichEditOle): LONG {.stdcall.}
    GetObject*: proc(self: ptr IRichEditOle, iob: LONG, lpreobject: ptr REOBJECT, dwFlags: DWORD): HRESULT {.stdcall.}
    InsertObject*: proc(self: ptr IRichEditOle, lpreobject: ptr REOBJECT): HRESULT {.stdcall.}
    ConvertObject*: proc(self: ptr IRichEditOle, iob: LONG, rclsidNew: REFCLSID, lpstrUserTypeNew: LPCSTR): HRESULT {.stdcall.}
    ActivateAs*: proc(self: ptr IRichEditOle, rclsid: REFCLSID, rclsidAs: REFCLSID): HRESULT {.stdcall.}
    SetHostNames*: proc(self: ptr IRichEditOle, lpstrContainerApp: LPCSTR, lpstrContainerObj: LPCSTR): HRESULT {.stdcall.}
    SetLinkAvailable*: proc(self: ptr IRichEditOle, iob: LONG, fAvailable: WINBOOL): HRESULT {.stdcall.}
    SetDvaspect*: proc(self: ptr IRichEditOle, iob: LONG, dvaspect: DWORD): HRESULT {.stdcall.}
    HandsOffStorage*: proc(self: ptr IRichEditOle, iob: LONG): HRESULT {.stdcall.}
    SaveCompleted*: proc(self: ptr IRichEditOle, iob: LONG, lpstg: LPSTORAGE): HRESULT {.stdcall.}
    InPlaceDeactivate*: proc(self: ptr IRichEditOle): HRESULT {.stdcall.}
    ContextSensitiveHelp*: proc(self: ptr IRichEditOle, fEnterMode: WINBOOL): HRESULT {.stdcall.}
    GetClipboardData*: proc(self: ptr IRichEditOle, lpchrg: ptr CHARRANGE, reco: DWORD, lplpdataobj: ptr LPDATAOBJECT): HRESULT {.stdcall.}
    ImportDataObject*: proc(self: ptr IRichEditOle, lpdataobj: LPDATAOBJECT, cf: CLIPFORMAT, hMetaPict: HGLOBAL): HRESULT {.stdcall.}
  LPRICHEDITOLE* = ptr IRichEditOle
  IRichEditOleCallback* {.pure.} = object
    lpVtbl*: ptr IRichEditOleCallbackVtbl
  IRichEditOleCallbackVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetNewStorage*: proc(self: ptr IRichEditOleCallback, lplpstg: ptr LPSTORAGE): HRESULT {.stdcall.}
    GetInPlaceContext*: proc(self: ptr IRichEditOleCallback, lplpFrame: ptr LPOLEINPLACEFRAME, lplpDoc: ptr LPOLEINPLACEUIWINDOW, lpFrameInfo: LPOLEINPLACEFRAMEINFO): HRESULT {.stdcall.}
    ShowContainerUI*: proc(self: ptr IRichEditOleCallback, fShow: WINBOOL): HRESULT {.stdcall.}
    QueryInsertObject*: proc(self: ptr IRichEditOleCallback, lpclsid: LPCLSID, lpstg: LPSTORAGE, cp: LONG): HRESULT {.stdcall.}
    DeleteObject*: proc(self: ptr IRichEditOleCallback, lpoleobj: LPOLEOBJECT): HRESULT {.stdcall.}
    QueryAcceptData*: proc(self: ptr IRichEditOleCallback, lpdataobj: LPDATAOBJECT, lpcfFormat: ptr CLIPFORMAT, reco: DWORD, fReally: WINBOOL, hMetaPict: HGLOBAL): HRESULT {.stdcall.}
    ContextSensitiveHelp*: proc(self: ptr IRichEditOleCallback, fEnterMode: WINBOOL): HRESULT {.stdcall.}
    GetClipboardData*: proc(self: ptr IRichEditOleCallback, lpchrg: ptr CHARRANGE, reco: DWORD, lplpdataobj: ptr LPDATAOBJECT): HRESULT {.stdcall.}
    GetDragDropEffect*: proc(self: ptr IRichEditOleCallback, fDrag: WINBOOL, grfKeyState: DWORD, pdwEffect: LPDWORD): HRESULT {.stdcall.}
    GetContextMenu*: proc(self: ptr IRichEditOleCallback, seltype: WORD, lpoleobj: LPOLEOBJECT, lpchrg: ptr CHARRANGE, lphmenu: ptr HMENU): HRESULT {.stdcall.}
  LPRICHEDITOLECALLBACK* = ptr IRichEditOleCallback
const
  RICHEDIT_VER* = 0x0800
  cchTextLimitDefault* = 32767
  MSFTEDIT_CLASS* = "RICHEDIT50W"
  CERICHEDIT_CLASSA* = "RichEditCEA"
  CERICHEDIT_CLASSW* = "RichEditCEW"
  RICHEDIT_CLASSA* = "RichEdit20A"
  RICHEDIT_CLASS10A* = "RICHEDIT"
  RICHEDIT_CLASSW* = "RichEdit20W"
  EM_CANPASTE* = WM_USER+50
  EM_DISPLAYBAND* = WM_USER+51
  EM_EXGETSEL* = WM_USER+52
  EM_EXLIMITTEXT* = WM_USER+53
  EM_EXLINEFROMCHAR* = WM_USER+54
  EM_EXSETSEL* = WM_USER+55
  EM_FINDTEXT* = WM_USER+56
  EM_FORMATRANGE* = WM_USER+57
  EM_GETCHARFORMAT* = WM_USER+58
  EM_GETEVENTMASK* = WM_USER+59
  EM_GETOLEINTERFACE* = WM_USER+60
  EM_GETPARAFORMAT* = WM_USER+61
  EM_GETSELTEXT* = WM_USER+62
  EM_HIDESELECTION* = WM_USER+63
  EM_PASTESPECIAL* = WM_USER+64
  EM_REQUESTRESIZE* = WM_USER+65
  EM_SELECTIONTYPE* = WM_USER+66
  EM_SETBKGNDCOLOR* = WM_USER+67
  EM_SETCHARFORMAT* = WM_USER+68
  EM_SETEVENTMASK* = WM_USER+69
  EM_SETOLECALLBACK* = WM_USER+70
  EM_SETPARAFORMAT* = WM_USER+71
  EM_SETTARGETDEVICE* = WM_USER+72
  EM_STREAMIN* = WM_USER+73
  EM_STREAMOUT* = WM_USER+74
  EM_GETTEXTRANGE* = WM_USER+75
  EM_FINDWORDBREAK* = WM_USER+76
  EM_SETOPTIONS* = WM_USER+77
  EM_GETOPTIONS* = WM_USER+78
  EM_FINDTEXTEX* = WM_USER+79
  EM_GETWORDBREAKPROCEX* = WM_USER+80
  EM_SETWORDBREAKPROCEX* = WM_USER+81
  EM_SETUNDOLIMIT* = WM_USER+82
  EM_REDO* = WM_USER+84
  EM_CANREDO* = WM_USER+85
  EM_GETUNDONAME* = WM_USER+86
  EM_GETREDONAME* = WM_USER+87
  EM_STOPGROUPTYPING* = WM_USER+88
  EM_SETTEXTMODE* = WM_USER+89
  EM_GETTEXTMODE* = WM_USER+90
  TM_PLAINTEXT* = 1
  TM_RICHTEXT* = 2
  TM_SINGLELEVELUNDO* = 4
  TM_MULTILEVELUNDO* = 8
  TM_SINGLECODEPAGE* = 16
  TM_MULTICODEPAGE* = 32
  EM_AUTOURLDETECT* = WM_USER+91
  AURL_ENABLEURL* = 1
  AURL_ENABLEEMAILADDR* = 2
  AURL_ENABLETELNO* = 4
  AURL_ENABLEEAURLS* = 8
  AURL_ENABLEDRIVELETTERS* = 16
  AURL_DISABLEMIXEDLGC* = 32
  EM_GETAUTOURLDETECT* = WM_USER+92
  EM_SETPALETTE* = WM_USER+93
  EM_GETTEXTEX* = WM_USER+94
  EM_GETTEXTLENGTHEX* = WM_USER+95
  EM_SHOWSCROLLBAR* = WM_USER+96
  EM_SETTEXTEX* = WM_USER+97
  EM_SETPUNCTUATION* = WM_USER+100
  EM_GETPUNCTUATION* = WM_USER+101
  EM_SETWORDWRAPMODE* = WM_USER+102
  EM_GETWORDWRAPMODE* = WM_USER+103
  EM_SETIMECOLOR* = WM_USER+104
  EM_GETIMECOLOR* = WM_USER+105
  EM_SETIMEOPTIONS* = WM_USER+106
  EM_GETIMEOPTIONS* = WM_USER+107
  EM_CONVPOSITION* = WM_USER+108
  EM_SETLANGOPTIONS* = WM_USER+120
  EM_GETLANGOPTIONS* = WM_USER+121
  EM_GETIMECOMPMODE* = WM_USER+122
  EM_FINDTEXTW* = WM_USER+123
  EM_FINDTEXTEXW* = WM_USER+124
  EM_RECONVERSION* = WM_USER+125
  EM_SETIMEMODEBIAS* = WM_USER+126
  EM_GETIMEMODEBIAS* = WM_USER+127
  EM_SETBIDIOPTIONS* = WM_USER+200
  EM_GETBIDIOPTIONS* = WM_USER+201
  EM_SETTYPOGRAPHYOPTIONS* = WM_USER+202
  EM_GETTYPOGRAPHYOPTIONS* = WM_USER+203
  EM_SETEDITSTYLE* = WM_USER+204
  EM_GETEDITSTYLE* = WM_USER+205
  SES_EMULATESYSEDIT* = 1
  SES_BEEPONMAXTEXT* = 2
  SES_EXTENDBACKCOLOR* = 4
  SES_MAPCPS* = 8
  SES_HYPERLINKTOOLTIPS* = 8
  SES_EMULATE10* = 16
  SES_DEFAULTLATINLIGA* = 16
  SES_USECRLF* = 32
  SES_USEAIMM* = 64
  SES_NOIME* = 128
  SES_ALLOWBEEPS* = 256
  SES_UPPERCASE* = 512
  SES_LOWERCASE* = 1024
  SES_NOINPUTSEQUENCECHK* = 2048
  SES_BIDI* = 4096
  SES_SCROLLONKILLFOCUS* = 8192
  SES_XLTCRCRLFTOCR* = 16384
  SES_DRAFTMODE* = 32768
  SES_USECTF* = 0x00010000
  SES_HIDEGRIDLINES* = 0x00020000
  SES_USEATFONT* = 0x00040000
  SES_CUSTOMLOOK* = 0x00080000
  SES_LBSCROLLNOTIFY* = 0x00100000
  SES_CTFALLOWEMBED* = 0x00200000
  SES_CTFALLOWSMARTTAG* = 0x00400000
  SES_CTFALLOWPROOFING* = 0x00800000
  SES_LOGICALCARET* = 0x01000000
  SES_WORDDRAGDROP* = 0x02000000
  SES_SMARTDRAGDROP* = 0x04000000
  SES_MULTISELECT* = 0x08000000
  SES_CTFNOLOCK* = 0x10000000
  SES_NOEALINEHEIGHTADJUST* = 0x20000000
  SES_MAX* = 0x20000000
  IMF_AUTOKEYBOARD* = 0x0001
  IMF_AUTOFONT* = 0x0002
  IMF_IMECANCELCOMPLETE* = 0x0004
  IMF_IMEALWAYSSENDNOTIFY* = 0x0008
  IMF_AUTOFONTSIZEADJUST* = 0x0010
  IMF_UIFONTS* = 0x0020
  IMF_NOIMPLICITLANG* = 0x0040
  IMF_DUALFONT* = 0x0080
  IMF_NOKBDLIDFIXUP* = 0x0200
  IMF_NORTFFONTSUBSTITUTE* = 0x0400
  IMF_SPELLCHECKING* = 0x0800
  IMF_TKBPREDICTION* = 0x1000
  ICM_NOTOPEN* = 0x0000
  ICM_LEVEL3* = 0x0001
  ICM_LEVEL2* = 0x0002
  ICM_LEVEL2_5* = 0x0003
  ICM_LEVEL2_SUI* = 0x0004
  ICM_CTF* = 0x0005
  TO_ADVANCEDTYPOGRAPHY* = 0x0001
  TO_SIMPLELINEBREAK* = 0x0002
  TO_DISABLECUSTOMTEXTOUT* = 0x0004
  TO_ADVANCEDLAYOUT* = 0x0008
  EM_OUTLINE* = WM_USER+220
  EM_GETSCROLLPOS* = WM_USER+221
  EM_SETSCROLLPOS* = WM_USER+222
  EM_SETFONTSIZE* = WM_USER+223
  EM_GETZOOM* = WM_USER+224
  EM_SETZOOM* = WM_USER+225
  EM_GETVIEWKIND* = WM_USER+226
  EM_SETVIEWKIND* = WM_USER+227
  EM_GETPAGE* = WM_USER+228
  EM_SETPAGE* = WM_USER+229
  EM_GETHYPHENATEINFO* = WM_USER+230
  EM_SETHYPHENATEINFO* = WM_USER+231
  EM_GETPAGEROTATE* = WM_USER+235
  EM_SETPAGEROTATE* = WM_USER+236
  EM_GETCTFMODEBIAS* = WM_USER+237
  EM_SETCTFMODEBIAS* = WM_USER+238
  EM_GETCTFOPENSTATUS* = WM_USER+240
  EM_SETCTFOPENSTATUS* = WM_USER+241
  EM_GETIMECOMPTEXT* = WM_USER+242
  EM_ISIME* = WM_USER+243
  EM_GETIMEPROPERTY* = WM_USER+244
  EM_GETQUERYRTFOBJ* = WM_USER+269
  EM_SETQUERYRTFOBJ* = WM_USER+270
  EPR_0* = 0
  EPR_270* = 1
  EPR_180* = 2
  EPR_90* = 3
  EPR_SE* = 5
  CTFMODEBIAS_DEFAULT* = 0x0000
  CTFMODEBIAS_FILENAME* = 0x0001
  CTFMODEBIAS_NAME* = 0x0002
  CTFMODEBIAS_READING* = 0x0003
  CTFMODEBIAS_DATETIME* = 0x0004
  CTFMODEBIAS_CONVERSATION* = 0x0005
  CTFMODEBIAS_NUMERIC* = 0x0006
  CTFMODEBIAS_HIRAGANA* = 0x0007
  CTFMODEBIAS_KATAKANA* = 0x0008
  CTFMODEBIAS_HANGUL* = 0x0009
  CTFMODEBIAS_HALFWIDTHKATAKANA* = 0x000a
  CTFMODEBIAS_FULLWIDTHALPHANUMERIC* = 0x000b
  CTFMODEBIAS_HALFWIDTHALPHANUMERIC* = 0x000c
  IMF_SMODE_PLAURALCLAUSE* = 0x0001
  IMF_SMODE_NONE* = 0x0002
  ICT_RESULTREADSTR* = 1
  EMO_EXIT* = 0
  EMO_ENTER* = 1
  EMO_PROMOTE* = 2
  EMO_EXPAND* = 3
  EMO_MOVESELECTION* = 4
  EMO_GETVIEWMODE* = 5
  EMO_EXPANDSELECTION* = 0
  EMO_EXPANDDOCUMENT* = 1
  VM_NORMAL* = 4
  VM_OUTLINE* = 2
  VM_PAGE* = 9
  EM_INSERTTABLE* = WM_USER+232
  EM_GETAUTOCORRECTPROC* = WM_USER+233
  EM_SETAUTOCORRECTPROC* = WM_USER+234
  EM_CALLAUTOCORRECTPROC* = WM_USER+255
  ATP_NOCHANGE* = 0
  ATP_CHANGE* = 1
  ATP_NODELIMITER* = 2
  ATP_REPLACEALLTEXT* = 4
  EM_GETTABLEPARMS* = WM_USER+265
  EM_SETEDITSTYLEEX* = WM_USER+275
  EM_GETEDITSTYLEEX* = WM_USER+276
  SES_EX_NOTABLE* = 0x00000004
  SES_EX_HANDLEFRIENDLYURL* = 0x00000100
  SES_EX_NOTHEMING* = 0x00080000
  SES_EX_NOACETATESELECTION* = 0x00100000
  SES_EX_USESINGLELINE* = 0x00200000
  SES_EX_MULTITOUCH* = 0x08000000
  SES_EX_HIDETEMPFORMAT* = 0x10000000
  SES_EX_USEMOUSEWPARAM* = 0x20000000
  EM_GETSTORYTYPE* = WM_USER+290
  EM_SETSTORYTYPE* = WM_USER+291
  EM_GETELLIPSISMODE* = WM_USER+305
  EM_SETELLIPSISMODE* = WM_USER+306
  ELLIPSIS_MASK* = 0x00000003
  ELLIPSIS_NONE* = 0x00000000
  ELLIPSIS_END* = 0x00000001
  ELLIPSIS_WORD* = 0x00000003
  EM_SETTABLEPARMS* = WM_USER+307
  EM_GETTOUCHOPTIONS* = WM_USER+310
  EM_SETTOUCHOPTIONS* = WM_USER+311
  EM_INSERTIMAGE* = WM_USER+314
  EM_SETUIANAME* = WM_USER+320
  EM_GETELLIPSISSTATE* = WM_USER+322
  RTO_SHOWHANDLES* = 1
  RTO_DISABLEHANDLES* = 2
  RTO_READINGMODE* = 3
  EN_MSGFILTER* = 0x0700
  EN_REQUESTRESIZE* = 0x0701
  EN_SELCHANGE* = 0x0702
  EN_DROPFILES* = 0x0703
  EN_PROTECTED* = 0x0704
  EN_CORRECTTEXT* = 0x0705
  EN_STOPNOUNDO* = 0x0706
  EN_IMECHANGE* = 0x0707
  EN_SAVECLIPBOARD* = 0x0708
  EN_OLEOPFAILED* = 0x0709
  EN_OBJECTPOSITIONS* = 0x070a
  EN_LINK* = 0x070b
  EN_DRAGDROPDONE* = 0x070c
  EN_PARAGRAPHEXPANDED* = 0x070d
  EN_PAGECHANGE* = 0x070e
  EN_LOWFIRTF* = 0x070f
  EN_ALIGNLTR* = 0x0710
  EN_ALIGNRTL* = 0x0711
  EN_CLIPFORMAT* = 0x0712
  EN_STARTCOMPOSITION* = 0x0713
  EN_ENDCOMPOSITION* = 0x0714
  ECN_ENDCOMPOSITION* = 0x0001
  ECN_NEWTEXT* = 0x0002
  ENM_NONE* = 0x00000000
  ENM_CHANGE* = 0x00000001
  ENM_UPDATE* = 0x00000002
  ENM_SCROLL* = 0x00000004
  ENM_SCROLLEVENTS* = 0x00000008
  ENM_DRAGDROPDONE* = 0x00000010
  ENM_PARAGRAPHEXPANDED* = 0x00000020
  ENM_PAGECHANGE* = 0x00000040
  ENM_CLIPFORMAT* = 0x00000080
  ENM_KEYEVENTS* = 0x00010000
  ENM_MOUSEEVENTS* = 0x00020000
  ENM_REQUESTRESIZE* = 0x00040000
  ENM_SELCHANGE* = 0x00080000
  ENM_DROPFILES* = 0x00100000
  ENM_PROTECTED* = 0x00200000
  ENM_CORRECTTEXT* = 0x00400000
  ENM_IMECHANGE* = 0x00800000
  ENM_LANGCHANGE* = 0x01000000
  ENM_OBJECTPOSITIONS* = 0x02000000
  ENM_LINK* = 0x04000000
  ENM_LOWFIRTF* = 0x08000000
  ENM_STARTCOMPOSITION* = 0x10000000
  ENM_ENDCOMPOSITION* = 0x20000000
  ENM_GROUPTYPINGCHANGE* = 0x40000000
  ENM_HIDELINKTOOLTIP* = 0x80000000'i32
  ES_SAVESEL* = 0x00008000
  ES_SUNKEN* = 0x00004000
  ES_DISABLENOSCROLL* = 0x00002000
  ES_SELECTIONBAR* = 0x01000000
  ES_NOOLEDRAGDROP* = 0x00000008
  ES_EX_NOCALLOLEINIT* = 0x00000000
  ES_VERTICAL* = 0x00400000
  ES_NOIME* = 0x00080000
  ES_SELFIME* = 0x00040000
  ECO_AUTOWORDSELECTION* = 0x00000001
  ECO_AUTOVSCROLL* = 0x00000040
  ECO_AUTOHSCROLL* = 0x00000080
  ECO_NOHIDESEL* = 0x00000100
  ECO_READONLY* = 0x00000800
  ECO_WANTRETURN* = 0x00001000
  ECO_SAVESEL* = 0x00008000
  ECO_SELECTIONBAR* = 0x01000000
  ECO_VERTICAL* = 0x00400000
  ECOOP_SET* = 0x0001
  ECOOP_OR* = 0x0002
  ECOOP_AND* = 0x0003
  ECOOP_XOR* = 0x0004
  WB_CLASSIFY* = 3
  WB_MOVEWORDLEFT* = 4
  WB_MOVEWORDRIGHT* = 5
  WB_LEFTBREAK* = 6
  WB_RIGHTBREAK* = 7
  WB_MOVEWORDPREV* = 4
  WB_MOVEWORDNEXT* = 5
  WB_PREVBREAK* = 6
  WB_NEXTBREAK* = 7
  PC_FOLLOWING* = 1
  PC_LEADING* = 2
  PC_OVERFLOW* = 3
  PC_DELIMITER* = 4
  WBF_WORDWRAP* = 0x010
  WBF_WORDBREAK* = 0x020
  WBF_OVERFLOW* = 0x040
  WBF_LEVEL1* = 0x080
  WBF_LEVEL2* = 0x100
  WBF_CUSTOM* = 0x200
  IMF_FORCENONE* = 0x0001
  IMF_FORCEENABLE* = 0x0002
  IMF_FORCEDISABLE* = 0x0004
  IMF_CLOSESTATUSWINDOW* = 0x0008
  IMF_VERTICAL* = 0x0020
  IMF_FORCEACTIVE* = 0x0040
  IMF_FORCEINACTIVE* = 0x0080
  IMF_FORCEREMEMBER* = 0x0100
  IMF_MULTIPLEEDIT* = 0x0400
  WBF_CLASS* = BYTE 0x0f
  WBF_ISWHITE* = BYTE 0x10
  WBF_BREAKLINE* = BYTE 0x20
  WBF_BREAKAFTER* = BYTE 0x40
  CFM_BOLD* = 0x00000001
  CFM_ITALIC* = 0x00000002
  CFM_UNDERLINE* = 0x00000004
  CFM_STRIKEOUT* = 0x00000008
  CFM_PROTECTED* = 0x00000010
  CFM_LINK* = 0x00000020
  CFM_SIZE* = 0x80000000'i32
  CFM_COLOR* = 0x40000000
  CFM_FACE* = 0x20000000
  CFM_OFFSET* = 0x10000000
  CFM_CHARSET* = 0x08000000
  CFE_BOLD* = 0x00000001
  CFE_ITALIC* = 0x00000002
  CFE_UNDERLINE* = 0x00000004
  CFE_STRIKEOUT* = 0x00000008
  CFE_PROTECTED* = 0x00000010
  CFE_LINK* = 0x00000020
  CFE_AUTOCOLOR* = 0x40000000
  CFM_SMALLCAPS* = 0x00000040
  CFM_ALLCAPS* = 0x00000080
  CFM_HIDDEN* = 0x00000100
  CFM_OUTLINE* = 0x00000200
  CFM_SHADOW* = 0x00000400
  CFM_EMBOSS* = 0x00000800
  CFM_IMPRINT* = 0x00001000
  CFM_DISABLED* = 0x00002000
  CFM_REVISED* = 0x00004000
  CFM_REVAUTHOR* = 0x00008000
  CFE_SUBSCRIPT* = 0x00010000
  CFE_SUPERSCRIPT* = 0x00020000
  CFM_ANIMATION* = 0x00040000
  CFM_STYLE* = 0x00080000
  CFM_KERNING* = 0x00100000
  CFM_SPACING* = 0x00200000
  CFM_WEIGHT* = 0x00400000
  CFM_UNDERLINETYPE* = 0x00800000
  CFM_COOKIE* = 0x01000000
  CFM_LCID* = 0x02000000
  CFM_BACKCOLOR* = 0x04000000
  CFM_SUBSCRIPT* = CFE_SUBSCRIPT or CFE_SUPERSCRIPT
  CFM_SUPERSCRIPT* = CFM_SUBSCRIPT
  CFM_EFFECTS* = CFM_BOLD or CFM_ITALIC or CFM_UNDERLINE or CFM_COLOR or CFM_STRIKEOUT or CFE_PROTECTED or CFM_LINK
  CFM_ALL* = CFM_EFFECTS or CFM_SIZE or CFM_FACE or CFM_OFFSET or CFM_CHARSET
  CFM_EFFECTS2* = CFM_EFFECTS or CFM_DISABLED or CFM_SMALLCAPS or CFM_ALLCAPS or CFM_HIDDEN or CFM_OUTLINE or CFM_SHADOW or CFM_EMBOSS or CFM_IMPRINT or CFM_REVISED or CFM_SUBSCRIPT or CFM_SUPERSCRIPT or CFM_BACKCOLOR
  CFM_ALL2* = CFM_ALL or CFM_EFFECTS2 or CFM_BACKCOLOR or CFM_LCID or CFM_UNDERLINETYPE or CFM_WEIGHT or CFM_REVAUTHOR or CFM_SPACING or CFM_KERNING or CFM_STYLE or CFM_ANIMATION or CFM_COOKIE
  CFE_SMALLCAPS* = CFM_SMALLCAPS
  CFE_ALLCAPS* = CFM_ALLCAPS
  CFE_HIDDEN* = CFM_HIDDEN
  CFE_OUTLINE* = CFM_OUTLINE
  CFE_SHADOW* = CFM_SHADOW
  CFE_EMBOSS* = CFM_EMBOSS
  CFE_IMPRINT* = CFM_IMPRINT
  CFE_DISABLED* = CFM_DISABLED
  CFE_REVISED* = CFM_REVISED
  CFE_AUTOBACKCOLOR* = CFM_BACKCOLOR
  CFM_FONTBOUND* = 0x00100000
  CFM_LINKPROTECTED* = 0x00800000
  CFM_EXTENDED* = 0x02000000
  CFM_MATHNOBUILDUP* = 0x08000000
  CFM_MATH* = 0x10000000
  CFM_MATHORDINARY* = 0x20000000
  CFM_ALLEFFECTS* = CFM_EFFECTS2 or CFM_FONTBOUND or CFM_EXTENDED or CFM_MATHNOBUILDUP or CFM_MATH or CFM_MATHORDINARY
  CFE_FONTBOUND* = 0x00100000
  CFE_LINKPROTECTED* = 0x00800000
  CFE_EXTENDED* = 0x02000000
  CFE_MATHNOBUILDUP* = 0x08000000
  CFE_MATH* = 0x10000000
  CFE_MATHORDINARY* = 0x20000000
  CFU_CF1UNDERLINE* = 0xff
  CFU_INVERT* = 0xfe
  CFU_UNDERLINETHICKLONGDASH* = 18
  CFU_UNDERLINETHICKDOTTED* = 17
  CFU_UNDERLINETHICKDASHDOTDOT* = 16
  CFU_UNDERLINETHICKDASHDOT* = 15
  CFU_UNDERLINETHICKDASH* = 14
  CFU_UNDERLINELONGDASH* = 13
  CFU_UNDERLINEHEAVYWAVE* = 12
  CFU_UNDERLINEDOUBLEWAVE* = 11
  CFU_UNDERLINEHAIRLINE* = 10
  CFU_UNDERLINETHICK* = 9
  CFU_UNDERLINEWAVE* = 8
  CFU_UNDERLINEDASHDOTDOT* = 7
  CFU_UNDERLINEDASHDOT* = 6
  CFU_UNDERLINEDASH* = 5
  CFU_UNDERLINEDOTTED* = 4
  CFU_UNDERLINEDOUBLE* = 3
  CFU_UNDERLINEWORD* = 2
  CFU_UNDERLINE* = 1
  CFU_UNDERLINENONE* = 0
  yHeightCharPtsMost* = 1638
  SCF_SELECTION* = 0x0001
  SCF_WORD* = 0x0002
  SCF_DEFAULT* = 0x0000
  SCF_ALL* = 0x0004
  SCF_USEUIRULES* = 0x0008
  SCF_ASSOCIATEFONT* = 0x0010
  SCF_NOKBUPDATE* = 0x0020
  SCF_ASSOCIATEFONT2* = 0x0040
  SCF_SMARTFONT* = 0x0080
  SCF_CHARREPFROMLCID* = 0x0100
  SPF_DONTSETDEFAULT* = 0x0002
  SPF_SETDEFAULT* = 0x0004
  SF_TEXT* = 0x0001
  SF_RTF* = 0x0002
  SF_RTFNOOBJS* = 0x0003
  SF_TEXTIZED* = 0x0004
  SF_UNICODE* = 0x0010
  SF_USECODEPAGE* = 0x0020
  SF_NCRFORNONASCII* = 0x40
  SFF_WRITEXTRAPAR* = 0x80
  SFF_SELECTION* = 0x8000
  SFF_PLAINRTF* = 0x4000
  SFF_PERSISTVIEWSCALE* = 0x2000
  SFF_KEEPDOCINFO* = 0x1000
  SFF_PWD* = 0x0800
  SF_RTFVAL* = 0x0700
  MAX_TAB_STOPS* = 32
  lDefaultTab* = 720
  MAX_TABLE_CELLS* = 63
  PFM_STARTINDENT* = 0x00000001
  PFM_RIGHTINDENT* = 0x00000002
  PFM_OFFSET* = 0x00000004
  PFM_ALIGNMENT* = 0x00000008
  PFM_TABSTOPS* = 0x00000010
  PFM_NUMBERING* = 0x00000020
  PFM_OFFSETINDENT* = 0x80000000'i32
  PFM_SPACEBEFORE* = 0x00000040
  PFM_SPACEAFTER* = 0x00000080
  PFM_LINESPACING* = 0x00000100
  PFM_STYLE* = 0x00000400
  PFM_BORDER* = 0x00000800
  PFM_SHADING* = 0x00001000
  PFM_NUMBERINGSTYLE* = 0x00002000
  PFM_NUMBERINGTAB* = 0x00004000
  PFM_NUMBERINGSTART* = 0x00008000
  PFM_RTLPARA* = 0x00010000
  PFM_KEEP* = 0x00020000
  PFM_KEEPNEXT* = 0x00040000
  PFM_PAGEBREAKBEFORE* = 0x00080000
  PFM_NOLINENUMBER* = 0x00100000
  PFM_NOWIDOWCONTROL* = 0x00200000
  PFM_DONOTHYPHEN* = 0x00400000
  PFM_SIDEBYSIDE* = 0x00800000
  PFM_COLLAPSED* = 0x01000000
  PFM_OUTLINELEVEL* = 0x02000000
  PFM_BOX* = 0x04000000
  PFM_RESERVED2* = 0x08000000
  PFM_TABLEROWDELIMITER* = 0x10000000
  PFM_TEXTWRAPPINGBREAK* = 0x20000000
  PFM_TABLE* = 0x40000000
  PFM_ALL* = PFM_STARTINDENT or PFM_RIGHTINDENT or PFM_OFFSET or PFM_ALIGNMENT or PFM_TABSTOPS or PFM_NUMBERING or PFM_OFFSETINDENT or PFM_RTLPARA
  PFM_EFFECTS* = PFM_RTLPARA or PFM_KEEP or PFM_KEEPNEXT or PFM_TABLE or PFM_PAGEBREAKBEFORE or PFM_NOLINENUMBER or PFM_NOWIDOWCONTROL or PFM_DONOTHYPHEN or PFM_SIDEBYSIDE or PFM_TABLE or PFM_TABLEROWDELIMITER
  PFM_ALL2* = PFM_ALL or PFM_EFFECTS or PFM_SPACEBEFORE or PFM_SPACEAFTER or PFM_LINESPACING or PFM_STYLE or PFM_SHADING or PFM_BORDER or PFM_NUMBERINGTAB or PFM_NUMBERINGSTART or PFM_NUMBERINGSTYLE
  PFE_RTLPARA* = PFM_RTLPARA shr 16
  PFE_KEEP* = PFM_KEEP shr 16
  PFE_KEEPNEXT* = PFM_KEEPNEXT shr 16
  PFE_PAGEBREAKBEFORE* = PFM_PAGEBREAKBEFORE shr 16
  PFE_NOLINENUMBER* = PFM_NOLINENUMBER shr 16
  PFE_NOWIDOWCONTROL* = PFM_NOWIDOWCONTROL shr 16
  PFE_DONOTHYPHEN* = PFM_DONOTHYPHEN shr 16
  PFE_SIDEBYSIDE* = PFM_SIDEBYSIDE shr 16
  PFE_TEXTWRAPPINGBREAK* = PFM_TEXTWRAPPINGBREAK shr 16
  PFE_COLLAPSED* = PFM_COLLAPSED shr 16
  PFE_BOX* = PFM_BOX shr 16
  PFE_TABLE* = PFM_TABLE shr 16
  PFE_TABLEROWDELIMITER* = PFM_TABLEROWDELIMITER shr 16
  PFN_BULLET* = 1
  PFN_ARABIC* = 2
  PFN_LCLETTER* = 3
  PFN_UCLETTER* = 4
  PFN_LCROMAN* = 5
  PFN_UCROMAN* = 6
  PFNS_PAREN* = 0x000
  PFNS_PARENS* = 0x100
  PFNS_PERIOD* = 0x200
  PFNS_PLAIN* = 0x300
  PFNS_NONUMBER* = 0x400
  PFNS_NEWNUMBER* = 0x8000
  PFA_LEFT* = 1
  PFA_RIGHT* = 2
  PFA_CENTER* = 3
  PFA_JUSTIFY* = 4
  PFA_FULL_INTERWORD* = 4
  SEL_EMPTY* = 0x0000
  SEL_TEXT* = 0x0001
  SEL_OBJECT* = 0x0002
  SEL_MULTICHAR* = 0x0004
  SEL_MULTIOBJECT* = 0x0008
  GCM_RIGHTMOUSEDROP* = 0x8000
  GCMF_GRIPPER* = 0x00000001
  GCMF_SPELLING* = 0x00000002
  GCMF_TOUCHMENU* = 0x00004000
  GCMF_MOUSEMENU* = 0x00002000
  OLEOP_DOVERB* = 1
  CF_RTF* = "Rich Text Format"
  CF_RTFNOOBJS* = "Rich Text Format Without Objects"
  CF_RETEXTOBJ* = "RichEdit Text and Objects"
  UID_UNKNOWN* = 0
  UID_TYPING* = 1
  UID_DELETE* = 2
  UID_DRAGDROP* = 3
  UID_CUT* = 4
  UID_PASTE* = 5
  UID_AUTOTABLE* = 6
  ST_DEFAULT* = 0
  ST_KEEPUNDO* = 1
  ST_SELECTION* = 2
  ST_NEWCHARS* = 4
  ST_UNICODE* = 8
  GT_DEFAULT* = 0
  GT_USECRLF* = 1
  GT_SELECTION* = 2
  GT_RAWTEXT* = 4
  GT_NOHIDDENTEXT* = 8
  GTL_DEFAULT* = 0
  GTL_USECRLF* = 1
  GTL_PRECISE* = 2
  GTL_CLOSE* = 4
  GTL_NUMCHARS* = 8
  GTL_NUMBYTES* = 16
  BOM_DEFPARADIR* = 0x0001
  BOM_PLAINTEXT* = 0x0002
  BOM_NEUTRALOVERRIDE* = 0x0004
  BOM_CONTEXTREADING* = 0x0008
  BOM_CONTEXTALIGNMENT* = 0x0010
  BOM_LEGACYBIDICLASS* = 0x0040
  BOM_UNICODEBIDI* = 0x0080
  BOE_RTLDIR* = 0x0001
  BOE_PLAINTEXT* = 0x0002
  BOE_NEUTRALOVERRIDE* = 0x0004
  BOE_CONTEXTREADING* = 0x0008
  BOE_CONTEXTALIGNMENT* = 0x0010
  BOE_FORCERECALC* = 0x0020
  BOE_LEGACYBIDICLASS* = 0x0040
  BOE_UNICODEBIDI* = 0x0080
  WCH_EMBEDDING* = WCHAR 0xfffc
  khyphNil* = 0
  khyphNormal* = 1
  khyphAddBefore* = 2
  khyphChangeBefore* = 3
  khyphDeleteBefore* = 4
  khyphChangeAfter* = 5
  khyphDelAndChange* = 6
  RICHEDIT60_CLASS* = "RICHEDIT60W"
  PFA_FULL_NEWSPAPER* = 5
  PFA_FULL_INTERLETTER* = 6
  PFA_FULL_SCALED* = 7
  PFA_FULL_GLYPHS* = 8
  AURL_ENABLEEA* = 1
  GCM_TOUCHMENU* = 0x4000
  GCM_MOUSEMENU* = 0x2000
  REO_GETOBJ_NO_INTERFACES* = 0x00000000
  REO_GETOBJ_POLEOBJ* = 0x00000001
  REO_GETOBJ_PSTG* = 0x00000002
  REO_GETOBJ_POLESITE* = 0x00000004
  REO_GETOBJ_ALL_INTERFACES* = 0x00000007
  REO_CP_SELECTION* = ULONG(-1)
  REO_IOB_SELECTION* = ULONG(-1)
  REO_IOB_USE_CP* = ULONG(-2)
  REO_NULL* = 0x00000000
  REO_READWRITEMASK* = 0x000007ff
  REO_CANROTATE* = 0x00000080
  REO_OWNERDRAWSELECT* = 0x00000040
  REO_DONTNEEDPALETTE* = 0x00000020
  REO_BLANK* = 0x00000010
  REO_DYNAMICSIZE* = 0x00000008
  REO_INVERTEDSELECT* = 0x00000004
  REO_BELOWBASELINE* = 0x00000002
  REO_RESIZABLE* = 0x00000001
  REO_USEASBACKGROUND* = 0x00000400
  REO_WRAPTEXTAROUND* = 0x00000200
  REO_ALIGNTORIGHT* = 0x00000100
  REO_LINK* = 0x80000000'i32
  REO_STATIC* = 0x40000000
  REO_SELECTED* = 0x08000000
  REO_OPEN* = 0x04000000
  REO_INPLACEACTIVE* = 0x02000000
  REO_HILITED* = 0x01000000
  REO_LINKAVAILABLE* = 0x00800000
  REO_GETMETAFILE* = 0x00400000
  RECO_PASTE* = 0x00000000
  RECO_DROP* = 0x00000001
  RECO_COPY* = 0x00000002
  RECO_CUT* = 0x00000003
  RECO_DRAG* = 0x00000004
  IID_IRichEditOle* = DEFINE_GUID("00020d00-0000-0000-c000-000000000046")
  IID_IRichEditOleCallback* = DEFINE_GUID("00020d03-0000-0000-c000-000000000046")
type
  AutoCorrectProc* = proc (langid: LANGID, pszBefore: ptr WCHAR, pszAfter: ptr WCHAR, cchAfter: LONG, pcchReplaced: ptr LONG): int32 {.stdcall.}
  EDITWORDBREAKPROCEX* = proc (pchText: ptr char, cchText: LONG, bCharSet: BYTE, action: INT): LONG {.stdcall.}
  EDITSTREAMCALLBACK* = proc (dwCookie: DWORD_PTR, pbBuff: LPBYTE, cb: LONG, pcb: ptr LONG): DWORD {.stdcall.}
  IMECOMPTEXT* {.pure.} = object
    cb*: LONG
    flags*: DWORD
  TABLEROWPARMS* {.pure.} = object
    cbRow*: BYTE
    cbCell*: BYTE
    cCell*: BYTE
    cRow*: BYTE
    dxCellMargin*: LONG
    dxIndent*: LONG
    dyHeight*: LONG
    nAlignment* {.bitsize:3.}: DWORD
    fRTL* {.bitsize:1.}: DWORD
    fKeep* {.bitsize:1.}: DWORD
    fKeepFollow* {.bitsize:1.}: DWORD
    fWrap* {.bitsize:1.}: DWORD
    fIdentCells* {.bitsize:1.}: DWORD
    cpStartRow*: LONG
    bTableLevel*: BYTE
    iCell*: BYTE
  TABLECELLPARMS* {.pure.} = object
    dxWidth*: LONG
    nVertAlign* {.bitsize:2.}: WORD
    fMergeTop* {.bitsize:1.}: WORD
    fMergePrev* {.bitsize:1.}: WORD
    fVertical* {.bitsize:1.}: WORD
    fMergeStart* {.bitsize:1.}: WORD
    fMergeCont* {.bitsize:1.}: WORD
    wShading*: WORD
    dxBrdrLeft*: SHORT
    dyBrdrTop*: SHORT
    dxBrdrRight*: SHORT
    dyBrdrBottom*: SHORT
    crBrdrLeft*: COLORREF
    crBrdrTop*: COLORREF
    crBrdrRight*: COLORREF
    crBrdrBottom*: COLORREF
    crBackPat*: COLORREF
    crForePat*: COLORREF
  RICHEDIT_IMAGE_PARAMETERS* {.pure.} = object
    xWidth*: LONG
    yHeight*: LONG
    Ascent*: LONG
    Type*: LONG
    pwszAlternateText*: LPCWSTR
    pIStream*: ptr IStream
  ENDCOMPOSITIONNOTIFY* {.pure, packed.} = object
    nmhdr*: NMHDR
    dwCode*: DWORD
  CHARFORMATA* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    dwEffects*: DWORD
    yHeight*: LONG
    yOffset*: LONG
    crTextColor*: COLORREF
    bCharSet*: BYTE
    bPitchAndFamily*: BYTE
    szFaceName*: array[LF_FACESIZE, char]
  CHARFORMATW* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    dwEffects*: DWORD
    yHeight*: LONG
    yOffset*: LONG
    crTextColor*: COLORREF
    bCharSet*: BYTE
    bPitchAndFamily*: BYTE
    szFaceName*: array[LF_FACESIZE, WCHAR]
  CHARFORMAT2W_UNION1* {.pure, union.} = object
    dwReserved*: DWORD
    dwCookie*: DWORD
  CHARFORMAT2W* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    dwEffects*: DWORD
    yHeight*: LONG
    yOffset*: LONG
    crTextColor*: COLORREF
    bCharSet*: BYTE
    bPitchAndFamily*: BYTE
    szFaceName*: array[LF_FACESIZE, WCHAR]
    wWeight*: WORD
    sSpacing*: SHORT
    crBackColor*: COLORREF
    lcid*: LCID
    union1*: CHARFORMAT2W_UNION1
    sStyle*: SHORT
    wKerning*: WORD
    bUnderlineType*: BYTE
    bAnimation*: BYTE
    bRevAuthor*: BYTE
    bUnderlineColor*: BYTE
  CHARFORMAT2A_UNION1* {.pure, union.} = object
    dwReserved*: DWORD
    dwCookie*: DWORD
  CHARFORMAT2A* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    dwEffects*: DWORD
    yHeight*: LONG
    yOffset*: LONG
    crTextColor*: COLORREF
    bCharSet*: BYTE
    bPitchAndFamily*: BYTE
    szFaceName*: array[LF_FACESIZE, char]
    wWeight*: WORD
    sSpacing*: SHORT
    crBackColor*: COLORREF
    lcid*: LCID
    union1*: CHARFORMAT2A_UNION1
    sStyle*: SHORT
    wKerning*: WORD
    bUnderlineType*: BYTE
    bAnimation*: BYTE
    bRevAuthor*: BYTE
    bUnderlineColor*: BYTE
  TEXTRANGEA* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPSTR
  TEXTRANGEW* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPWSTR
  EDITSTREAM* {.pure, packed.} = object
    dwCookie*: DWORD_PTR
    dwError*: DWORD
    pfnCallback*: EDITSTREAMCALLBACK
  TFINDTEXTA* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPCSTR
  TFINDTEXTW* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPCWSTR
  FINDTEXTEXA* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPCSTR
    chrgText*: CHARRANGE
  FINDTEXTEXW* {.pure.} = object
    chrg*: CHARRANGE
    lpstrText*: LPCWSTR
    chrgText*: CHARRANGE
  FORMATRANGE* {.pure.} = object
    hdc*: HDC
    hdcTarget*: HDC
    rc*: RECT
    rcPage*: RECT
    chrg*: CHARRANGE
  PARAFORMAT_UNION1* {.pure, union.} = object
    wReserved*: WORD
    wEffects*: WORD
  PARAFORMAT* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    wNumbering*: WORD
    union1*: PARAFORMAT_UNION1
    dxStartIndent*: LONG
    dxRightIndent*: LONG
    dxOffset*: LONG
    wAlignment*: WORD
    cTabCount*: SHORT
    rgxTabs*: array[MAX_TAB_STOPS, LONG]
  PARAFORMAT2_UNION1* {.pure, union.} = object
    wReserved*: WORD
    wEffects*: WORD
  PARAFORMAT2* {.pure.} = object
    cbSize*: UINT
    dwMask*: DWORD
    wNumbering*: WORD
    union1*: PARAFORMAT2_UNION1
    dxStartIndent*: LONG
    dxRightIndent*: LONG
    dxOffset*: LONG
    wAlignment*: WORD
    cTabCount*: SHORT
    rgxTabs*: array[MAX_TAB_STOPS, LONG]
    dySpaceBefore*: LONG
    dySpaceAfter*: LONG
    dyLineSpacing*: LONG
    sStyle*: SHORT
    bLineSpacingRule*: BYTE
    bOutlineLevel*: BYTE
    wShadingWeight*: WORD
    wShadingStyle*: WORD
    wNumberingStart*: WORD
    wNumberingStyle*: WORD
    wNumberingTab*: WORD
    wBorderSpace*: WORD
    wBorderWidth*: WORD
    wBorders*: WORD
  MSGFILTER* {.pure, packed.} = object
    nmhdr*: NMHDR
    msg*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
  REQRESIZE* {.pure.} = object
    nmhdr*: NMHDR
    rc*: RECT
  SELCHANGE* {.pure, packed.} = object
    nmhdr*: NMHDR
    chrg*: CHARRANGE
    seltyp*: WORD
    padding*: array[2, byte]
  GROUPTYPINGCHANGE* {.pure, packed.} = object
    nmhdr*: NMHDR
    fGroupTyping*: WINBOOL
  CLIPBOARDFORMAT* {.pure, packed.} = object
    nmhdr*: NMHDR
    cf*: CLIPFORMAT
    padding*: array[2, byte]
  GETCONTEXTMENUEX* {.pure, packed.} = object
    chrg*: CHARRANGE
    dwFlags*: DWORD
    pt*: POINT
    pvReserved*: pointer
  TENDROPFILES* {.pure.} = object
    nmhdr*: NMHDR
    hDrop*: HANDLE
    cp*: LONG
    fProtected*: WINBOOL
  TENPROTECTED* {.pure, packed.} = object
    nmhdr*: NMHDR
    msg*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
    chrg*: CHARRANGE
  TENSAVECLIPBOARD* {.pure.} = object
    nmhdr*: NMHDR
    cObjectCount*: LONG
    cch*: LONG
  TENOLEOPFAILED* {.pure, packed.} = object
    nmhdr*: NMHDR
    iob*: LONG
    lOper*: LONG
    hr*: HRESULT
  OBJECTPOSITIONS* {.pure, packed.} = object
    nmhdr*: NMHDR
    cObjectCount*: LONG
    pcpPositions*: ptr LONG
  TENLINK* {.pure, packed.} = object
    nmhdr*: NMHDR
    msg*: UINT
    wParam*: WPARAM
    lParam*: LPARAM
    chrg*: CHARRANGE
  TENLOWFIRTF* {.pure.} = object
    nmhdr*: NMHDR
    szControl*: ptr char
  TENCORRECTTEXT* {.pure, packed.} = object
    nmhdr*: NMHDR
    chrg*: CHARRANGE
    seltyp*: WORD
    padding*: array[2, byte]
  PUNCTUATION* {.pure, packed.} = object
    iSize*: UINT
    szPunctuation*: LPSTR
  COMPCOLOR* {.pure.} = object
    crText*: COLORREF
    crBackground*: COLORREF
    dwEffects*: DWORD
  REPASTESPECIAL* {.pure, packed.} = object
    dwAspect*: DWORD
    dwParam*: DWORD_PTR
  SETTEXTEX* {.pure.} = object
    flags*: DWORD
    codepage*: UINT
  GETTEXTEX* {.pure, packed.} = object
    cb*: DWORD
    flags*: DWORD
    codepage*: UINT
    lpDefaultChar*: LPCSTR
    lpUsedDefChar*: LPBOOL
  GETTEXTLENGTHEX* {.pure.} = object
    flags*: DWORD
    codepage*: UINT
  BIDIOPTIONS* {.pure.} = object
    cbSize*: UINT
    wMask*: WORD
    wEffects*: WORD
  HYPHRESULT* {.pure.} = object
    khyph*: KHYPH
    ichHyph*: int32
    chHyph*: WCHAR
  HYPHENATEINFO* {.pure, packed.} = object
    cbSize*: SHORT
    dxHyphenateZone*: SHORT
    pfnHyphenate*: proc(P1: ptr WCHAR, P2: LANGID, P3: int32, P4: ptr HYPHRESULT): void {.stdcall.}
proc `dwReserved=`*(self: var CHARFORMAT2W, x: DWORD) {.inline.} = self.union1.dwReserved = x
proc dwReserved*(self: CHARFORMAT2W): DWORD {.inline.} = self.union1.dwReserved
proc dwReserved*(self: var CHARFORMAT2W): var DWORD {.inline.} = self.union1.dwReserved
proc `dwCookie=`*(self: var CHARFORMAT2W, x: DWORD) {.inline.} = self.union1.dwCookie = x
proc dwCookie*(self: CHARFORMAT2W): DWORD {.inline.} = self.union1.dwCookie
proc dwCookie*(self: var CHARFORMAT2W): var DWORD {.inline.} = self.union1.dwCookie
proc `dwReserved=`*(self: var CHARFORMAT2A, x: DWORD) {.inline.} = self.union1.dwReserved = x
proc dwReserved*(self: CHARFORMAT2A): DWORD {.inline.} = self.union1.dwReserved
proc dwReserved*(self: var CHARFORMAT2A): var DWORD {.inline.} = self.union1.dwReserved
proc `dwCookie=`*(self: var CHARFORMAT2A, x: DWORD) {.inline.} = self.union1.dwCookie = x
proc dwCookie*(self: CHARFORMAT2A): DWORD {.inline.} = self.union1.dwCookie
proc dwCookie*(self: var CHARFORMAT2A): var DWORD {.inline.} = self.union1.dwCookie
proc `wReserved=`*(self: var PARAFORMAT, x: WORD) {.inline.} = self.union1.wReserved = x
proc wReserved*(self: PARAFORMAT): WORD {.inline.} = self.union1.wReserved
proc wReserved*(self: var PARAFORMAT): var WORD {.inline.} = self.union1.wReserved
proc `wEffects=`*(self: var PARAFORMAT, x: WORD) {.inline.} = self.union1.wEffects = x
proc wEffects*(self: PARAFORMAT): WORD {.inline.} = self.union1.wEffects
proc wEffects*(self: var PARAFORMAT): var WORD {.inline.} = self.union1.wEffects
proc `wReserved=`*(self: var PARAFORMAT2, x: WORD) {.inline.} = self.union1.wReserved = x
proc wReserved*(self: PARAFORMAT2): WORD {.inline.} = self.union1.wReserved
proc wReserved*(self: var PARAFORMAT2): var WORD {.inline.} = self.union1.wReserved
proc `wEffects=`*(self: var PARAFORMAT2, x: WORD) {.inline.} = self.union1.wEffects = x
proc wEffects*(self: PARAFORMAT2): WORD {.inline.} = self.union1.wEffects
proc wEffects*(self: var PARAFORMAT2): var WORD {.inline.} = self.union1.wEffects
proc GetClientSite*(self: ptr IRichEditOle, lplpolesite: ptr LPOLECLIENTSITE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClientSite(self, lplpolesite)
proc GetObjectCount*(self: ptr IRichEditOle): LONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObjectCount(self)
proc GetLinkCount*(self: ptr IRichEditOle): LONG {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLinkCount(self)
proc GetObject*(self: ptr IRichEditOle, iob: LONG, lpreobject: ptr REOBJECT, dwFlags: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetObject(self, iob, lpreobject, dwFlags)
proc InsertObject*(self: ptr IRichEditOle, lpreobject: ptr REOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InsertObject(self, lpreobject)
proc ConvertObject*(self: ptr IRichEditOle, iob: LONG, rclsidNew: REFCLSID, lpstrUserTypeNew: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ConvertObject(self, iob, rclsidNew, lpstrUserTypeNew)
proc ActivateAs*(self: ptr IRichEditOle, rclsid: REFCLSID, rclsidAs: REFCLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ActivateAs(self, rclsid, rclsidAs)
proc SetHostNames*(self: ptr IRichEditOle, lpstrContainerApp: LPCSTR, lpstrContainerObj: LPCSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetHostNames(self, lpstrContainerApp, lpstrContainerObj)
proc SetLinkAvailable*(self: ptr IRichEditOle, iob: LONG, fAvailable: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetLinkAvailable(self, iob, fAvailable)
proc SetDvaspect*(self: ptr IRichEditOle, iob: LONG, dvaspect: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetDvaspect(self, iob, dvaspect)
proc HandsOffStorage*(self: ptr IRichEditOle, iob: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HandsOffStorage(self, iob)
proc SaveCompleted*(self: ptr IRichEditOle, iob: LONG, lpstg: LPSTORAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SaveCompleted(self, iob, lpstg)
proc InPlaceDeactivate*(self: ptr IRichEditOle): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InPlaceDeactivate(self)
proc ContextSensitiveHelp*(self: ptr IRichEditOle, fEnterMode: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ContextSensitiveHelp(self, fEnterMode)
proc GetClipboardData*(self: ptr IRichEditOle, lpchrg: ptr CHARRANGE, reco: DWORD, lplpdataobj: ptr LPDATAOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClipboardData(self, lpchrg, reco, lplpdataobj)
proc ImportDataObject*(self: ptr IRichEditOle, lpdataobj: LPDATAOBJECT, cf: CLIPFORMAT, hMetaPict: HGLOBAL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ImportDataObject(self, lpdataobj, cf, hMetaPict)
proc GetNewStorage*(self: ptr IRichEditOleCallback, lplpstg: ptr LPSTORAGE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNewStorage(self, lplpstg)
proc GetInPlaceContext*(self: ptr IRichEditOleCallback, lplpFrame: ptr LPOLEINPLACEFRAME, lplpDoc: ptr LPOLEINPLACEUIWINDOW, lpFrameInfo: LPOLEINPLACEFRAMEINFO): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetInPlaceContext(self, lplpFrame, lplpDoc, lpFrameInfo)
proc ShowContainerUI*(self: ptr IRichEditOleCallback, fShow: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ShowContainerUI(self, fShow)
proc QueryInsertObject*(self: ptr IRichEditOleCallback, lpclsid: LPCLSID, lpstg: LPSTORAGE, cp: LONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryInsertObject(self, lpclsid, lpstg, cp)
proc DeleteObject*(self: ptr IRichEditOleCallback, lpoleobj: LPOLEOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DeleteObject(self, lpoleobj)
proc QueryAcceptData*(self: ptr IRichEditOleCallback, lpdataobj: LPDATAOBJECT, lpcfFormat: ptr CLIPFORMAT, reco: DWORD, fReally: WINBOOL, hMetaPict: HGLOBAL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryAcceptData(self, lpdataobj, lpcfFormat, reco, fReally, hMetaPict)
proc ContextSensitiveHelp*(self: ptr IRichEditOleCallback, fEnterMode: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.ContextSensitiveHelp(self, fEnterMode)
proc GetClipboardData*(self: ptr IRichEditOleCallback, lpchrg: ptr CHARRANGE, reco: DWORD, lplpdataobj: ptr LPDATAOBJECT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetClipboardData(self, lpchrg, reco, lplpdataobj)
proc GetDragDropEffect*(self: ptr IRichEditOleCallback, fDrag: WINBOOL, grfKeyState: DWORD, pdwEffect: LPDWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDragDropEffect(self, fDrag, grfKeyState, pdwEffect)
proc GetContextMenu*(self: ptr IRichEditOleCallback, seltype: WORD, lpoleobj: LPOLEOBJECT, lpchrg: ptr CHARRANGE, lphmenu: ptr HMENU): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContextMenu(self, seltype, lpoleobj, lpchrg, lphmenu)
converter winimConverterIRichEditOleToIUnknown*(x: ptr IRichEditOle): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIRichEditOleCallbackToIUnknown*(x: ptr IRichEditOleCallback): ptr IUnknown = cast[ptr IUnknown](x)
when winimUnicode:
  type
    CHARFORMAT* = CHARFORMATW
    CHARFORMAT2* = CHARFORMAT2W
    TEXTRANGE* = TEXTRANGEW
    TFINDTEXT* = TFINDTEXTW
    FINDTEXTEX* = FINDTEXTEXW
  const
    RICHEDIT_CLASS* = RICHEDIT_CLASSW
when winimAnsi:
  type
    CHARFORMAT* = CHARFORMATA
    CHARFORMAT2* = CHARFORMAT2A
    TEXTRANGE* = TEXTRANGEA
    TFINDTEXT* = TFINDTEXTA
    FINDTEXTEX* = FINDTEXTEXA
  const
    RICHEDIT_CLASS* = RICHEDIT_CLASSA
