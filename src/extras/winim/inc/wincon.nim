#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
import wingdi
#include <wincon.h>
type
  COORD* {.pure.} = object
    X*: SHORT
    Y*: SHORT
  PCOORD* = ptr COORD
  SMALL_RECT* {.pure.} = object
    Left*: SHORT
    Top*: SHORT
    Right*: SHORT
    Bottom*: SHORT
  PSMALL_RECT* = ptr SMALL_RECT
  KEY_EVENT_RECORD_uChar* {.pure, union.} = object
    UnicodeChar*: WCHAR
    AsciiChar*: CHAR
  KEY_EVENT_RECORD* {.pure.} = object
    bKeyDown*: WINBOOL
    wRepeatCount*: WORD
    wVirtualKeyCode*: WORD
    wVirtualScanCode*: WORD
    uChar*: KEY_EVENT_RECORD_uChar
    dwControlKeyState*: DWORD
  PKEY_EVENT_RECORD* = ptr KEY_EVENT_RECORD
  MOUSE_EVENT_RECORD* {.pure.} = object
    dwMousePosition*: COORD
    dwButtonState*: DWORD
    dwControlKeyState*: DWORD
    dwEventFlags*: DWORD
  PMOUSE_EVENT_RECORD* = ptr MOUSE_EVENT_RECORD
  WINDOW_BUFFER_SIZE_RECORD* {.pure.} = object
    dwSize*: COORD
  PWINDOW_BUFFER_SIZE_RECORD* = ptr WINDOW_BUFFER_SIZE_RECORD
  MENU_EVENT_RECORD* {.pure.} = object
    dwCommandId*: UINT
  PMENU_EVENT_RECORD* = ptr MENU_EVENT_RECORD
  FOCUS_EVENT_RECORD* {.pure.} = object
    bSetFocus*: WINBOOL
  PFOCUS_EVENT_RECORD* = ptr FOCUS_EVENT_RECORD
  INPUT_RECORD_Event* {.pure, union.} = object
    KeyEvent*: KEY_EVENT_RECORD
    MouseEvent*: MOUSE_EVENT_RECORD
    WindowBufferSizeEvent*: WINDOW_BUFFER_SIZE_RECORD
    MenuEvent*: MENU_EVENT_RECORD
    FocusEvent*: FOCUS_EVENT_RECORD
  INPUT_RECORD* {.pure.} = object
    EventType*: WORD
    Event*: INPUT_RECORD_Event
  PINPUT_RECORD* = ptr INPUT_RECORD
  CHAR_INFO_Char* {.pure, union.} = object
    UnicodeChar*: WCHAR
    AsciiChar*: CHAR
  CHAR_INFO* {.pure.} = object
    Char*: CHAR_INFO_Char
    Attributes*: WORD
  PCHAR_INFO* = ptr CHAR_INFO
  CONSOLE_SCREEN_BUFFER_INFO* {.pure.} = object
    dwSize*: COORD
    dwCursorPosition*: COORD
    wAttributes*: WORD
    srWindow*: SMALL_RECT
    dwMaximumWindowSize*: COORD
  PCONSOLE_SCREEN_BUFFER_INFO* = ptr CONSOLE_SCREEN_BUFFER_INFO
  CONSOLE_CURSOR_INFO* {.pure.} = object
    dwSize*: DWORD
    bVisible*: WINBOOL
  PCONSOLE_CURSOR_INFO* = ptr CONSOLE_CURSOR_INFO
  CONSOLE_FONT_INFO* {.pure.} = object
    nFont*: DWORD
    dwFontSize*: COORD
  PCONSOLE_FONT_INFO* = ptr CONSOLE_FONT_INFO
  CONSOLE_SELECTION_INFO* {.pure.} = object
    dwFlags*: DWORD
    dwSelectionAnchor*: COORD
    srSelection*: SMALL_RECT
  PCONSOLE_SELECTION_INFO* = ptr CONSOLE_SELECTION_INFO
  CONSOLE_FONT_INFOEX* {.pure.} = object
    cbSize*: ULONG
    nFont*: DWORD
    dwFontSize*: COORD
    FontFamily*: UINT
    FontWeight*: UINT
    FaceName*: array[LF_FACESIZE, WCHAR]
  PCONSOLE_FONT_INFOEX* = ptr CONSOLE_FONT_INFOEX
  CONSOLE_HISTORY_INFO* {.pure.} = object
    cbSize*: UINT
    HistoryBufferSize*: UINT
    NumberOfHistoryBuffers*: UINT
    dwFlags*: DWORD
  PCONSOLE_HISTORY_INFO* = ptr CONSOLE_HISTORY_INFO
  CONSOLE_READCONSOLE_CONTROL* {.pure.} = object
    nLength*: ULONG
    nInitialChars*: ULONG
    dwCtrlWakeupMask*: ULONG
    dwControlKeyState*: ULONG
  PCONSOLE_READCONSOLE_CONTROL* = ptr CONSOLE_READCONSOLE_CONTROL
  CONSOLE_SCREEN_BUFFER_INFOEX* {.pure.} = object
    cbSize*: ULONG
    dwSize*: COORD
    dwCursorPosition*: COORD
    wAttributes*: WORD
    srWindow*: SMALL_RECT
    dwMaximumWindowSize*: COORD
    wPopupAttributes*: WORD
    bFullscreenSupported*: WINBOOL
    ColorTable*: array[16, COLORREF]
  PCONSOLE_SCREEN_BUFFER_INFOEX* = ptr CONSOLE_SCREEN_BUFFER_INFOEX
const
  RIGHT_ALT_PRESSED* = 0x1
  LEFT_ALT_PRESSED* = 0x2
  RIGHT_CTRL_PRESSED* = 0x4
  LEFT_CTRL_PRESSED* = 0x8
  SHIFT_PRESSED* = 0x10
  NUMLOCK_ON* = 0x20
  SCROLLLOCK_ON* = 0x40
  CAPSLOCK_ON* = 0x80
  ENHANCED_KEY* = 0x100
  NLS_DBCSCHAR* = 0x10000
  NLS_ALPHANUMERIC* = 0x0
  NLS_KATAKANA* = 0x20000
  NLS_HIRAGANA* = 0x40000
  NLS_ROMAN* = 0x400000
  NLS_IME_CONVERSION* = 0x800000
  NLS_IME_DISABLE* = 0x20000000
  FROM_LEFT_1ST_BUTTON_PRESSED* = 0x1
  RIGHTMOST_BUTTON_PRESSED* = 0x2
  FROM_LEFT_2ND_BUTTON_PRESSED* = 0x4
  FROM_LEFT_3RD_BUTTON_PRESSED* = 0x8
  FROM_LEFT_4TH_BUTTON_PRESSED* = 0x10
  MOUSE_MOVED* = 0x1
  DOUBLE_CLICK* = 0x2
  MOUSE_WHEELED* = 0x4
  MOUSE_HWHEELED* = 0x8
  KEY_EVENT* = 0x1
  MOUSE_EVENT* = 0x2
  WINDOW_BUFFER_SIZE_EVENT* = 0x4
  MENU_EVENT* = 0x8
  FOCUS_EVENT* = 0x10
  FOREGROUND_BLUE* = 0x1
  FOREGROUND_GREEN* = 0x2
  FOREGROUND_RED* = 0x4
  FOREGROUND_INTENSITY* = 0x8
  BACKGROUND_BLUE* = 0x10
  BACKGROUND_GREEN* = 0x20
  BACKGROUND_RED* = 0x40
  BACKGROUND_INTENSITY* = 0x80
  COMMON_LVB_LEADING_BYTE* = 0x100
  COMMON_LVB_TRAILING_BYTE* = 0x200
  COMMON_LVB_GRID_HORIZONTAL* = 0x400
  COMMON_LVB_GRID_LVERTICAL* = 0x800
  COMMON_LVB_GRID_RVERTICAL* = 0x1000
  COMMON_LVB_REVERSE_VIDEO* = 0x4000
  COMMON_LVB_UNDERSCORE* = 0x8000
  COMMON_LVB_SBCSDBCS* = 0x300
  CONSOLE_NO_SELECTION* = 0x0
  CONSOLE_SELECTION_IN_PROGRESS* = 0x1
  CONSOLE_SELECTION_NOT_EMPTY* = 0x2
  CONSOLE_MOUSE_SELECTION* = 0x4
  CONSOLE_MOUSE_DOWN* = 0x8
  CTRL_C_EVENT* = 0
  CTRL_BREAK_EVENT* = 1
  CTRL_CLOSE_EVENT* = 2
  CTRL_LOGOFF_EVENT* = 5
  CTRL_SHUTDOWN_EVENT* = 6
  ENABLE_PROCESSED_INPUT* = 0x1
  ENABLE_LINE_INPUT* = 0x2
  ENABLE_ECHO_INPUT* = 0x4
  ENABLE_WINDOW_INPUT* = 0x8
  ENABLE_MOUSE_INPUT* = 0x10
  ENABLE_INSERT_MODE* = 0x20
  ENABLE_QUICK_EDIT_MODE* = 0x40
  ENABLE_EXTENDED_FLAGS* = 0x80
  ENABLE_AUTO_POSITION* = 0x100
  ENABLE_PROCESSED_OUTPUT* = 0x1
  ENABLE_WRAP_AT_EOL_OUTPUT* = 0x2
  ATTACH_PARENT_PROCESS* = DWORD(-1)
  CONSOLE_TEXTMODE_BUFFER* = 1
  CONSOLE_FULLSCREEN* = 1
  CONSOLE_FULLSCREEN_HARDWARE* = 2
  CONSOLE_FULLSCREEN_MODE* = 1
  CONSOLE_WINDOWED_MODE* = 2
type
  PHANDLER_ROUTINE* = proc (CtrlType: DWORD): WINBOOL {.stdcall.}
proc PeekConsoleInputA*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc PeekConsoleInputW*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleInputA*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleInputW*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleInputA*(hConsoleInput: HANDLE, lpBuffer: ptr INPUT_RECORD, nLength: DWORD, lpNumberOfEventsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleInputW*(hConsoleInput: HANDLE, lpBuffer: ptr INPUT_RECORD, nLength: DWORD, lpNumberOfEventsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleOutputA*(hConsoleOutput: HANDLE, lpBuffer: PCHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpReadRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleOutputW*(hConsoleOutput: HANDLE, lpBuffer: PCHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpReadRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleOutputA*(hConsoleOutput: HANDLE, lpBuffer: ptr CHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpWriteRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleOutputW*(hConsoleOutput: HANDLE, lpBuffer: ptr CHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpWriteRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleOutputCharacterA*(hConsoleOutput: HANDLE, lpCharacter: LPSTR, nLength: DWORD, dwReadCoord: COORD, lpNumberOfCharsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleOutputCharacterW*(hConsoleOutput: HANDLE, lpCharacter: LPWSTR, nLength: DWORD, dwReadCoord: COORD, lpNumberOfCharsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleOutputAttribute*(hConsoleOutput: HANDLE, lpAttribute: LPWORD, nLength: DWORD, dwReadCoord: COORD, lpNumberOfAttrsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleOutputCharacterA*(hConsoleOutput: HANDLE, lpCharacter: LPCSTR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleOutputCharacterW*(hConsoleOutput: HANDLE, lpCharacter: LPCWSTR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleOutputAttribute*(hConsoleOutput: HANDLE, lpAttribute: ptr WORD, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfAttrsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FillConsoleOutputCharacterA*(hConsoleOutput: HANDLE, cCharacter: CHAR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FillConsoleOutputCharacterW*(hConsoleOutput: HANDLE, cCharacter: WCHAR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FillConsoleOutputAttribute*(hConsoleOutput: HANDLE, wAttribute: WORD, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfAttrsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleMode*(hConsoleHandle: HANDLE, lpMode: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumberOfConsoleInputEvents*(hConsoleInput: HANDLE, lpNumberOfEvents: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleScreenBufferInfo*(hConsoleOutput: HANDLE, lpConsoleScreenBufferInfo: PCONSOLE_SCREEN_BUFFER_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLargestConsoleWindowSize*(hConsoleOutput: HANDLE): COORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleCursorInfo*(hConsoleOutput: HANDLE, lpConsoleCursorInfo: PCONSOLE_CURSOR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentConsoleFont*(hConsoleOutput: HANDLE, bMaximumWindow: WINBOOL, lpConsoleCurrentFont: PCONSOLE_FONT_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleFontSize*(hConsoleOutput: HANDLE, nFont: DWORD): COORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleSelectionInfo*(lpConsoleSelectionInfo: PCONSOLE_SELECTION_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumberOfConsoleMouseButtons*(lpNumberOfMouseButtons: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleMode*(hConsoleHandle: HANDLE, dwMode: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleActiveScreenBuffer*(hConsoleOutput: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FlushConsoleInputBuffer*(hConsoleInput: HANDLE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleScreenBufferSize*(hConsoleOutput: HANDLE, dwSize: COORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleCursorPosition*(hConsoleOutput: HANDLE, dwCursorPosition: COORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleCursorInfo*(hConsoleOutput: HANDLE, lpConsoleCursorInfo: ptr CONSOLE_CURSOR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ScrollConsoleScreenBufferA*(hConsoleOutput: HANDLE, lpScrollRectangle: ptr SMALL_RECT, lpClipRectangle: ptr SMALL_RECT, dwDestinationOrigin: COORD, lpFill: ptr CHAR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ScrollConsoleScreenBufferW*(hConsoleOutput: HANDLE, lpScrollRectangle: ptr SMALL_RECT, lpClipRectangle: ptr SMALL_RECT, dwDestinationOrigin: COORD, lpFill: ptr CHAR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleWindowInfo*(hConsoleOutput: HANDLE, bAbsolute: WINBOOL, lpConsoleWindow: ptr SMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleTextAttribute*(hConsoleOutput: HANDLE, wAttributes: WORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleCtrlHandler*(HandlerRoutine: PHANDLER_ROUTINE, Add: WINBOOL): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GenerateConsoleCtrlEvent*(dwCtrlEvent: DWORD, dwProcessGroupId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AllocConsole*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FreeConsole*(): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AttachConsole*(dwProcessId: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleTitleA*(lpConsoleTitle: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleTitleW*(lpConsoleTitle: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleTitleA*(lpConsoleTitle: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleTitleW*(lpConsoleTitle: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleA*(hConsoleInput: HANDLE, lpBuffer: LPVOID, nNumberOfCharsToRead: DWORD, lpNumberOfCharsRead: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ReadConsoleW*(hConsoleInput: HANDLE, lpBuffer: LPVOID, nNumberOfCharsToRead: DWORD, lpNumberOfCharsRead: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleA*(hConsoleOutput: HANDLE, lpBuffer: pointer, nNumberOfCharsToWrite: DWORD, lpNumberOfCharsWritten: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WriteConsoleW*(hConsoleOutput: HANDLE, lpBuffer: pointer, nNumberOfCharsToWrite: DWORD, lpNumberOfCharsWritten: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CreateConsoleScreenBuffer*(dwDesiredAccess: DWORD, dwShareMode: DWORD, lpSecurityAttributes: ptr SECURITY_ATTRIBUTES, dwFlags: DWORD, lpScreenBufferData: LPVOID): HANDLE {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleCP*(): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleCP*(wCodePageID: UINT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleOutputCP*(): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleOutputCP*(wCodePageID: UINT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleDisplayMode*(lpModeFlags: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleDisplayMode*(hConsoleOutput: HANDLE, dwFlags: DWORD, lpNewScreenBufferDimensions: PCOORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleWindow*(): HWND {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleProcessList*(lpdwProcessList: LPDWORD, dwProcessCount: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddConsoleAliasA*(Source: LPSTR, Target: LPSTR, ExeName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc AddConsoleAliasW*(Source: LPWSTR, Target: LPWSTR, ExeName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasA*(Source: LPSTR, TargetBuffer: LPSTR, TargetBufferLength: DWORD, ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasW*(Source: LPWSTR, TargetBuffer: LPWSTR, TargetBufferLength: DWORD, ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasesLengthA*(ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasesLengthW*(ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasExesLengthA*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasExesLengthW*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasesA*(AliasBuffer: LPSTR, AliasBufferLength: DWORD, ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasesW*(AliasBuffer: LPWSTR, AliasBufferLength: DWORD, ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasExesA*(ExeNameBuffer: LPSTR, ExeNameBufferLength: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleAliasExesW*(ExeNameBuffer: LPWSTR, ExeNameBufferLength: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleHistoryInfo*(lpConsoleHistoryInfo: PCONSOLE_HISTORY_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleOriginalTitleA*(lpConsoleTitle: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleOriginalTitleW*(lpConsoleTitle: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetConsoleScreenBufferInfoEx*(hConsoleOutput: HANDLE, lpConsoleScreenBufferInfoEx: PCONSOLE_SCREEN_BUFFER_INFOEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrentConsoleFontEx*(hConsoleOutput: HANDLE, bMaximumWindow: WINBOOL, lpConsoleCurrentFontEx: PCONSOLE_FONT_INFOEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleHistoryInfo*(lpConsoleHistoryInfo: PCONSOLE_HISTORY_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetConsoleScreenBufferInfoEx*(hConsoleOutput: HANDLE, lpConsoleScreenBufferInfoEx: PCONSOLE_SCREEN_BUFFER_INFOEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCurrentConsoleFontEx*(hConsoleOutput: HANDLE, bMaximumWindow: WINBOOL, lpConsoleCurrentFontEx: PCONSOLE_FONT_INFOEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
when winimUnicode:
  proc PeekConsoleInput*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "PeekConsoleInputW".}
  proc ReadConsoleInput*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleInputW".}
  proc WriteConsoleInput*(hConsoleInput: HANDLE, lpBuffer: ptr INPUT_RECORD, nLength: DWORD, lpNumberOfEventsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleInputW".}
  proc ReadConsoleOutput*(hConsoleOutput: HANDLE, lpBuffer: PCHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpReadRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleOutputW".}
  proc WriteConsoleOutput*(hConsoleOutput: HANDLE, lpBuffer: ptr CHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpWriteRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleOutputW".}
  proc ReadConsoleOutputCharacter*(hConsoleOutput: HANDLE, lpCharacter: LPWSTR, nLength: DWORD, dwReadCoord: COORD, lpNumberOfCharsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleOutputCharacterW".}
  proc WriteConsoleOutputCharacter*(hConsoleOutput: HANDLE, lpCharacter: LPCWSTR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleOutputCharacterW".}
  proc FillConsoleOutputCharacter*(hConsoleOutput: HANDLE, cCharacter: WCHAR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FillConsoleOutputCharacterW".}
  proc ScrollConsoleScreenBuffer*(hConsoleOutput: HANDLE, lpScrollRectangle: ptr SMALL_RECT, lpClipRectangle: ptr SMALL_RECT, dwDestinationOrigin: COORD, lpFill: ptr CHAR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ScrollConsoleScreenBufferW".}
  proc GetConsoleTitle*(lpConsoleTitle: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleTitleW".}
  proc SetConsoleTitle*(lpConsoleTitle: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetConsoleTitleW".}
  proc ReadConsole*(hConsoleInput: HANDLE, lpBuffer: LPVOID, nNumberOfCharsToRead: DWORD, lpNumberOfCharsRead: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleW".}
  proc WriteConsole*(hConsoleOutput: HANDLE, lpBuffer: pointer, nNumberOfCharsToWrite: DWORD, lpNumberOfCharsWritten: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleW".}
  proc AddConsoleAlias*(Source: LPWSTR, Target: LPWSTR, ExeName: LPWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "AddConsoleAliasW".}
  proc GetConsoleAlias*(Source: LPWSTR, TargetBuffer: LPWSTR, TargetBufferLength: DWORD, ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasW".}
  proc GetConsoleAliasesLength*(ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasesLengthW".}
  proc GetConsoleAliasExesLength*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasExesLengthW".}
  proc GetConsoleAliases*(AliasBuffer: LPWSTR, AliasBufferLength: DWORD, ExeName: LPWSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasesW".}
  proc GetConsoleAliasExes*(ExeNameBuffer: LPWSTR, ExeNameBufferLength: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasExesW".}
  proc GetConsoleOriginalTitle*(lpConsoleTitle: LPWSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleOriginalTitleW".}
when winimAnsi:
  proc PeekConsoleInput*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "PeekConsoleInputA".}
  proc ReadConsoleInput*(hConsoleInput: HANDLE, lpBuffer: PINPUT_RECORD, nLength: DWORD, lpNumberOfEventsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleInputA".}
  proc WriteConsoleInput*(hConsoleInput: HANDLE, lpBuffer: ptr INPUT_RECORD, nLength: DWORD, lpNumberOfEventsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleInputA".}
  proc ReadConsoleOutput*(hConsoleOutput: HANDLE, lpBuffer: PCHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpReadRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleOutputA".}
  proc WriteConsoleOutput*(hConsoleOutput: HANDLE, lpBuffer: ptr CHAR_INFO, dwBufferSize: COORD, dwBufferCoord: COORD, lpWriteRegion: PSMALL_RECT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleOutputA".}
  proc ReadConsoleOutputCharacter*(hConsoleOutput: HANDLE, lpCharacter: LPSTR, nLength: DWORD, dwReadCoord: COORD, lpNumberOfCharsRead: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleOutputCharacterA".}
  proc WriteConsoleOutputCharacter*(hConsoleOutput: HANDLE, lpCharacter: LPCSTR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleOutputCharacterA".}
  proc FillConsoleOutputCharacter*(hConsoleOutput: HANDLE, cCharacter: CHAR, nLength: DWORD, dwWriteCoord: COORD, lpNumberOfCharsWritten: LPDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "FillConsoleOutputCharacterA".}
  proc ScrollConsoleScreenBuffer*(hConsoleOutput: HANDLE, lpScrollRectangle: ptr SMALL_RECT, lpClipRectangle: ptr SMALL_RECT, dwDestinationOrigin: COORD, lpFill: ptr CHAR_INFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ScrollConsoleScreenBufferA".}
  proc GetConsoleTitle*(lpConsoleTitle: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleTitleA".}
  proc SetConsoleTitle*(lpConsoleTitle: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetConsoleTitleA".}
  proc ReadConsole*(hConsoleInput: HANDLE, lpBuffer: LPVOID, nNumberOfCharsToRead: DWORD, lpNumberOfCharsRead: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "ReadConsoleA".}
  proc WriteConsole*(hConsoleOutput: HANDLE, lpBuffer: pointer, nNumberOfCharsToWrite: DWORD, lpNumberOfCharsWritten: LPDWORD, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "WriteConsoleA".}
  proc AddConsoleAlias*(Source: LPSTR, Target: LPSTR, ExeName: LPSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "AddConsoleAliasA".}
  proc GetConsoleAlias*(Source: LPSTR, TargetBuffer: LPSTR, TargetBufferLength: DWORD, ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasA".}
  proc GetConsoleAliasesLength*(ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasesLengthA".}
  proc GetConsoleAliasExesLength*(): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasExesLengthA".}
  proc GetConsoleAliases*(AliasBuffer: LPSTR, AliasBufferLength: DWORD, ExeName: LPSTR): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasesA".}
  proc GetConsoleAliasExes*(ExeNameBuffer: LPSTR, ExeNameBufferLength: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleAliasExesA".}
  proc GetConsoleOriginalTitle*(lpConsoleTitle: LPSTR, nSize: DWORD): DWORD {.winapi, stdcall, dynlib: "kernel32", importc: "GetConsoleOriginalTitleA".}
