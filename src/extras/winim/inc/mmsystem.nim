#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wingdi
import imm
#include <mmsystem.h>
#include <mmreg.h>
type
  HPSTR* = ptr char
  HDRVR* = HANDLE
  HWAVE* = HANDLE
  HWAVEIN* = HANDLE
  HWAVEOUT* = HANDLE
  HMIDI* = HANDLE
  HMIDIIN* = HANDLE
  HMIDIOUT* = HANDLE
  HMIDISTRM* = HANDLE
  LPPATCHARRAY* = ptr WORD
  LPKEYARRAY* = ptr WORD
  HMIXEROBJ* = HANDLE
  HMIXER* = HANDLE
  FOURCC* = DWORD
  HMMIO* = HANDLE
  MCIERROR* = DWORD
  MMVERSION* = UINT
  MMRESULT* = UINT
  MMTIME_u_smpte* {.pure.} = object
    hour*: BYTE
    min*: BYTE
    sec*: BYTE
    frame*: BYTE
    fps*: BYTE
    dummy*: BYTE
    pad*: array[2, BYTE]
  MMTIME_u_midi* {.pure.} = object
    songptrpos*: DWORD
  MMTIME_u* {.pure, union.} = object
    ms*: DWORD
    sample*: DWORD
    cb*: DWORD
    ticks*: DWORD
    smpte*: MMTIME_u_smpte
    midi*: MMTIME_u_midi
  MMTIME* {.pure.} = object
    wType*: UINT
    u*: MMTIME_u
  PMMTIME* = ptr MMTIME
  NPMMTIME* = ptr MMTIME
  LPMMTIME* = ptr MMTIME
  DRVCONFIGINFOEX* {.pure, packed.} = object
    dwDCISize*: DWORD
    lpszDCISectionName*: LPCWSTR
    lpszDCIAliasName*: LPCWSTR
    dnDevNode*: DWORD
  PDRVCONFIGINFOEX* = ptr DRVCONFIGINFOEX
  NPDRVCONFIGINFOEX* = ptr DRVCONFIGINFOEX
  LPDRVCONFIGINFOEX* = ptr DRVCONFIGINFOEX
  DRVCONFIGINFO* {.pure, packed.} = object
    dwDCISize*: DWORD
    lpszDCISectionName*: LPCWSTR
    lpszDCIAliasName*: LPCWSTR
  PDRVCONFIGINFO* = ptr DRVCONFIGINFO
  NPDRVCONFIGINFO* = ptr DRVCONFIGINFO
  LPDRVCONFIGINFO* = ptr DRVCONFIGINFO
  DRVCALLBACK* = proc (hdrvr: HDRVR, uMsg: UINT, dwUser: DWORD_PTR, dw1: DWORD_PTR, dw2: DWORD_PTR): void {.stdcall.}
  LPDRVCALLBACK* = ptr DRVCALLBACK
  PDRVCALLBACK* = ptr DRVCALLBACK
  LPHWAVEIN* = ptr HWAVEIN
  LPHWAVEOUT* = ptr HWAVEOUT
  WAVECALLBACK* = DRVCALLBACK
  LPWAVECALLBACK* = ptr WAVECALLBACK
  WAVEHDR* {.pure.} = object
    lpData*: LPSTR
    dwBufferLength*: DWORD
    dwBytesRecorded*: DWORD
    dwUser*: DWORD_PTR
    dwFlags*: DWORD
    dwLoops*: DWORD
    lpNext*: ptr WAVEHDR
    reserved*: DWORD_PTR
  PWAVEHDR* = ptr WAVEHDR
  NPWAVEHDR* = ptr WAVEHDR
  LPWAVEHDR* = ptr WAVEHDR
const
  MAXPNAMELEN* = 32
type
  WAVEOUTCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
  PWAVEOUTCAPSA* = ptr WAVEOUTCAPSA
  NPWAVEOUTCAPSA* = ptr WAVEOUTCAPSA
  LPWAVEOUTCAPSA* = ptr WAVEOUTCAPSA
  WAVEOUTCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
  PWAVEOUTCAPSW* = ptr WAVEOUTCAPSW
  NPWAVEOUTCAPSW* = ptr WAVEOUTCAPSW
  LPWAVEOUTCAPSW* = ptr WAVEOUTCAPSW
  WAVEOUTCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PWAVEOUTCAPS2A* = ptr WAVEOUTCAPS2A
  NPWAVEOUTCAPS2A* = ptr WAVEOUTCAPS2A
  LPWAVEOUTCAPS2A* = ptr WAVEOUTCAPS2A
  WAVEOUTCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PWAVEOUTCAPS2W* = ptr WAVEOUTCAPS2W
  NPWAVEOUTCAPS2W* = ptr WAVEOUTCAPS2W
  LPWAVEOUTCAPS2W* = ptr WAVEOUTCAPS2W
  WAVEINCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
  PWAVEINCAPSA* = ptr WAVEINCAPSA
  NPWAVEINCAPSA* = ptr WAVEINCAPSA
  LPWAVEINCAPSA* = ptr WAVEINCAPSA
  WAVEINCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
  PWAVEINCAPSW* = ptr WAVEINCAPSW
  NPWAVEINCAPSW* = ptr WAVEINCAPSW
  LPWAVEINCAPSW* = ptr WAVEINCAPSW
  WAVEINCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PWAVEINCAPS2A* = ptr WAVEINCAPS2A
  NPWAVEINCAPS2A* = ptr WAVEINCAPS2A
  LPWAVEINCAPS2A* = ptr WAVEINCAPS2A
  WAVEINCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwFormats*: DWORD
    wChannels*: WORD
    wReserved1*: WORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PWAVEINCAPS2W* = ptr WAVEINCAPS2W
  NPWAVEINCAPS2W* = ptr WAVEINCAPS2W
  LPWAVEINCAPS2W* = ptr WAVEINCAPS2W
  WAVEFORMAT* {.pure, packed.} = object
    wFormatTag*: WORD
    nChannels*: WORD
    nSamplesPerSec*: DWORD
    nAvgBytesPerSec*: DWORD
    nBlockAlign*: WORD
  PWAVEFORMAT* = ptr WAVEFORMAT
  NPWAVEFORMAT* = ptr WAVEFORMAT
  LPWAVEFORMAT* = ptr WAVEFORMAT
  PCMWAVEFORMAT* {.pure, packed.} = object
    wf*: WAVEFORMAT
    wBitsPerSample*: WORD
  PPCMWAVEFORMAT* = ptr PCMWAVEFORMAT
  NPPCMWAVEFORMAT* = ptr PCMWAVEFORMAT
  LPPCMWAVEFORMAT* = ptr PCMWAVEFORMAT
  WAVEFORMATEX* {.pure, packed.} = object
    wFormatTag*: WORD
    nChannels*: WORD
    nSamplesPerSec*: DWORD
    nAvgBytesPerSec*: DWORD
    nBlockAlign*: WORD
    wBitsPerSample*: WORD
    cbSize*: WORD
  PWAVEFORMATEX* = ptr WAVEFORMATEX
  NPWAVEFORMATEX* = ptr WAVEFORMATEX
  LPWAVEFORMATEX* = ptr WAVEFORMATEX
  LPCWAVEFORMATEX* = ptr WAVEFORMATEX
  LPHMIDI* = ptr HMIDI
  LPHMIDIIN* = ptr HMIDIIN
  LPHMIDIOUT* = ptr HMIDIOUT
  LPHMIDISTRM* = ptr HMIDISTRM
  MIDICALLBACK* = DRVCALLBACK
  LPMIDICALLBACK* = ptr MIDICALLBACK
const
  MIDIPATCHSIZE* = 128
type
  PATCHARRAY* = array[MIDIPATCHSIZE, WORD]
  KEYARRAY* = array[MIDIPATCHSIZE, WORD]
  MIDIOUTCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    wTechnology*: WORD
    wVoices*: WORD
    wNotes*: WORD
    wChannelMask*: WORD
    dwSupport*: DWORD
  PMIDIOUTCAPSA* = ptr MIDIOUTCAPSA
  NPMIDIOUTCAPSA* = ptr MIDIOUTCAPSA
  LPMIDIOUTCAPSA* = ptr MIDIOUTCAPSA
  MIDIOUTCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    wTechnology*: WORD
    wVoices*: WORD
    wNotes*: WORD
    wChannelMask*: WORD
    dwSupport*: DWORD
  PMIDIOUTCAPSW* = ptr MIDIOUTCAPSW
  NPMIDIOUTCAPSW* = ptr MIDIOUTCAPSW
  LPMIDIOUTCAPSW* = ptr MIDIOUTCAPSW
  MIDIOUTCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    wTechnology*: WORD
    wVoices*: WORD
    wNotes*: WORD
    wChannelMask*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIDIOUTCAPS2A* = ptr MIDIOUTCAPS2A
  NPMIDIOUTCAPS2A* = ptr MIDIOUTCAPS2A
  LPMIDIOUTCAPS2A* = ptr MIDIOUTCAPS2A
  MIDIOUTCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    wTechnology*: WORD
    wVoices*: WORD
    wNotes*: WORD
    wChannelMask*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIDIOUTCAPS2W* = ptr MIDIOUTCAPS2W
  NPMIDIOUTCAPS2W* = ptr MIDIOUTCAPS2W
  LPMIDIOUTCAPS2W* = ptr MIDIOUTCAPS2W
  MIDIINCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwSupport*: DWORD
  PMIDIINCAPSA* = ptr MIDIINCAPSA
  NPMIDIINCAPSA* = ptr MIDIINCAPSA
  LPMIDIINCAPSA* = ptr MIDIINCAPSA
  MIDIINCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwSupport*: DWORD
  PMIDIINCAPSW* = ptr MIDIINCAPSW
  NPMIDIINCAPSW* = ptr MIDIINCAPSW
  LPMIDIINCAPSW* = ptr MIDIINCAPSW
  MIDIINCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIDIINCAPS2A* = ptr MIDIINCAPS2A
  NPMIDIINCAPS2A* = ptr MIDIINCAPS2A
  LPMIDIINCAPS2A* = ptr MIDIINCAPS2A
  MIDIINCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIDIINCAPS2W* = ptr MIDIINCAPS2W
  NPMIDIINCAPS2W* = ptr MIDIINCAPS2W
  LPMIDIINCAPS2W* = ptr MIDIINCAPS2W
  MIDIHDR* {.pure, packed.} = object
    lpData*: LPSTR
    dwBufferLength*: DWORD
    dwBytesRecorded*: DWORD
    dwUser*: DWORD_PTR
    dwFlags*: DWORD
    lpNext*: ptr MIDIHDR
    reserved*: DWORD_PTR
    dwOffset*: DWORD
    dwReserved*: array[8, DWORD_PTR]
  PMIDIHDR* = ptr MIDIHDR
  NPMIDIHDR* = ptr MIDIHDR
  LPMIDIHDR* = ptr MIDIHDR
  TMIDIPROPTIMEDIV* {.pure.} = object
    cbStruct*: DWORD
    dwTimeDiv*: DWORD
  LPMIDIPROPTIMEDIV* = ptr TMIDIPROPTIMEDIV
  TMIDIPROPTEMPO* {.pure.} = object
    cbStruct*: DWORD
    dwTempo*: DWORD
  LPMIDIPROPTEMPO* = ptr TMIDIPROPTEMPO
  AUXCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    wTechnology*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
  PAUXCAPSA* = ptr AUXCAPSA
  NPAUXCAPSA* = ptr AUXCAPSA
  LPAUXCAPSA* = ptr AUXCAPSA
  AUXCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    wTechnology*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
  PAUXCAPSW* = ptr AUXCAPSW
  NPAUXCAPSW* = ptr AUXCAPSW
  LPAUXCAPSW* = ptr AUXCAPSW
  AUXCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    wTechnology*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PAUXCAPS2A* = ptr AUXCAPS2A
  NPAUXCAPS2A* = ptr AUXCAPS2A
  LPAUXCAPS2A* = ptr AUXCAPS2A
  AUXCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    wTechnology*: WORD
    wReserved1*: WORD
    dwSupport*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PAUXCAPS2W* = ptr AUXCAPS2W
  NPAUXCAPS2W* = ptr AUXCAPS2W
  LPAUXCAPS2W* = ptr AUXCAPS2W
  LPHMIXEROBJ* = ptr HMIXEROBJ
  LPHMIXER* = ptr HMIXER
  MIXERCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    fdwSupport*: DWORD
    cDestinations*: DWORD
  PMIXERCAPSA* = ptr MIXERCAPSA
  LPMIXERCAPSA* = ptr MIXERCAPSA
  MIXERCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    fdwSupport*: DWORD
    cDestinations*: DWORD
  PMIXERCAPSW* = ptr MIXERCAPSW
  LPMIXERCAPSW* = ptr MIXERCAPSW
  MIXERCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
    fdwSupport*: DWORD
    cDestinations*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIXERCAPS2A* = ptr MIXERCAPS2A
  LPMIXERCAPS2A* = ptr MIXERCAPS2A
  MIXERCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
    fdwSupport*: DWORD
    cDestinations*: DWORD
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PMIXERCAPS2W* = ptr MIXERCAPS2W
  LPMIXERCAPS2W* = ptr MIXERCAPS2W
const
  MIXER_SHORT_NAME_CHARS* = 16
  MIXER_LONG_NAME_CHARS* = 64
type
  MIXERLINEA_Target* {.pure.} = object
    dwType*: DWORD
    dwDeviceID*: DWORD
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, CHAR]
  MIXERLINEA* {.pure, packed.} = object
    cbStruct*: DWORD
    dwDestination*: DWORD
    dwSource*: DWORD
    dwLineID*: DWORD
    fdwLine*: DWORD
    dwUser*: DWORD_PTR
    dwComponentType*: DWORD
    cChannels*: DWORD
    cConnections*: DWORD
    cControls*: DWORD
    szShortName*: array[MIXER_SHORT_NAME_CHARS, CHAR]
    szName*: array[MIXER_LONG_NAME_CHARS, CHAR]
    Target*: MIXERLINEA_Target
  PMIXERLINEA* = ptr MIXERLINEA
  LPMIXERLINEA* = ptr MIXERLINEA
  MIXERLINEW_Target* {.pure.} = object
    dwType*: DWORD
    dwDeviceID*: DWORD
    wMid*: WORD
    wPid*: WORD
    vDriverVersion*: MMVERSION
    szPname*: array[MAXPNAMELEN, WCHAR]
  MIXERLINEW* {.pure, packed.} = object
    cbStruct*: DWORD
    dwDestination*: DWORD
    dwSource*: DWORD
    dwLineID*: DWORD
    fdwLine*: DWORD
    dwUser*: DWORD_PTR
    dwComponentType*: DWORD
    cChannels*: DWORD
    cConnections*: DWORD
    cControls*: DWORD
    szShortName*: array[MIXER_SHORT_NAME_CHARS, WCHAR]
    szName*: array[MIXER_LONG_NAME_CHARS, WCHAR]
    Target*: MIXERLINEW_Target
  PMIXERLINEW* = ptr MIXERLINEW
  LPMIXERLINEW* = ptr MIXERLINEW
  MIXERCONTROLA_Bounds_STRUCT1* {.pure.} = object
    lMinimum*: LONG
    lMaximum*: LONG
  MIXERCONTROLA_Bounds_STRUCT2* {.pure.} = object
    dwMinimum*: DWORD
    dwMaximum*: DWORD
  MIXERCONTROLA_Bounds* {.pure, union.} = object
    struct1*: MIXERCONTROLA_Bounds_STRUCT1
    struct2*: MIXERCONTROLA_Bounds_STRUCT2
    dwReserved*: array[6, DWORD]
  MIXERCONTROLA_Metrics* {.pure, union.} = object
    cSteps*: DWORD
    cbCustomData*: DWORD
    dwReserved*: array[6, DWORD]
  MIXERCONTROLA* {.pure.} = object
    cbStruct*: DWORD
    dwControlID*: DWORD
    dwControlType*: DWORD
    fdwControl*: DWORD
    cMultipleItems*: DWORD
    szShortName*: array[MIXER_SHORT_NAME_CHARS, CHAR]
    szName*: array[MIXER_LONG_NAME_CHARS, CHAR]
    Bounds*: MIXERCONTROLA_Bounds
    Metrics*: MIXERCONTROLA_Metrics
  PMIXERCONTROLA* = ptr MIXERCONTROLA
  LPMIXERCONTROLA* = ptr MIXERCONTROLA
  MIXERCONTROLW_Bounds_STRUCT1* {.pure.} = object
    lMinimum*: LONG
    lMaximum*: LONG
  MIXERCONTROLW_Bounds_STRUCT2* {.pure.} = object
    dwMinimum*: DWORD
    dwMaximum*: DWORD
  MIXERCONTROLW_Bounds* {.pure, union.} = object
    struct1*: MIXERCONTROLW_Bounds_STRUCT1
    struct2*: MIXERCONTROLW_Bounds_STRUCT2
    dwReserved*: array[6, DWORD]
  MIXERCONTROLW_Metrics* {.pure, union.} = object
    cSteps*: DWORD
    cbCustomData*: DWORD
    dwReserved*: array[6, DWORD]
  MIXERCONTROLW* {.pure.} = object
    cbStruct*: DWORD
    dwControlID*: DWORD
    dwControlType*: DWORD
    fdwControl*: DWORD
    cMultipleItems*: DWORD
    szShortName*: array[MIXER_SHORT_NAME_CHARS, WCHAR]
    szName*: array[MIXER_LONG_NAME_CHARS, WCHAR]
    Bounds*: MIXERCONTROLW_Bounds
    Metrics*: MIXERCONTROLW_Metrics
  PMIXERCONTROLW* = ptr MIXERCONTROLW
  LPMIXERCONTROLW* = ptr MIXERCONTROLW
  MIXERLINECONTROLSA_UNION1* {.pure, union.} = object
    dwControlID*: DWORD
    dwControlType*: DWORD
  MIXERLINECONTROLSA* {.pure, packed.} = object
    cbStruct*: DWORD
    dwLineID*: DWORD
    union1*: MIXERLINECONTROLSA_UNION1
    cControls*: DWORD
    cbmxctrl*: DWORD
    pamxctrl*: LPMIXERCONTROLA
  PMIXERLINECONTROLSA* = ptr MIXERLINECONTROLSA
  LPMIXERLINECONTROLSA* = ptr MIXERLINECONTROLSA
  MIXERLINECONTROLSW_UNION1* {.pure, union.} = object
    dwControlID*: DWORD
    dwControlType*: DWORD
  MIXERLINECONTROLSW* {.pure, packed.} = object
    cbStruct*: DWORD
    dwLineID*: DWORD
    union1*: MIXERLINECONTROLSW_UNION1
    cControls*: DWORD
    cbmxctrl*: DWORD
    pamxctrl*: LPMIXERCONTROLW
  PMIXERLINECONTROLSW* = ptr MIXERLINECONTROLSW
  LPMIXERLINECONTROLSW* = ptr MIXERLINECONTROLSW
  MIXERCONTROLDETAILS_UNION1* {.pure, union.} = object
    hwndOwner*: HWND
    cMultipleItems*: DWORD
  MIXERCONTROLDETAILS* {.pure, packed.} = object
    cbStruct*: DWORD
    dwControlID*: DWORD
    cChannels*: DWORD
    union1*: MIXERCONTROLDETAILS_UNION1
    cbDetails*: DWORD
    paDetails*: LPVOID
  PMIXERCONTROLDETAILS* = ptr MIXERCONTROLDETAILS
  LPMIXERCONTROLDETAILS* = ptr MIXERCONTROLDETAILS
  MIXERCONTROLDETAILS_LISTTEXTA* {.pure.} = object
    dwParam1*: DWORD
    dwParam2*: DWORD
    szName*: array[MIXER_LONG_NAME_CHARS, CHAR]
  PMIXERCONTROLDETAILS_LISTTEXTA* = ptr MIXERCONTROLDETAILS_LISTTEXTA
  LPMIXERCONTROLDETAILS_LISTTEXTA* = ptr MIXERCONTROLDETAILS_LISTTEXTA
  MIXERCONTROLDETAILS_LISTTEXTW* {.pure.} = object
    dwParam1*: DWORD
    dwParam2*: DWORD
    szName*: array[MIXER_LONG_NAME_CHARS, WCHAR]
  PMIXERCONTROLDETAILS_LISTTEXTW* = ptr MIXERCONTROLDETAILS_LISTTEXTW
  LPMIXERCONTROLDETAILS_LISTTEXTW* = ptr MIXERCONTROLDETAILS_LISTTEXTW
  MIXERCONTROLDETAILS_BOOLEAN* {.pure.} = object
    fValue*: LONG
  PMIXERCONTROLDETAILS_BOOLEAN* = ptr MIXERCONTROLDETAILS_BOOLEAN
  LPMIXERCONTROLDETAILS_BOOLEAN* = ptr MIXERCONTROLDETAILS_BOOLEAN
  MIXERCONTROLDETAILS_SIGNED* {.pure.} = object
    lValue*: LONG
  PMIXERCONTROLDETAILS_SIGNED* = ptr MIXERCONTROLDETAILS_SIGNED
  LPMIXERCONTROLDETAILS_SIGNED* = ptr MIXERCONTROLDETAILS_SIGNED
  MIXERCONTROLDETAILS_UNSIGNED* {.pure.} = object
    dwValue*: DWORD
  PMIXERCONTROLDETAILS_UNSIGNED* = ptr MIXERCONTROLDETAILS_UNSIGNED
  LPMIXERCONTROLDETAILS_UNSIGNED* = ptr MIXERCONTROLDETAILS_UNSIGNED
  TIMECALLBACK* = proc (uTimerID: UINT, uMsg: UINT, dwUser: DWORD_PTR, dw1: DWORD_PTR, dw2: DWORD_PTR): void {.stdcall.}
  LPTIMECALLBACK* = ptr TIMECALLBACK
  TIMECAPS* {.pure.} = object
    wPeriodMin*: UINT
    wPeriodMax*: UINT
  PTIMECAPS* = ptr TIMECAPS
  NPTIMECAPS* = ptr TIMECAPS
  LPTIMECAPS* = ptr TIMECAPS
const
  MAX_JOYSTICKOEMVXDNAME* = 260
type
  JOYCAPSA* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    szPname*: array[MAXPNAMELEN, CHAR]
    wXmin*: UINT
    wXmax*: UINT
    wYmin*: UINT
    wYmax*: UINT
    wZmin*: UINT
    wZmax*: UINT
    wNumButtons*: UINT
    wPeriodMin*: UINT
    wPeriodMax*: UINT
    wRmin*: UINT
    wRmax*: UINT
    wUmin*: UINT
    wUmax*: UINT
    wVmin*: UINT
    wVmax*: UINT
    wCaps*: UINT
    wMaxAxes*: UINT
    wNumAxes*: UINT
    wMaxButtons*: UINT
    szRegKey*: array[MAXPNAMELEN, CHAR]
    szOEMVxD*: array[MAX_JOYSTICKOEMVXDNAME, CHAR]
  PJOYCAPSA* = ptr JOYCAPSA
  NPJOYCAPSA* = ptr JOYCAPSA
  LPJOYCAPSA* = ptr JOYCAPSA
  JOYCAPSW* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    szPname*: array[MAXPNAMELEN, WCHAR]
    wXmin*: UINT
    wXmax*: UINT
    wYmin*: UINT
    wYmax*: UINT
    wZmin*: UINT
    wZmax*: UINT
    wNumButtons*: UINT
    wPeriodMin*: UINT
    wPeriodMax*: UINT
    wRmin*: UINT
    wRmax*: UINT
    wUmin*: UINT
    wUmax*: UINT
    wVmin*: UINT
    wVmax*: UINT
    wCaps*: UINT
    wMaxAxes*: UINT
    wNumAxes*: UINT
    wMaxButtons*: UINT
    szRegKey*: array[MAXPNAMELEN, WCHAR]
    szOEMVxD*: array[MAX_JOYSTICKOEMVXDNAME, WCHAR]
  PJOYCAPSW* = ptr JOYCAPSW
  NPJOYCAPSW* = ptr JOYCAPSW
  LPJOYCAPSW* = ptr JOYCAPSW
  JOYCAPS2A* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    szPname*: array[MAXPNAMELEN, CHAR]
    wXmin*: UINT
    wXmax*: UINT
    wYmin*: UINT
    wYmax*: UINT
    wZmin*: UINT
    wZmax*: UINT
    wNumButtons*: UINT
    wPeriodMin*: UINT
    wPeriodMax*: UINT
    wRmin*: UINT
    wRmax*: UINT
    wUmin*: UINT
    wUmax*: UINT
    wVmin*: UINT
    wVmax*: UINT
    wCaps*: UINT
    wMaxAxes*: UINT
    wNumAxes*: UINT
    wMaxButtons*: UINT
    szRegKey*: array[MAXPNAMELEN, CHAR]
    szOEMVxD*: array[MAX_JOYSTICKOEMVXDNAME, CHAR]
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PJOYCAPS2A* = ptr JOYCAPS2A
  NPJOYCAPS2A* = ptr JOYCAPS2A
  LPJOYCAPS2A* = ptr JOYCAPS2A
  JOYCAPS2W* {.pure.} = object
    wMid*: WORD
    wPid*: WORD
    szPname*: array[MAXPNAMELEN, WCHAR]
    wXmin*: UINT
    wXmax*: UINT
    wYmin*: UINT
    wYmax*: UINT
    wZmin*: UINT
    wZmax*: UINT
    wNumButtons*: UINT
    wPeriodMin*: UINT
    wPeriodMax*: UINT
    wRmin*: UINT
    wRmax*: UINT
    wUmin*: UINT
    wUmax*: UINT
    wVmin*: UINT
    wVmax*: UINT
    wCaps*: UINT
    wMaxAxes*: UINT
    wNumAxes*: UINT
    wMaxButtons*: UINT
    szRegKey*: array[MAXPNAMELEN, WCHAR]
    szOEMVxD*: array[MAX_JOYSTICKOEMVXDNAME, WCHAR]
    ManufacturerGuid*: GUID
    ProductGuid*: GUID
    NameGuid*: GUID
  PJOYCAPS2W* = ptr JOYCAPS2W
  NPJOYCAPS2W* = ptr JOYCAPS2W
  LPJOYCAPS2W* = ptr JOYCAPS2W
  JOYINFO* {.pure.} = object
    wXpos*: UINT
    wYpos*: UINT
    wZpos*: UINT
    wButtons*: UINT
  PJOYINFO* = ptr JOYINFO
  NPJOYINFO* = ptr JOYINFO
  LPJOYINFO* = ptr JOYINFO
  JOYINFOEX* {.pure.} = object
    dwSize*: DWORD
    dwFlags*: DWORD
    dwXpos*: DWORD
    dwYpos*: DWORD
    dwZpos*: DWORD
    dwRpos*: DWORD
    dwUpos*: DWORD
    dwVpos*: DWORD
    dwButtons*: DWORD
    dwButtonNumber*: DWORD
    dwPOV*: DWORD
    dwReserved1*: DWORD
    dwReserved2*: DWORD
  PJOYINFOEX* = ptr JOYINFOEX
  NPJOYINFOEX* = ptr JOYINFOEX
  LPJOYINFOEX* = ptr JOYINFOEX
  MMIOPROC* = proc (lpmmioinfo: LPSTR, uMsg: UINT, lParam1: LPARAM, lParam2: LPARAM): LRESULT {.stdcall.}
  LPMMIOPROC* = ptr MMIOPROC
  MMIOINFO* {.pure, packed.} = object
    dwFlags*: DWORD
    fccIOProc*: FOURCC
    pIOProc*: LPMMIOPROC
    wErrorRet*: UINT
    htask*: HTASK
    cchBuffer*: LONG
    pchBuffer*: HPSTR
    pchNext*: HPSTR
    pchEndRead*: HPSTR
    pchEndWrite*: HPSTR
    lBufOffset*: LONG
    lDiskOffset*: LONG
    adwInfo*: array[3, DWORD]
    dwReserved1*: DWORD
    dwReserved2*: DWORD
    hmmio*: HMMIO
  PMMIOINFO* = ptr MMIOINFO
  NPMMIOINFO* = ptr MMIOINFO
  LPMMIOINFO* = ptr MMIOINFO
  LPCMMIOINFO* = ptr MMIOINFO
  MMCKINFO* {.pure.} = object
    ckid*: FOURCC
    cksize*: DWORD
    fccType*: FOURCC
    dwDataOffset*: DWORD
    dwFlags*: DWORD
  PMMCKINFO* = ptr MMCKINFO
  NPMMCKINFO* = ptr MMCKINFO
  LPMMCKINFO* = ptr MMCKINFO
  LPCMMCKINFO* = ptr MMCKINFO
  MCIDEVICEID* = UINT
  MCI_GENERIC_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
  PMCI_GENERIC_PARMS* = ptr MCI_GENERIC_PARMS
  LPMCI_GENERIC_PARMS* = ptr MCI_GENERIC_PARMS
  MCI_OPEN_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCSTR
    lpstrElementName*: LPCSTR
    lpstrAlias*: LPCSTR
  PMCI_OPEN_PARMSA* = ptr MCI_OPEN_PARMSA
  LPMCI_OPEN_PARMSA* = ptr MCI_OPEN_PARMSA
  MCI_OPEN_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCWSTR
    lpstrElementName*: LPCWSTR
    lpstrAlias*: LPCWSTR
  PMCI_OPEN_PARMSW* = ptr MCI_OPEN_PARMSW
  LPMCI_OPEN_PARMSW* = ptr MCI_OPEN_PARMSW
  MCI_PLAY_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwFrom*: DWORD
    dwTo*: DWORD
  PMCI_PLAY_PARMS* = ptr MCI_PLAY_PARMS
  LPMCI_PLAY_PARMS* = ptr MCI_PLAY_PARMS
  MCI_SEEK_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwTo*: DWORD
  PMCI_SEEK_PARMS* = ptr MCI_SEEK_PARMS
  LPMCI_SEEK_PARMS* = ptr MCI_SEEK_PARMS
  MCI_STATUS_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwReturn*: DWORD_PTR
    dwItem*: DWORD
    dwTrack*: DWORD
  PMCI_STATUS_PARMS* = ptr MCI_STATUS_PARMS
  LPMCI_STATUS_PARMS* = ptr MCI_STATUS_PARMS
  MCI_INFO_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    lpstrReturn*: LPSTR
    dwRetSize*: DWORD
  LPMCI_INFO_PARMSA* = ptr MCI_INFO_PARMSA
  MCI_INFO_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    lpstrReturn*: LPWSTR
    dwRetSize*: DWORD
  LPMCI_INFO_PARMSW* = ptr MCI_INFO_PARMSW
  MCI_GETDEVCAPS_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwReturn*: DWORD
    dwItem*: DWORD
  PMCI_GETDEVCAPS_PARMS* = ptr MCI_GETDEVCAPS_PARMS
  LPMCI_GETDEVCAPS_PARMS* = ptr MCI_GETDEVCAPS_PARMS
  MCI_SYSINFO_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    lpstrReturn*: LPSTR
    dwRetSize*: DWORD
    dwNumber*: DWORD
    wDeviceType*: UINT
  PMCI_SYSINFO_PARMSA* = ptr MCI_SYSINFO_PARMSA
  LPMCI_SYSINFO_PARMSA* = ptr MCI_SYSINFO_PARMSA
  MCI_SYSINFO_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    lpstrReturn*: LPWSTR
    dwRetSize*: DWORD
    dwNumber*: DWORD
    wDeviceType*: UINT
  PMCI_SYSINFO_PARMSW* = ptr MCI_SYSINFO_PARMSW
  LPMCI_SYSINFO_PARMSW* = ptr MCI_SYSINFO_PARMSW
  MCI_SET_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwTimeFormat*: DWORD
    dwAudio*: DWORD
  PMCI_SET_PARMS* = ptr MCI_SET_PARMS
  LPMCI_SET_PARMS* = ptr MCI_SET_PARMS
  MCI_BREAK_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    nVirtKey*: int32
    hwndBreak*: HWND
  PMCI_BREAK_PARMS* = ptr MCI_BREAK_PARMS
  LPMCI_BREAK_PARMS* = ptr MCI_BREAK_PARMS
  MCI_SAVE_PARMSA* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCSTR
  PMCI_SAVE_PARMSA* = ptr MCI_SAVE_PARMSA
  LPMCI_SAVE_PARMSA* = ptr MCI_SAVE_PARMSA
  MCI_SAVE_PARMSW* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCWSTR
  PMCI_SAVE_PARMSW* = ptr MCI_SAVE_PARMSW
  LPMCI_SAVE_PARMSW* = ptr MCI_SAVE_PARMSW
  MCI_LOAD_PARMSA* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCSTR
  PMCI_LOAD_PARMSA* = ptr MCI_LOAD_PARMSA
  LPMCI_LOAD_PARMSA* = ptr MCI_LOAD_PARMSA
  MCI_LOAD_PARMSW* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCWSTR
  PMCI_LOAD_PARMSW* = ptr MCI_LOAD_PARMSW
  LPMCI_LOAD_PARMSW* = ptr MCI_LOAD_PARMSW
  MCI_RECORD_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwFrom*: DWORD
    dwTo*: DWORD
  LPMCI_RECORD_PARMS* = ptr MCI_RECORD_PARMS
  MCI_VD_PLAY_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwFrom*: DWORD
    dwTo*: DWORD
    dwSpeed*: DWORD
  PMCI_VD_PLAY_PARMS* = ptr MCI_VD_PLAY_PARMS
  LPMCI_VD_PLAY_PARMS* = ptr MCI_VD_PLAY_PARMS
  MCI_VD_STEP_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwFrames*: DWORD
  PMCI_VD_STEP_PARMS* = ptr MCI_VD_STEP_PARMS
  LPMCI_VD_STEP_PARMS* = ptr MCI_VD_STEP_PARMS
  MCI_VD_ESCAPE_PARMSA* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpstrCommand*: LPCSTR
  PMCI_VD_ESCAPE_PARMSA* = ptr MCI_VD_ESCAPE_PARMSA
  LPMCI_VD_ESCAPE_PARMSA* = ptr MCI_VD_ESCAPE_PARMSA
  MCI_VD_ESCAPE_PARMSW* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpstrCommand*: LPCWSTR
  PMCI_VD_ESCAPE_PARMSW* = ptr MCI_VD_ESCAPE_PARMSW
  LPMCI_VD_ESCAPE_PARMSW* = ptr MCI_VD_ESCAPE_PARMSW
  MCI_WAVE_OPEN_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCSTR
    lpstrElementName*: LPCSTR
    lpstrAlias*: LPCSTR
    dwBufferSeconds*: DWORD
  PMCI_WAVE_OPEN_PARMSA* = ptr MCI_WAVE_OPEN_PARMSA
  LPMCI_WAVE_OPEN_PARMSA* = ptr MCI_WAVE_OPEN_PARMSA
  MCI_WAVE_OPEN_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCWSTR
    lpstrElementName*: LPCWSTR
    lpstrAlias*: LPCWSTR
    dwBufferSeconds*: DWORD
  PMCI_WAVE_OPEN_PARMSW* = ptr MCI_WAVE_OPEN_PARMSW
  LPMCI_WAVE_OPEN_PARMSW* = ptr MCI_WAVE_OPEN_PARMSW
  MCI_WAVE_DELETE_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwFrom*: DWORD
    dwTo*: DWORD
  PMCI_WAVE_DELETE_PARMS* = ptr MCI_WAVE_DELETE_PARMS
  LPMCI_WAVE_DELETE_PARMS* = ptr MCI_WAVE_DELETE_PARMS
  MCI_WAVE_SET_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    dwTimeFormat*: DWORD
    dwAudio*: DWORD
    wInput*: UINT
    wOutput*: UINT
    wFormatTag*: WORD
    wReserved2*: WORD
    nChannels*: WORD
    wReserved3*: WORD
    nSamplesPerSec*: DWORD
    nAvgBytesPerSec*: DWORD
    nBlockAlign*: WORD
    wReserved4*: WORD
    wBitsPerSample*: WORD
    wReserved5*: WORD
  PMCI_WAVE_SET_PARMS* = ptr MCI_WAVE_SET_PARMS
  LPMCI_WAVE_SET_PARMS* = ptr MCI_WAVE_SET_PARMS
  MCI_SEQ_SET_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwTimeFormat*: DWORD
    dwAudio*: DWORD
    dwTempo*: DWORD
    dwPort*: DWORD
    dwSlave*: DWORD
    dwMaster*: DWORD
    dwOffset*: DWORD
  PMCI_SEQ_SET_PARMS* = ptr MCI_SEQ_SET_PARMS
  LPMCI_SEQ_SET_PARMS* = ptr MCI_SEQ_SET_PARMS
  MCI_ANIM_OPEN_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCSTR
    lpstrElementName*: LPCSTR
    lpstrAlias*: LPCSTR
    dwStyle*: DWORD
    hWndParent*: HWND
  PMCI_ANIM_OPEN_PARMSA* = ptr MCI_ANIM_OPEN_PARMSA
  LPMCI_ANIM_OPEN_PARMSA* = ptr MCI_ANIM_OPEN_PARMSA
  MCI_ANIM_OPEN_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCWSTR
    lpstrElementName*: LPCWSTR
    lpstrAlias*: LPCWSTR
    dwStyle*: DWORD
    hWndParent*: HWND
  PMCI_ANIM_OPEN_PARMSW* = ptr MCI_ANIM_OPEN_PARMSW
  LPMCI_ANIM_OPEN_PARMSW* = ptr MCI_ANIM_OPEN_PARMSW
  MCI_ANIM_PLAY_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwFrom*: DWORD
    dwTo*: DWORD
    dwSpeed*: DWORD
  PMCI_ANIM_PLAY_PARMS* = ptr MCI_ANIM_PLAY_PARMS
  LPMCI_ANIM_PLAY_PARMS* = ptr MCI_ANIM_PLAY_PARMS
  MCI_ANIM_STEP_PARMS* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    dwFrames*: DWORD
  PMCI_ANIM_STEP_PARMS* = ptr MCI_ANIM_STEP_PARMS
  LPMCI_ANIM_STEP_PARMS* = ptr MCI_ANIM_STEP_PARMS
  MCI_ANIM_WINDOW_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    hWnd*: HWND
    nCmdShow*: UINT
    lpstrText*: LPCSTR
  PMCI_ANIM_WINDOW_PARMSA* = ptr MCI_ANIM_WINDOW_PARMSA
  LPMCI_ANIM_WINDOW_PARMSA* = ptr MCI_ANIM_WINDOW_PARMSA
  MCI_ANIM_WINDOW_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    hWnd*: HWND
    nCmdShow*: UINT
    lpstrText*: LPCWSTR
  PMCI_ANIM_WINDOW_PARMSW* = ptr MCI_ANIM_WINDOW_PARMSW
  LPMCI_ANIM_WINDOW_PARMSW* = ptr MCI_ANIM_WINDOW_PARMSW
  MCI_ANIM_RECT_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    rc*: RECT
  PMCI_ANIM_RECT_PARMS* = ptr MCI_ANIM_RECT_PARMS
  LPMCI_ANIM_RECT_PARMS* = ptr MCI_ANIM_RECT_PARMS
  MCI_ANIM_UPDATE_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    rc*: RECT
    hDC*: HDC
  PMCI_ANIM_UPDATE_PARMS* = ptr MCI_ANIM_UPDATE_PARMS
  LPMCI_ANIM_UPDATE_PARMS* = ptr MCI_ANIM_UPDATE_PARMS
  MCI_OVLY_OPEN_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCSTR
    lpstrElementName*: LPCSTR
    lpstrAlias*: LPCSTR
    dwStyle*: DWORD
    hWndParent*: HWND
  PMCI_OVLY_OPEN_PARMSA* = ptr MCI_OVLY_OPEN_PARMSA
  LPMCI_OVLY_OPEN_PARMSA* = ptr MCI_OVLY_OPEN_PARMSA
  MCI_OVLY_OPEN_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    wDeviceID*: MCIDEVICEID
    lpstrDeviceType*: LPCWSTR
    lpstrElementName*: LPCWSTR
    lpstrAlias*: LPCWSTR
    dwStyle*: DWORD
    hWndParent*: HWND
  PMCI_OVLY_OPEN_PARMSW* = ptr MCI_OVLY_OPEN_PARMSW
  LPMCI_OVLY_OPEN_PARMSW* = ptr MCI_OVLY_OPEN_PARMSW
  MCI_OVLY_WINDOW_PARMSA* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    hWnd*: HWND
    nCmdShow*: UINT
    lpstrText*: LPCSTR
  PMCI_OVLY_WINDOW_PARMSA* = ptr MCI_OVLY_WINDOW_PARMSA
  LPMCI_OVLY_WINDOW_PARMSA* = ptr MCI_OVLY_WINDOW_PARMSA
  MCI_OVLY_WINDOW_PARMSW* {.pure, packed.} = object
    dwCallback*: DWORD_PTR
    hWnd*: HWND
    nCmdShow*: UINT
    lpstrText*: LPCWSTR
  PMCI_OVLY_WINDOW_PARMSW* = ptr MCI_OVLY_WINDOW_PARMSW
  LPMCI_OVLY_WINDOW_PARMSW* = ptr MCI_OVLY_WINDOW_PARMSW
  MCI_OVLY_RECT_PARMS* {.pure.} = object
    dwCallback*: DWORD_PTR
    rc*: RECT
  PMCI_OVLY_RECT_PARMS* = ptr MCI_OVLY_RECT_PARMS
  LPMCI_OVLY_RECT_PARMS* = ptr MCI_OVLY_RECT_PARMS
  MCI_OVLY_SAVE_PARMSA* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCSTR
    rc*: RECT
  PMCI_OVLY_SAVE_PARMSA* = ptr MCI_OVLY_SAVE_PARMSA
  LPMCI_OVLY_SAVE_PARMSA* = ptr MCI_OVLY_SAVE_PARMSA
  MCI_OVLY_SAVE_PARMSW* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCWSTR
    rc*: RECT
  PMCI_OVLY_SAVE_PARMSW* = ptr MCI_OVLY_SAVE_PARMSW
  LPMCI_OVLY_SAVE_PARMSW* = ptr MCI_OVLY_SAVE_PARMSW
  MCI_OVLY_LOAD_PARMSA* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCSTR
    rc*: RECT
  PMCI_OVLY_LOAD_PARMSA* = ptr MCI_OVLY_LOAD_PARMSA
  LPMCI_OVLY_LOAD_PARMSA* = ptr MCI_OVLY_LOAD_PARMSA
  MCI_OVLY_LOAD_PARMSW* {.pure.} = object
    dwCallback*: DWORD_PTR
    lpfilename*: LPCWSTR
    rc*: RECT
  PMCI_OVLY_LOAD_PARMSW* = ptr MCI_OVLY_LOAD_PARMSW
  LPMCI_OVLY_LOAD_PARMSW* = ptr MCI_OVLY_LOAD_PARMSW
  WAVEFORMATEXTENSIBLE_Samples* {.pure, union.} = object
    wValidBitsPerSample*: WORD
    wSamplesPerBlock*: WORD
    wReserved*: WORD
  TWAVEFORMATEXTENSIBLE* {.pure, packed.} = object
    Format*: WAVEFORMATEX
    Samples*: WAVEFORMATEXTENSIBLE_Samples
    dwChannelMask*: DWORD
    SubFormat*: GUID
  PWAVEFORMATEXTENSIBLE* = ptr TWAVEFORMATEXTENSIBLE
  WAVEFORMATPCMEX* = TWAVEFORMATEXTENSIBLE
  PWAVEFORMATPCMEX* = ptr WAVEFORMATPCMEX
  NPWAVEFORMATPCMEX* = ptr WAVEFORMATPCMEX
  LPWAVEFORMATPCMEX* = ptr WAVEFORMATPCMEX
  WAVEFORMATIEEEFLOATEX* = TWAVEFORMATEXTENSIBLE
  PWAVEFORMATIEEEFLOATEX* = ptr WAVEFORMATIEEEFLOATEX
  NPWAVEFORMATIEEEFLOATEX* = ptr WAVEFORMATIEEEFLOATEX
  LPWAVEFORMATIEEEFLOATEX* = ptr WAVEFORMATIEEEFLOATEX
  ADPCMCOEFSET* {.pure.} = object
    iCoef1*: int16
    iCoef2*: int16
  PADPCMCOEFSET* = ptr ADPCMCOEFSET
  NPADPCMCOEFSET* = ptr ADPCMCOEFSET
  LPADPCMCOEFSET* = ptr ADPCMCOEFSET
  ADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
    wNumCoef*: WORD
    aCoef*: UncheckedArray[ADPCMCOEFSET]
  PADPCMWAVEFORMAT* = ptr ADPCMWAVEFORMAT
  NPADPCMWAVEFORMAT* = ptr ADPCMWAVEFORMAT
  LPADPCMWAVEFORMAT* = ptr ADPCMWAVEFORMAT
  DRMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wReserved*: WORD
    ulContentId*: ULONG
    wfxSecure*: WAVEFORMATEX
  PDRMWAVEFORMAT* = ptr DRMWAVEFORMAT
  NPDRMWAVEFORMAT* = ptr DRMWAVEFORMAT
  LPDRMWAVEFORMAT* = ptr DRMWAVEFORMAT
  DVIADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PDVIADPCMWAVEFORMAT* = ptr DVIADPCMWAVEFORMAT
  NPDVIADPCMWAVEFORMAT* = ptr DVIADPCMWAVEFORMAT
  LPDVIADPCMWAVEFORMAT* = ptr DVIADPCMWAVEFORMAT
  IMAADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PIMAADPCMWAVEFORMAT* = ptr IMAADPCMWAVEFORMAT
  NPIMAADPCMWAVEFORMAT* = ptr IMAADPCMWAVEFORMAT
  LPIMAADPCMWAVEFORMAT* = ptr IMAADPCMWAVEFORMAT
  MEDIASPACEADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PMEDIASPACEADPCMWAVEFORMAT* = ptr MEDIASPACEADPCMWAVEFORMAT
  NPMEDIASPACEADPCMWAVEFORMAT* = ptr MEDIASPACEADPCMWAVEFORMAT
  LPMEDIASPACEADPCMWAVEFORMAT* = ptr MEDIASPACEADPCMWAVEFORMAT
  SIERRAADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PSIERRAADPCMWAVEFORMAT* = ptr SIERRAADPCMWAVEFORMAT
  NPSIERRAADPCMWAVEFORMAT* = ptr SIERRAADPCMWAVEFORMAT
  LPSIERRAADPCMWAVEFORMAT* = ptr SIERRAADPCMWAVEFORMAT
  G723_ADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    cbExtraSize*: WORD
    nAuxBlockSize*: WORD
  PG723_ADPCMWAVEFORMAT* = ptr G723_ADPCMWAVEFORMAT
  NPG723_ADPCMWAVEFORMAT* = ptr G723_ADPCMWAVEFORMAT
  LPG723_ADPCMWAVEFORMAT* = ptr G723_ADPCMWAVEFORMAT
  DIGISTDWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PDIGISTDWAVEFORMAT* = ptr DIGISTDWAVEFORMAT
  NPDIGISTDWAVEFORMAT* = ptr DIGISTDWAVEFORMAT
  LPDIGISTDWAVEFORMAT* = ptr DIGISTDWAVEFORMAT
  DIGIFIXWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PDIGIFIXWAVEFORMAT* = ptr DIGIFIXWAVEFORMAT
  NPDIGIFIXWAVEFORMAT* = ptr DIGIFIXWAVEFORMAT
  LPDIGIFIXWAVEFORMAT* = ptr DIGIFIXWAVEFORMAT
  DIALOGICOKIADPCMWAVEFORMAT* {.pure, packed.} = object
    ewf*: WAVEFORMATEX
  PDIALOGICOKIADPCMWAVEFORMAT* = ptr DIALOGICOKIADPCMWAVEFORMAT
  NPDIALOGICOKIADPCMWAVEFORMAT* = ptr DIALOGICOKIADPCMWAVEFORMAT
  LPDIALOGICOKIADPCMWAVEFORMAT* = ptr DIALOGICOKIADPCMWAVEFORMAT
  YAMAHA_ADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PYAMAHA_ADPCMWAVEFORMAT* = ptr YAMAHA_ADPCMWAVEFORMAT
  NPYAMAHA_ADPCMWAVEFORMAT* = ptr YAMAHA_ADPCMWAVEFORMAT
  LPYAMAHA_ADPCMWAVEFORMAT* = ptr YAMAHA_ADPCMWAVEFORMAT
  SONARCWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wCompType*: WORD
  PSONARCWAVEFORMAT* = ptr SONARCWAVEFORMAT
  NPSONARCWAVEFORMAT* = ptr SONARCWAVEFORMAT
  LPSONARCWAVEFORMAT* = ptr SONARCWAVEFORMAT
  TRUESPEECHWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
    nSamplesPerBlock*: WORD
    abReserved*: array[28, BYTE]
  PTRUESPEECHWAVEFORMAT* = ptr TRUESPEECHWAVEFORMAT
  NPTRUESPEECHWAVEFORMAT* = ptr TRUESPEECHWAVEFORMAT
  LPTRUESPEECHWAVEFORMAT* = ptr TRUESPEECHWAVEFORMAT
  ECHOSC1WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PECHOSC1WAVEFORMAT* = ptr ECHOSC1WAVEFORMAT
  NPECHOSC1WAVEFORMAT* = ptr ECHOSC1WAVEFORMAT
  LPECHOSC1WAVEFORMAT* = ptr ECHOSC1WAVEFORMAT
  AUDIOFILE_AF36WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PAUDIOFILE_AF36WAVEFORMAT* = ptr AUDIOFILE_AF36WAVEFORMAT
  NPAUDIOFILE_AF36WAVEFORMAT* = ptr AUDIOFILE_AF36WAVEFORMAT
  LPAUDIOFILE_AF36WAVEFORMAT* = ptr AUDIOFILE_AF36WAVEFORMAT
  APTXWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PAPTXWAVEFORMAT* = ptr APTXWAVEFORMAT
  NPAPTXWAVEFORMAT* = ptr APTXWAVEFORMAT
  LPAPTXWAVEFORMAT* = ptr APTXWAVEFORMAT
  AUDIOFILE_AF10WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PAUDIOFILE_AF10WAVEFORMAT* = ptr AUDIOFILE_AF10WAVEFORMAT
  NPAUDIOFILE_AF10WAVEFORMAT* = ptr AUDIOFILE_AF10WAVEFORMAT
  LPAUDIOFILE_AF10WAVEFORMAT* = ptr AUDIOFILE_AF10WAVEFORMAT
  GSM610WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PGSM610WAVEFORMAT* = ptr GSM610WAVEFORMAT
  NPGSM610WAVEFORMAT* = ptr GSM610WAVEFORMAT
  LPGSM610WAVEFORMAT* = ptr GSM610WAVEFORMAT
  ADPCMEWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PADPCMEWAVEFORMAT* = ptr ADPCMEWAVEFORMAT
  NPADPCMEWAVEFORMAT* = ptr ADPCMEWAVEFORMAT
  LPADPCMEWAVEFORMAT* = ptr ADPCMEWAVEFORMAT
  CONTRESVQLPCWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PCONTRESVQLPCWAVEFORMAT* = ptr CONTRESVQLPCWAVEFORMAT
  NPCONTRESVQLPCWAVEFORMAT* = ptr CONTRESVQLPCWAVEFORMAT
  LPCONTRESVQLPCWAVEFORMAT* = ptr CONTRESVQLPCWAVEFORMAT
  DIGIREALWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PDIGIREALWAVEFORMAT* = ptr DIGIREALWAVEFORMAT
  NPDIGIREALWAVEFORMAT* = ptr DIGIREALWAVEFORMAT
  LPDIGIREALWAVEFORMAT* = ptr DIGIREALWAVEFORMAT
  DIGIADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PDIGIADPCMWAVEFORMAT* = ptr DIGIADPCMWAVEFORMAT
  NPDIGIADPCMWAVEFORMAT* = ptr DIGIADPCMWAVEFORMAT
  LPDIGIADPCMWAVEFORMAT* = ptr DIGIADPCMWAVEFORMAT
  CONTRESCR10WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PCONTRESCR10WAVEFORMAT* = ptr CONTRESCR10WAVEFORMAT
  NPCONTRESCR10WAVEFORMAT* = ptr CONTRESCR10WAVEFORMAT
  LPCONTRESCR10WAVEFORMAT* = ptr CONTRESCR10WAVEFORMAT
  NMS_VBXADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
  PNMS_VBXADPCMWAVEFORMAT* = ptr NMS_VBXADPCMWAVEFORMAT
  NPNMS_VBXADPCMWAVEFORMAT* = ptr NMS_VBXADPCMWAVEFORMAT
  LPNMS_VBXADPCMWAVEFORMAT* = ptr NMS_VBXADPCMWAVEFORMAT
  G721_ADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    nAuxBlockSize*: WORD
  PG721_ADPCMWAVEFORMAT* = ptr G721_ADPCMWAVEFORMAT
  NPG721_ADPCMWAVEFORMAT* = ptr G721_ADPCMWAVEFORMAT
  LPG721_ADPCMWAVEFORMAT* = ptr G721_ADPCMWAVEFORMAT
  MPEG1WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    fwHeadLayer*: WORD
    dwHeadBitrate*: DWORD
    fwHeadMode*: WORD
    fwHeadModeExt*: WORD
    wHeadEmphasis*: WORD
    fwHeadFlags*: WORD
    dwPTSLow*: DWORD
    dwPTSHigh*: DWORD
  PMPEG1WAVEFORMAT* = ptr MPEG1WAVEFORMAT
  NPMPEG1WAVEFORMAT* = ptr MPEG1WAVEFORMAT
  LPMPEG1WAVEFORMAT* = ptr MPEG1WAVEFORMAT
  MPEGLAYER3WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wID*: WORD
    fdwFlags*: DWORD
    nBlockSize*: WORD
    nFramesPerBlock*: WORD
    nCodecDelay*: WORD
  PMPEGLAYER3WAVEFORMAT* = ptr MPEGLAYER3WAVEFORMAT
  NPMPEGLAYER3WAVEFORMAT* = ptr MPEGLAYER3WAVEFORMAT
  LPMPEGLAYER3WAVEFORMAT* = ptr MPEGLAYER3WAVEFORMAT
  HEAACWAVEINFO* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wPayloadType*: WORD
    wAudioProfileLevelIndication*: WORD
    wStructType*: WORD
    wReserved1*: WORD
    dwReserved2*: DWORD
  PHEAACWAVEINFO* = ptr HEAACWAVEINFO
  NPHEAACWAVEINFO* = ptr HEAACWAVEINFO
  LPHEAACWAVEINFO* = ptr HEAACWAVEINFO
  HEAACWAVEFORMAT* {.pure, packed.} = object
    wfInfo*: HEAACWAVEINFO
    pbAudioSpecificConfig*: array[1, BYTE]
  PHEAACWAVEFORMAT* = ptr HEAACWAVEFORMAT
  NPHEAACWAVEFORMAT* = ptr HEAACWAVEFORMAT
  LPHEAACWAVEFORMAT* = ptr HEAACWAVEFORMAT
  MSAUDIO1WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wSamplesPerBlock*: WORD
    wEncodeOptions*: WORD
  LPMSAUDIO1WAVEFORMAT* = ptr MSAUDIO1WAVEFORMAT
  WMAUDIO2WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    dwSamplesPerBlock*: DWORD
    wEncodeOptions*: WORD
    dwSuperBlockAlign*: DWORD
  LPWMAUDIO2WAVEFORMAT* = ptr WMAUDIO2WAVEFORMAT
  WMAUDIO3WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wValidBitsPerSample*: WORD
    dwChannelMask*: DWORD
    dwReserved1*: DWORD
    dwReserved2*: DWORD
    wEncodeOptions*: WORD
    wReserved3*: WORD
  LPWMAUDIO3WAVEFORMAT* = ptr WMAUDIO3WAVEFORMAT
  CREATIVEADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PCREATIVEADPCMWAVEFORMAT* = ptr CREATIVEADPCMWAVEFORMAT
  NPCREATIVEADPCMWAVEFORMAT* = ptr CREATIVEADPCMWAVEFORMAT
  LPCREATIVEADPCMWAVEFORMAT* = ptr CREATIVEADPCMWAVEFORMAT
  CREATIVEFASTSPEECH8WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PCREATIVEFASTSPEECH8WAVEFORMAT* = ptr CREATIVEFASTSPEECH8WAVEFORMAT
  NPCREATIVEFASTSPEECH8WAVEFORMAT* = ptr CREATIVEFASTSPEECH8WAVEFORMAT
  LPCREATIVEFASTSPEECH8WAVEFORMAT* = ptr CREATIVEFASTSPEECH8WAVEFORMAT
  CREATIVEFASTSPEECH10WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PCREATIVEFASTSPEECH10WAVEFORMAT* = ptr CREATIVEFASTSPEECH10WAVEFORMAT
  NPCREATIVEFASTSPEECH10WAVEFORMAT* = ptr CREATIVEFASTSPEECH10WAVEFORMAT
  LPCREATIVEFASTSPEECH10WAVEFORMAT* = ptr CREATIVEFASTSPEECH10WAVEFORMAT
  FMTOWNS_SND_WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    wRevision*: WORD
  PFMTOWNS_SND_WAVEFORMAT* = ptr FMTOWNS_SND_WAVEFORMAT
  NPFMTOWNS_SND_WAVEFORMAT* = ptr FMTOWNS_SND_WAVEFORMAT
  LPFMTOWNS_SND_WAVEFORMAT* = ptr FMTOWNS_SND_WAVEFORMAT
  OLIGSMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  POLIGSMWAVEFORMAT* = ptr OLIGSMWAVEFORMAT
  NPOLIGSMWAVEFORMAT* = ptr OLIGSMWAVEFORMAT
  LPOLIGSMWAVEFORMAT* = ptr OLIGSMWAVEFORMAT
  OLIADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  POLIADPCMWAVEFORMAT* = ptr OLIADPCMWAVEFORMAT
  NPOLIADPCMWAVEFORMAT* = ptr OLIADPCMWAVEFORMAT
  LPOLIADPCMWAVEFORMAT* = ptr OLIADPCMWAVEFORMAT
  OLICELPWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  POLICELPWAVEFORMAT* = ptr OLICELPWAVEFORMAT
  NPOLICELPWAVEFORMAT* = ptr OLICELPWAVEFORMAT
  LPOLICELPWAVEFORMAT* = ptr OLICELPWAVEFORMAT
  OLISBCWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  POLISBCWAVEFORMAT* = ptr OLISBCWAVEFORMAT
  NPOLISBCWAVEFORMAT* = ptr OLISBCWAVEFORMAT
  LPOLISBCWAVEFORMAT* = ptr OLISBCWAVEFORMAT
  OLIOPRWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  POLIOPRWAVEFORMAT* = ptr OLIOPRWAVEFORMAT
  NPOLIOPRWAVEFORMAT* = ptr OLIOPRWAVEFORMAT
  LPOLIOPRWAVEFORMAT* = ptr OLIOPRWAVEFORMAT
  CSIMAADPCMWAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
  PCSIMAADPCMWAVEFORMAT* = ptr CSIMAADPCMWAVEFORMAT
  NPCSIMAADPCMWAVEFORMAT* = ptr CSIMAADPCMWAVEFORMAT
  LPCSIMAADPCMWAVEFORMAT* = ptr CSIMAADPCMWAVEFORMAT
  WAVEFILTER* {.pure.} = object
    cbStruct*: DWORD
    dwFilterTag*: DWORD
    fdwFilter*: DWORD
    dwReserved*: array[5, DWORD]
  PWAVEFILTER* = ptr WAVEFILTER
  NPWAVEFILTER* = ptr WAVEFILTER
  LPWAVEFILTER* = ptr WAVEFILTER
  VOLUMEWAVEFILTER* {.pure.} = object
    wfltr*: WAVEFILTER
    dwVolume*: DWORD
  PVOLUMEWAVEFILTER* = ptr VOLUMEWAVEFILTER
  NPVOLUMEWAVEFILTER* = ptr VOLUMEWAVEFILTER
  LPVOLUMEWAVEFILTER* = ptr VOLUMEWAVEFILTER
  ECHOWAVEFILTER* {.pure.} = object
    wfltr*: WAVEFILTER
    dwVolume*: DWORD
    dwDelay*: DWORD
  PECHOWAVEFILTER* = ptr ECHOWAVEFILTER
  NPECHOWAVEFILTER* = ptr ECHOWAVEFILTER
  LPECHOWAVEFILTER* = ptr ECHOWAVEFILTER
const
  MAXERRORLENGTH* = 256
  TIME_MS* = 0x0001
  TIME_SAMPLES* = 0x0002
  TIME_BYTES* = 0x0004
  TIME_SMPTE* = 0x0008
  TIME_MIDI* = 0x0010
  TIME_TICKS* = 0x0020
  MM_JOY1MOVE* = 0x3A0
  MM_JOY2MOVE* = 0x3A1
  MM_JOY1ZMOVE* = 0x3A2
  MM_JOY2ZMOVE* = 0x3A3
  MM_JOY1BUTTONDOWN* = 0x3B5
  MM_JOY2BUTTONDOWN* = 0x3B6
  MM_JOY1BUTTONUP* = 0x3B7
  MM_JOY2BUTTONUP* = 0x3B8
  MM_MCINOTIFY* = 0x3B9
  MM_WOM_OPEN* = 0x3BB
  MM_WOM_CLOSE* = 0x3BC
  MM_WOM_DONE* = 0x3BD
  MM_WIM_OPEN* = 0x3BE
  MM_WIM_CLOSE* = 0x3BF
  MM_WIM_DATA* = 0x3C0
  MM_MIM_OPEN* = 0x3C1
  MM_MIM_CLOSE* = 0x3C2
  MM_MIM_DATA* = 0x3C3
  MM_MIM_LONGDATA* = 0x3C4
  MM_MIM_ERROR* = 0x3C5
  MM_MIM_LONGERROR* = 0x3C6
  MM_MOM_OPEN* = 0x3C7
  MM_MOM_CLOSE* = 0x3C8
  MM_MOM_DONE* = 0x3C9
  MM_DRVM_OPEN* = 0x3D0
  MM_DRVM_CLOSE* = 0x3D1
  MM_DRVM_DATA* = 0x3D2
  MM_DRVM_ERROR* = 0x3D3
  MM_STREAM_OPEN* = 0x3D4
  MM_STREAM_CLOSE* = 0x3D5
  MM_STREAM_DONE* = 0x3D6
  MM_STREAM_ERROR* = 0x3D7
  MM_MOM_POSITIONCB* = 0x3CA
  MM_MCISIGNAL* = 0x3CB
  MM_MIM_MOREDATA* = 0x3CC
  MM_MIXM_LINE_CHANGE* = 0x3D0
  MM_MIXM_CONTROL_CHANGE* = 0x3D1
  MMSYSERR_BASE* = 0
  WAVERR_BASE* = 32
  MIDIERR_BASE* = 64
  TIMERR_BASE* = 96
  JOYERR_BASE* = 160
  MCIERR_BASE* = 256
  MIXERR_BASE* = 1024
  MCI_STRING_OFFSET* = 512
  MCI_VD_OFFSET* = 1024
  MCI_CD_OFFSET* = 1088
  MCI_WAVE_OFFSET* = 1152
  MCI_SEQ_OFFSET* = 1216
  MMSYSERR_NOERROR* = 0
  MMSYSERR_ERROR* = MMSYSERR_BASE+1
  MMSYSERR_BADDEVICEID* = MMSYSERR_BASE+2
  MMSYSERR_NOTENABLED* = MMSYSERR_BASE+3
  MMSYSERR_ALLOCATED* = MMSYSERR_BASE+4
  MMSYSERR_INVALHANDLE* = MMSYSERR_BASE+5
  MMSYSERR_NODRIVER* = MMSYSERR_BASE+6
  MMSYSERR_NOMEM* = MMSYSERR_BASE+7
  MMSYSERR_NOTSUPPORTED* = MMSYSERR_BASE+8
  MMSYSERR_BADERRNUM* = MMSYSERR_BASE+9
  MMSYSERR_INVALFLAG* = MMSYSERR_BASE+10
  MMSYSERR_INVALPARAM* = MMSYSERR_BASE+11
  MMSYSERR_HANDLEBUSY* = MMSYSERR_BASE+12
  MMSYSERR_INVALIDALIAS* = MMSYSERR_BASE+13
  MMSYSERR_BADDB* = MMSYSERR_BASE+14
  MMSYSERR_KEYNOTFOUND* = MMSYSERR_BASE+15
  MMSYSERR_READERROR* = MMSYSERR_BASE+16
  MMSYSERR_WRITEERROR* = MMSYSERR_BASE+17
  MMSYSERR_DELETEERROR* = MMSYSERR_BASE+18
  MMSYSERR_VALNOTFOUND* = MMSYSERR_BASE+19
  MMSYSERR_NODRIVERCB* = MMSYSERR_BASE+20
  MMSYSERR_MOREDATA* = MMSYSERR_BASE+21
  MMSYSERR_LASTERROR* = MMSYSERR_BASE+21
  DRV_LOAD* = 0x0001
  DRV_ENABLE* = 0x0002
  DRV_OPEN* = 0x0003
  DRV_CLOSE* = 0x0004
  DRV_DISABLE* = 0x0005
  DRV_FREE* = 0x0006
  DRV_CONFIGURE* = 0x0007
  DRV_QUERYCONFIGURE* = 0x0008
  DRV_INSTALL* = 0x0009
  DRV_REMOVE* = 0x000A
  DRV_EXITSESSION* = 0x000B
  DRV_POWER* = 0x000F
  DRV_RESERVED* = 0x0800
  DRV_USER* = 0x4000
  DRVCNF_CANCEL* = 0x0000
  DRVCNF_OK* = 0x0001
  DRVCNF_RESTART* = 0x0002
  DRV_CANCEL* = DRVCNF_CANCEL
  DRV_OK* = DRVCNF_OK
  DRV_RESTART* = DRVCNF_RESTART
  DRV_MCI_FIRST* = DRV_RESERVED
  DRV_MCI_LAST* = DRV_RESERVED+0xFFF
  CALLBACK_TYPEMASK* = 0x00070000
  CALLBACK_NULL* = 0x00000000
  CALLBACK_WINDOW* = 0x00010000
  CALLBACK_TASK* = 0x00020000
  CALLBACK_FUNCTION* = 0x00030000
  CALLBACK_THREAD* = CALLBACK_TASK
  CALLBACK_EVENT* = 0x00050000
  SND_SYNC* = 0x0000
  SND_ASYNC* = 0x0001
  SND_NODEFAULT* = 0x0002
  SND_MEMORY* = 0x0004
  SND_LOOP* = 0x0008
  SND_NOSTOP* = 0x0010
  SND_NOWAIT* = 0x00002000
  SND_ALIAS* = 0x00010000
  SND_ALIAS_ID* = 0x00110000
  SND_FILENAME* = 0x00020000
  SND_RESOURCE* = 0x00040004
  SND_PURGE* = 0x0040
  SND_APPLICATION* = 0x0080
  SND_ALIAS_START* = 0
  WAVERR_BADFORMAT* = WAVERR_BASE+0
  WAVERR_STILLPLAYING* = WAVERR_BASE+1
  WAVERR_UNPREPARED* = WAVERR_BASE+2
  WAVERR_SYNC* = WAVERR_BASE+3
  WAVERR_LASTERROR* = WAVERR_BASE+3
  WOM_OPEN* = MM_WOM_OPEN
  WOM_CLOSE* = MM_WOM_CLOSE
  WOM_DONE* = MM_WOM_DONE
  WIM_OPEN* = MM_WIM_OPEN
  WIM_CLOSE* = MM_WIM_CLOSE
  WIM_DATA* = MM_WIM_DATA
  WAVE_MAPPER* = UINT(-1)
  WAVE_FORMAT_QUERY* = 0x0001
  WAVE_ALLOWSYNC* = 0x0002
  WAVE_MAPPED* = 0x0004
  WAVE_FORMAT_DIRECT* = 0x0008
  WAVE_FORMAT_DIRECT_QUERY* = WAVE_FORMAT_QUERY or WAVE_FORMAT_DIRECT
  WHDR_DONE* = 0x00000001
  WHDR_PREPARED* = 0x00000002
  WHDR_BEGINLOOP* = 0x00000004
  WHDR_ENDLOOP* = 0x00000008
  WHDR_INQUEUE* = 0x00000010
  WAVECAPS_PITCH* = 0x0001
  WAVECAPS_PLAYBACKRATE* = 0x0002
  WAVECAPS_VOLUME* = 0x0004
  WAVECAPS_LRVOLUME* = 0x0008
  WAVECAPS_SYNC* = 0x0010
  WAVECAPS_SAMPLEACCURATE* = 0x0020
  WAVE_INVALIDFORMAT* = 0x00000000
  WAVE_FORMAT_1M08* = 0x00000001
  WAVE_FORMAT_1S08* = 0x00000002
  WAVE_FORMAT_1M16* = 0x00000004
  WAVE_FORMAT_1S16* = 0x00000008
  WAVE_FORMAT_2M08* = 0x00000010
  WAVE_FORMAT_2S08* = 0x00000020
  WAVE_FORMAT_2M16* = 0x00000040
  WAVE_FORMAT_2S16* = 0x00000080
  WAVE_FORMAT_4M08* = 0x00000100
  WAVE_FORMAT_4S08* = 0x00000200
  WAVE_FORMAT_4M16* = 0x00000400
  WAVE_FORMAT_4S16* = 0x00000800
  WAVE_FORMAT_44M08* = 0x00000100
  WAVE_FORMAT_44S08* = 0x00000200
  WAVE_FORMAT_44M16* = 0x00000400
  WAVE_FORMAT_44S16* = 0x00000800
  WAVE_FORMAT_48M08* = 0x00001000
  WAVE_FORMAT_48S08* = 0x00002000
  WAVE_FORMAT_48M16* = 0x00004000
  WAVE_FORMAT_48S16* = 0x00008000
  WAVE_FORMAT_96M08* = 0x00010000
  WAVE_FORMAT_96S08* = 0x00020000
  WAVE_FORMAT_96M16* = 0x00040000
  WAVE_FORMAT_96S16* = 0x00080000
  WAVE_FORMAT_PCM* = 1
  MIDIERR_UNPREPARED* = MIDIERR_BASE+0
  MIDIERR_STILLPLAYING* = MIDIERR_BASE+1
  MIDIERR_NOMAP* = MIDIERR_BASE+2
  MIDIERR_NOTREADY* = MIDIERR_BASE+3
  MIDIERR_NODEVICE* = MIDIERR_BASE+4
  MIDIERR_INVALIDSETUP* = MIDIERR_BASE+5
  MIDIERR_BADOPENMODE* = MIDIERR_BASE+6
  MIDIERR_DONT_CONTINUE* = MIDIERR_BASE+7
  MIDIERR_LASTERROR* = MIDIERR_BASE+7
  MIM_OPEN* = MM_MIM_OPEN
  MIM_CLOSE* = MM_MIM_CLOSE
  MIM_DATA* = MM_MIM_DATA
  MIM_LONGDATA* = MM_MIM_LONGDATA
  MIM_ERROR* = MM_MIM_ERROR
  MIM_LONGERROR* = MM_MIM_LONGERROR
  MOM_OPEN* = MM_MOM_OPEN
  MOM_CLOSE* = MM_MOM_CLOSE
  MOM_DONE* = MM_MOM_DONE
  MIM_MOREDATA* = MM_MIM_MOREDATA
  MOM_POSITIONCB* = MM_MOM_POSITIONCB
  MIDI_MAPPER* = UINT(-1)
  MIDI_IO_STATUS* = 0x00000020
  MIDI_CACHE_ALL* = 1
  MIDI_CACHE_BESTFIT* = 2
  MIDI_CACHE_QUERY* = 3
  MIDI_UNCACHE* = 4
  MOD_MIDIPORT* = 1
  MOD_SYNTH* = 2
  MOD_SQSYNTH* = 3
  MOD_FMSYNTH* = 4
  MOD_MAPPER* = 5
  MOD_WAVETABLE* = 6
  MOD_SWSYNTH* = 7
  MIDICAPS_VOLUME* = 0x0001
  MIDICAPS_LRVOLUME* = 0x0002
  MIDICAPS_CACHE* = 0x0004
  MIDICAPS_STREAM* = 0x0008
  MHDR_DONE* = 0x00000001
  MHDR_PREPARED* = 0x00000002
  MHDR_INQUEUE* = 0x00000004
  MHDR_ISSTRM* = 0x00000008
  MEVT_F_SHORT* = 0x00000000
  MEVT_F_LONG* = 0x80000000'i32
  MEVT_F_CALLBACK* = 0x40000000
  MEVT_SHORTMSG* = BYTE 0x00
  MEVT_TEMPO* = BYTE 0x01
  MEVT_NOP* = BYTE 0x02
  MEVT_LONGMSG* = BYTE 0x80
  MEVT_COMMENT* = BYTE 0x82
  MEVT_VERSION* = BYTE 0x84
  MIDISTRM_ERROR* = -2
  MIDIPROP_SET* = 0x80000000'i32
  MIDIPROP_GET* = 0x40000000
  MIDIPROP_TIMEDIV* = 0x00000001
  MIDIPROP_TEMPO* = 0x00000002
  AUX_MAPPER* = UINT(-1)
  AUXCAPS_CDAUDIO* = 1
  AUXCAPS_AUXIN* = 2
  AUXCAPS_VOLUME* = 0x0001
  AUXCAPS_LRVOLUME* = 0x0002
  MIXERR_INVALLINE* = MIXERR_BASE+0
  MIXERR_INVALCONTROL* = MIXERR_BASE+1
  MIXERR_INVALVALUE* = MIXERR_BASE+2
  MIXERR_LASTERROR* = MIXERR_BASE+2
  MIXER_OBJECTF_HANDLE* = 0x80000000'i32
  MIXER_OBJECTF_MIXER* = 0x00000000
  MIXER_OBJECTF_HMIXER* = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIXER
  MIXER_OBJECTF_WAVEOUT* = 0x10000000
  MIXER_OBJECTF_HWAVEOUT* = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEOUT
  MIXER_OBJECTF_WAVEIN* = 0x20000000
  MIXER_OBJECTF_HWAVEIN* = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_WAVEIN
  MIXER_OBJECTF_MIDIOUT* = 0x30000000
  MIXER_OBJECTF_HMIDIOUT* = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIOUT
  MIXER_OBJECTF_MIDIIN* = 0x40000000
  MIXER_OBJECTF_HMIDIIN* = MIXER_OBJECTF_HANDLE or MIXER_OBJECTF_MIDIIN
  MIXER_OBJECTF_AUX* = 0x50000000
  MIXERLINE_LINEF_ACTIVE* = 0x00000001
  MIXERLINE_LINEF_DISCONNECTED* = 0x00008000
  MIXERLINE_LINEF_SOURCE* = 0x80000000'i32
  MIXERLINE_COMPONENTTYPE_DST_FIRST* = 0x0
  MIXERLINE_COMPONENTTYPE_DST_UNDEFINED* = MIXERLINE_COMPONENTTYPE_DST_FIRST+0
  MIXERLINE_COMPONENTTYPE_DST_DIGITAL* = MIXERLINE_COMPONENTTYPE_DST_FIRST+1
  MIXERLINE_COMPONENTTYPE_DST_LINE* = MIXERLINE_COMPONENTTYPE_DST_FIRST+2
  MIXERLINE_COMPONENTTYPE_DST_MONITOR* = MIXERLINE_COMPONENTTYPE_DST_FIRST+3
  MIXERLINE_COMPONENTTYPE_DST_SPEAKERS* = MIXERLINE_COMPONENTTYPE_DST_FIRST+4
  MIXERLINE_COMPONENTTYPE_DST_HEADPHONES* = MIXERLINE_COMPONENTTYPE_DST_FIRST+5
  MIXERLINE_COMPONENTTYPE_DST_TELEPHONE* = MIXERLINE_COMPONENTTYPE_DST_FIRST+6
  MIXERLINE_COMPONENTTYPE_DST_WAVEIN* = MIXERLINE_COMPONENTTYPE_DST_FIRST+7
  MIXERLINE_COMPONENTTYPE_DST_VOICEIN* = MIXERLINE_COMPONENTTYPE_DST_FIRST+8
  MIXERLINE_COMPONENTTYPE_DST_LAST* = MIXERLINE_COMPONENTTYPE_DST_FIRST+8
  MIXERLINE_COMPONENTTYPE_SRC_FIRST* = 0x00001000
  MIXERLINE_COMPONENTTYPE_SRC_UNDEFINED* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+0
  MIXERLINE_COMPONENTTYPE_SRC_DIGITAL* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+1
  MIXERLINE_COMPONENTTYPE_SRC_LINE* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+2
  MIXERLINE_COMPONENTTYPE_SRC_MICROPHONE* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+3
  MIXERLINE_COMPONENTTYPE_SRC_SYNTHESIZER* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+4
  MIXERLINE_COMPONENTTYPE_SRC_COMPACTDISC* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+5
  MIXERLINE_COMPONENTTYPE_SRC_TELEPHONE* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+6
  MIXERLINE_COMPONENTTYPE_SRC_PCSPEAKER* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+7
  MIXERLINE_COMPONENTTYPE_SRC_WAVEOUT* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+8
  MIXERLINE_COMPONENTTYPE_SRC_AUXILIARY* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+9
  MIXERLINE_COMPONENTTYPE_SRC_ANALOG* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+10
  MIXERLINE_COMPONENTTYPE_SRC_LAST* = MIXERLINE_COMPONENTTYPE_SRC_FIRST+10
  MIXERLINE_TARGETTYPE_UNDEFINED* = 0
  MIXERLINE_TARGETTYPE_WAVEOUT* = 1
  MIXERLINE_TARGETTYPE_WAVEIN* = 2
  MIXERLINE_TARGETTYPE_MIDIOUT* = 3
  MIXERLINE_TARGETTYPE_MIDIIN* = 4
  MIXERLINE_TARGETTYPE_AUX* = 5
  MIXER_GETLINEINFOF_DESTINATION* = 0x00000000
  MIXER_GETLINEINFOF_SOURCE* = 0x00000001
  MIXER_GETLINEINFOF_LINEID* = 0x00000002
  MIXER_GETLINEINFOF_COMPONENTTYPE* = 0x00000003
  MIXER_GETLINEINFOF_TARGETTYPE* = 0x00000004
  MIXER_GETLINEINFOF_QUERYMASK* = 0x0000000F
  MIXERCONTROL_CONTROLF_UNIFORM* = 0x00000001
  MIXERCONTROL_CONTROLF_MULTIPLE* = 0x00000002
  MIXERCONTROL_CONTROLF_DISABLED* = 0x80000000'i32
  MIXERCONTROL_CT_CLASS_MASK* = 0xF0000000'i32
  MIXERCONTROL_CT_CLASS_CUSTOM* = 0x00000000
  MIXERCONTROL_CT_CLASS_METER* = 0x10000000
  MIXERCONTROL_CT_CLASS_SWITCH* = 0x20000000
  MIXERCONTROL_CT_CLASS_NUMBER* = 0x30000000
  MIXERCONTROL_CT_CLASS_SLIDER* = 0x40000000
  MIXERCONTROL_CT_CLASS_FADER* = 0x50000000
  MIXERCONTROL_CT_CLASS_TIME* = 0x60000000
  MIXERCONTROL_CT_CLASS_LIST* = 0x70000000
  MIXERCONTROL_CT_SUBCLASS_MASK* = 0x0F000000
  MIXERCONTROL_CT_SC_SWITCH_BOOLEAN* = 0x00000000
  MIXERCONTROL_CT_SC_SWITCH_BUTTON* = 0x01000000
  MIXERCONTROL_CT_SC_METER_POLLED* = 0x00000000
  MIXERCONTROL_CT_SC_TIME_MICROSECS* = 0x00000000
  MIXERCONTROL_CT_SC_TIME_MILLISECS* = 0x01000000
  MIXERCONTROL_CT_SC_LIST_SINGLE* = 0x00000000
  MIXERCONTROL_CT_SC_LIST_MULTIPLE* = 0x01000000
  MIXERCONTROL_CT_UNITS_MASK* = 0x00FF0000
  MIXERCONTROL_CT_UNITS_CUSTOM* = 0x00000000
  MIXERCONTROL_CT_UNITS_BOOLEAN* = 0x00010000
  MIXERCONTROL_CT_UNITS_SIGNED* = 0x00020000
  MIXERCONTROL_CT_UNITS_UNSIGNED* = 0x00030000
  MIXERCONTROL_CT_UNITS_DECIBELS* = 0x00040000
  MIXERCONTROL_CT_UNITS_PERCENT* = 0x00050000
  MIXERCONTROL_CONTROLTYPE_CUSTOM* = MIXERCONTROL_CT_CLASS_CUSTOM or MIXERCONTROL_CT_UNITS_CUSTOM
  MIXERCONTROL_CONTROLTYPE_BOOLEANMETER* = MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_BOOLEAN
  MIXERCONTROL_CONTROLTYPE_SIGNEDMETER* = MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_SIGNED
  MIXERCONTROL_CONTROLTYPE_PEAKMETER* = MIXERCONTROL_CONTROLTYPE_SIGNEDMETER+1
  MIXERCONTROL_CONTROLTYPE_UNSIGNEDMETER* = MIXERCONTROL_CT_CLASS_METER or MIXERCONTROL_CT_SC_METER_POLLED or MIXERCONTROL_CT_UNITS_UNSIGNED
  MIXERCONTROL_CONTROLTYPE_BOOLEAN* = MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BOOLEAN or MIXERCONTROL_CT_UNITS_BOOLEAN
  MIXERCONTROL_CONTROLTYPE_ONOFF* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+1
  MIXERCONTROL_CONTROLTYPE_MUTE* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+2
  MIXERCONTROL_CONTROLTYPE_MONO* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+3
  MIXERCONTROL_CONTROLTYPE_LOUDNESS* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+4
  MIXERCONTROL_CONTROLTYPE_STEREOENH* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+5
  MIXERCONTROL_CONTROLTYPE_BASS_BOOST* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+0x00002277
  MIXERCONTROL_CONTROLTYPE_BUTTON* = MIXERCONTROL_CT_CLASS_SWITCH or MIXERCONTROL_CT_SC_SWITCH_BUTTON or MIXERCONTROL_CT_UNITS_BOOLEAN
  MIXERCONTROL_CONTROLTYPE_DECIBELS* = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_DECIBELS
  MIXERCONTROL_CONTROLTYPE_SIGNED* = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_SIGNED
  MIXERCONTROL_CONTROLTYPE_UNSIGNED* = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_UNSIGNED
  MIXERCONTROL_CONTROLTYPE_PERCENT* = MIXERCONTROL_CT_CLASS_NUMBER or MIXERCONTROL_CT_UNITS_PERCENT
  MIXERCONTROL_CONTROLTYPE_SLIDER* = MIXERCONTROL_CT_CLASS_SLIDER or MIXERCONTROL_CT_UNITS_SIGNED
  MIXERCONTROL_CONTROLTYPE_PAN* = MIXERCONTROL_CONTROLTYPE_SLIDER+1
  MIXERCONTROL_CONTROLTYPE_QSOUNDPAN* = MIXERCONTROL_CONTROLTYPE_SLIDER+2
  MIXERCONTROL_CONTROLTYPE_FADER* = MIXERCONTROL_CT_CLASS_FADER or MIXERCONTROL_CT_UNITS_UNSIGNED
  MIXERCONTROL_CONTROLTYPE_VOLUME* = MIXERCONTROL_CONTROLTYPE_FADER+1
  MIXERCONTROL_CONTROLTYPE_BASS* = MIXERCONTROL_CONTROLTYPE_FADER+2
  MIXERCONTROL_CONTROLTYPE_TREBLE* = MIXERCONTROL_CONTROLTYPE_FADER+3
  MIXERCONTROL_CONTROLTYPE_EQUALIZER* = MIXERCONTROL_CONTROLTYPE_FADER+4
  MIXERCONTROL_CONTROLTYPE_SINGLESELECT* = MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_SINGLE or MIXERCONTROL_CT_UNITS_BOOLEAN
  MIXERCONTROL_CONTROLTYPE_MUX* = MIXERCONTROL_CONTROLTYPE_SINGLESELECT+1
  MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT* = MIXERCONTROL_CT_CLASS_LIST or MIXERCONTROL_CT_SC_LIST_MULTIPLE or MIXERCONTROL_CT_UNITS_BOOLEAN
  MIXERCONTROL_CONTROLTYPE_MIXER* = MIXERCONTROL_CONTROLTYPE_MULTIPLESELECT+1
  MIXERCONTROL_CONTROLTYPE_MICROTIME* = MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MICROSECS or MIXERCONTROL_CT_UNITS_UNSIGNED
  MIXERCONTROL_CONTROLTYPE_MILLITIME* = MIXERCONTROL_CT_CLASS_TIME or MIXERCONTROL_CT_SC_TIME_MILLISECS or MIXERCONTROL_CT_UNITS_UNSIGNED
  MIXER_GETLINECONTROLSF_ALL* = 0x00000000
  MIXER_GETLINECONTROLSF_ONEBYID* = 0x00000001
  MIXER_GETLINECONTROLSF_ONEBYTYPE* = 0x00000002
  MIXER_GETLINECONTROLSF_QUERYMASK* = 0x0000000F
  MIXER_GETCONTROLDETAILSF_VALUE* = 0x00000000
  MIXER_GETCONTROLDETAILSF_LISTTEXT* = 0x00000001
  MIXER_GETCONTROLDETAILSF_QUERYMASK* = 0x0000000F
  MIXER_SETCONTROLDETAILSF_VALUE* = 0x00000000
  MIXER_SETCONTROLDETAILSF_CUSTOM* = 0x00000001
  MIXER_SETCONTROLDETAILSF_QUERYMASK* = 0x0000000F
  TIMERR_NOERROR* = 0
  TIMERR_NOCANDO* = TIMERR_BASE+1
  TIMERR_STRUCT* = TIMERR_BASE+33
  TIME_ONESHOT* = 0x0000
  TIME_PERIODIC* = 0x0001
  TIME_CALLBACK_FUNCTION* = 0x0000
  TIME_CALLBACK_EVENT_SET* = 0x0010
  TIME_CALLBACK_EVENT_PULSE* = 0x0020
  TIME_KILL_SYNCHRONOUS* = 0x0100
  JOYERR_NOERROR* = 0
  JOYERR_PARMS* = JOYERR_BASE+5
  JOYERR_NOCANDO* = JOYERR_BASE+6
  JOYERR_UNPLUGGED* = JOYERR_BASE+7
  JOY_BUTTON1* = 0x0001
  JOY_BUTTON2* = 0x0002
  JOY_BUTTON3* = 0x0004
  JOY_BUTTON4* = 0x0008
  JOY_BUTTON1CHG* = 0x0100
  JOY_BUTTON2CHG* = 0x0200
  JOY_BUTTON3CHG* = 0x0400
  JOY_BUTTON4CHG* = 0x0800
  JOY_BUTTON5* = 0x00000010
  JOY_BUTTON6* = 0x00000020
  JOY_BUTTON7* = 0x00000040
  JOY_BUTTON8* = 0x00000080
  JOY_BUTTON9* = 0x00000100
  JOY_BUTTON10* = 0x00000200
  JOY_BUTTON11* = 0x00000400
  JOY_BUTTON12* = 0x00000800
  JOY_BUTTON13* = 0x00001000
  JOY_BUTTON14* = 0x00002000
  JOY_BUTTON15* = 0x00004000
  JOY_BUTTON16* = 0x00008000
  JOY_BUTTON17* = 0x00010000
  JOY_BUTTON18* = 0x00020000
  JOY_BUTTON19* = 0x00040000
  JOY_BUTTON20* = 0x00080000
  JOY_BUTTON21* = 0x00100000
  JOY_BUTTON22* = 0x00200000
  JOY_BUTTON23* = 0x00400000
  JOY_BUTTON24* = 0x00800000
  JOY_BUTTON25* = 0x01000000
  JOY_BUTTON26* = 0x02000000
  JOY_BUTTON27* = 0x04000000
  JOY_BUTTON28* = 0x08000000
  JOY_BUTTON29* = 0x10000000
  JOY_BUTTON30* = 0x20000000
  JOY_BUTTON31* = 0x40000000
  JOY_BUTTON32* = 0x80000000'i32
  JOY_POVFORWARD* = 0
  JOY_POVRIGHT* = 9000
  JOY_POVBACKWARD* = 18000
  JOY_POVLEFT* = 27000
  JOY_RETURNX* = 0x00000001
  JOY_RETURNY* = 0x00000002
  JOY_RETURNZ* = 0x00000004
  JOY_RETURNR* = 0x00000008
  JOY_RETURNU* = 0x00000010
  JOY_RETURNV* = 0x00000020
  JOY_RETURNPOV* = 0x00000040
  JOY_RETURNBUTTONS* = 0x00000080
  JOY_RETURNRAWDATA* = 0x00000100
  JOY_RETURNPOVCTS* = 0x00000200
  JOY_RETURNCENTERED* = 0x00000400
  JOY_USEDEADZONE* = 0x00000800
  JOY_RETURNALL* = JOY_RETURNX or JOY_RETURNY or JOY_RETURNZ or JOY_RETURNR or JOY_RETURNU or JOY_RETURNV or JOY_RETURNPOV or JOY_RETURNBUTTONS
  JOY_CAL_READALWAYS* = 0x00010000
  JOY_CAL_READXYONLY* = 0x00020000
  JOY_CAL_READ3* = 0x00040000
  JOY_CAL_READ4* = 0x00080000
  JOY_CAL_READXONLY* = 0x00100000
  JOY_CAL_READYONLY* = 0x00200000
  JOY_CAL_READ5* = 0x00400000
  JOY_CAL_READ6* = 0x00800000
  JOY_CAL_READZONLY* = 0x01000000
  JOY_CAL_READRONLY* = 0x02000000
  JOY_CAL_READUONLY* = 0x04000000
  JOY_CAL_READVONLY* = 0x08000000
  JOYSTICKID1* = 0
  JOYSTICKID2* = 1
  JOYCAPS_HASZ* = 0x0001
  JOYCAPS_HASR* = 0x0002
  JOYCAPS_HASU* = 0x0004
  JOYCAPS_HASV* = 0x0008
  JOYCAPS_HASPOV* = 0x0010
  JOYCAPS_POV4DIR* = 0x0020
  JOYCAPS_POVCTS* = 0x0040
  MMIOERR_BASE* = 256
  MMIOERR_FILENOTFOUND* = MMIOERR_BASE+1
  MMIOERR_OUTOFMEMORY* = MMIOERR_BASE+2
  MMIOERR_CANNOTOPEN* = MMIOERR_BASE+3
  MMIOERR_CANNOTCLOSE* = MMIOERR_BASE+4
  MMIOERR_CANNOTREAD* = MMIOERR_BASE+5
  MMIOERR_CANNOTWRITE* = MMIOERR_BASE+6
  MMIOERR_CANNOTSEEK* = MMIOERR_BASE+7
  MMIOERR_CANNOTEXPAND* = MMIOERR_BASE+8
  MMIOERR_CHUNKNOTFOUND* = MMIOERR_BASE+9
  MMIOERR_UNBUFFERED* = MMIOERR_BASE+10
  MMIOERR_PATHNOTFOUND* = MMIOERR_BASE+11
  MMIOERR_ACCESSDENIED* = MMIOERR_BASE+12
  MMIOERR_SHARINGVIOLATION* = MMIOERR_BASE+13
  MMIOERR_NETWORKERROR* = MMIOERR_BASE+14
  MMIOERR_TOOMANYOPENFILES* = MMIOERR_BASE+15
  MMIOERR_INVALIDFILE* = MMIOERR_BASE+16
  CFSEPCHAR* = 0x2B
  MMIO_RWMODE* = 0x00000003
  MMIO_SHAREMODE* = 0x00000070
  MMIO_CREATE* = 0x00001000
  MMIO_PARSE* = 0x00000100
  MMIO_DELETE* = 0x00000200
  MMIO_EXIST* = 0x00004000
  MMIO_ALLOCBUF* = 0x00010000
  MMIO_GETTEMP* = 0x00020000
  MMIO_DIRTY* = 0x10000000
  MMIO_READ* = 0x00000000
  MMIO_WRITE* = 0x00000001
  MMIO_READWRITE* = 0x00000002
  MMIO_COMPAT* = 0x00000000
  MMIO_EXCLUSIVE* = 0x00000010
  MMIO_DENYWRITE* = 0x00000020
  MMIO_DENYREAD* = 0x00000030
  MMIO_DENYNONE* = 0x00000040
  MMIO_FHOPEN* = 0x0010
  MMIO_EMPTYBUF* = 0x0010
  MMIO_TOUPPER* = 0x0010
  MMIO_INSTALLPROC* = 0x00010000
  MMIO_GLOBALPROC* = 0x10000000
  MMIO_REMOVEPROC* = 0x00020000
  MMIO_UNICODEPROC* = 0x01000000
  MMIO_FINDPROC* = 0x00040000
  MMIO_FINDCHUNK* = 0x0010
  MMIO_FINDRIFF* = 0x0020
  MMIO_FINDLIST* = 0x0040
  MMIO_CREATERIFF* = 0x0020
  MMIO_CREATELIST* = 0x0040
  MMIOM_READ* = MMIO_READ
  MMIOM_WRITE* = MMIO_WRITE
  MMIOM_SEEK* = 2
  MMIOM_OPEN* = 3
  MMIOM_CLOSE* = 4
  MMIOM_WRITEFLUSH* = 5
  MMIOM_RENAME* = 6
  MMIOM_USER* = 0x8000
  SEEK_SET* = 0
  SEEK_CUR* = 1
  SEEK_END* = 2
  MMIO_DEFAULTBUFFER* = 8192
  MCIERR_INVALID_DEVICE_ID* = MCIERR_BASE+1
  MCIERR_UNRECOGNIZED_KEYWORD* = MCIERR_BASE+3
  MCIERR_UNRECOGNIZED_COMMAND* = MCIERR_BASE+5
  MCIERR_HARDWARE* = MCIERR_BASE+6
  MCIERR_INVALID_DEVICE_NAME* = MCIERR_BASE+7
  MCIERR_OUT_OF_MEMORY* = MCIERR_BASE+8
  MCIERR_DEVICE_OPEN* = MCIERR_BASE+9
  MCIERR_CANNOT_LOAD_DRIVER* = MCIERR_BASE+10
  MCIERR_MISSING_COMMAND_STRING* = MCIERR_BASE+11
  MCIERR_PARAM_OVERFLOW* = MCIERR_BASE+12
  MCIERR_MISSING_STRING_ARGUMENT* = MCIERR_BASE+13
  MCIERR_BAD_INTEGER* = MCIERR_BASE+14
  MCIERR_PARSER_INTERNAL* = MCIERR_BASE+15
  MCIERR_DRIVER_INTERNAL* = MCIERR_BASE+16
  MCIERR_MISSING_PARAMETER* = MCIERR_BASE+17
  MCIERR_UNSUPPORTED_FUNCTION* = MCIERR_BASE+18
  MCIERR_FILE_NOT_FOUND* = MCIERR_BASE+19
  MCIERR_DEVICE_NOT_READY* = MCIERR_BASE+20
  MCIERR_INTERNAL* = MCIERR_BASE+21
  MCIERR_DRIVER* = MCIERR_BASE+22
  MCIERR_CANNOT_USE_ALL* = MCIERR_BASE+23
  MCIERR_MULTIPLE* = MCIERR_BASE+24
  MCIERR_EXTENSION_NOT_FOUND* = MCIERR_BASE+25
  MCIERR_OUTOFRANGE* = MCIERR_BASE+26
  MCIERR_FLAGS_NOT_COMPATIBLE* = MCIERR_BASE+28
  MCIERR_FILE_NOT_SAVED* = MCIERR_BASE+30
  MCIERR_DEVICE_TYPE_REQUIRED* = MCIERR_BASE+31
  MCIERR_DEVICE_LOCKED* = MCIERR_BASE+32
  MCIERR_DUPLICATE_ALIAS* = MCIERR_BASE+33
  MCIERR_BAD_CONSTANT* = MCIERR_BASE+34
  MCIERR_MUST_USE_SHAREABLE* = MCIERR_BASE+35
  MCIERR_MISSING_DEVICE_NAME* = MCIERR_BASE+36
  MCIERR_BAD_TIME_FORMAT* = MCIERR_BASE+37
  MCIERR_NO_CLOSING_QUOTE* = MCIERR_BASE+38
  MCIERR_DUPLICATE_FLAGS* = MCIERR_BASE+39
  MCIERR_INVALID_FILE* = MCIERR_BASE+40
  MCIERR_NULL_PARAMETER_BLOCK* = MCIERR_BASE+41
  MCIERR_UNNAMED_RESOURCE* = MCIERR_BASE+42
  MCIERR_NEW_REQUIRES_ALIAS* = MCIERR_BASE+43
  MCIERR_NOTIFY_ON_AUTO_OPEN* = MCIERR_BASE+44
  MCIERR_NO_ELEMENT_ALLOWED* = MCIERR_BASE+45
  MCIERR_NONAPPLICABLE_FUNCTION* = MCIERR_BASE+46
  MCIERR_ILLEGAL_FOR_AUTO_OPEN* = MCIERR_BASE+47
  MCIERR_FILENAME_REQUIRED* = MCIERR_BASE+48
  MCIERR_EXTRA_CHARACTERS* = MCIERR_BASE+49
  MCIERR_DEVICE_NOT_INSTALLED* = MCIERR_BASE+50
  MCIERR_GET_CD* = MCIERR_BASE+51
  MCIERR_SET_CD* = MCIERR_BASE+52
  MCIERR_SET_DRIVE* = MCIERR_BASE+53
  MCIERR_DEVICE_LENGTH* = MCIERR_BASE+54
  MCIERR_DEVICE_ORD_LENGTH* = MCIERR_BASE+55
  MCIERR_NO_INTEGER* = MCIERR_BASE+56
  MCIERR_WAVE_OUTPUTSINUSE* = MCIERR_BASE+64
  MCIERR_WAVE_SETOUTPUTINUSE* = MCIERR_BASE+65
  MCIERR_WAVE_INPUTSINUSE* = MCIERR_BASE+66
  MCIERR_WAVE_SETINPUTINUSE* = MCIERR_BASE+67
  MCIERR_WAVE_OUTPUTUNSPECIFIED* = MCIERR_BASE+68
  MCIERR_WAVE_INPUTUNSPECIFIED* = MCIERR_BASE+69
  MCIERR_WAVE_OUTPUTSUNSUITABLE* = MCIERR_BASE+70
  MCIERR_WAVE_SETOUTPUTUNSUITABLE* = MCIERR_BASE+71
  MCIERR_WAVE_INPUTSUNSUITABLE* = MCIERR_BASE+72
  MCIERR_WAVE_SETINPUTUNSUITABLE* = MCIERR_BASE+73
  MCIERR_SEQ_DIV_INCOMPATIBLE* = MCIERR_BASE+80
  MCIERR_SEQ_PORT_INUSE* = MCIERR_BASE+81
  MCIERR_SEQ_PORT_NONEXISTENT* = MCIERR_BASE+82
  MCIERR_SEQ_PORT_MAPNODEVICE* = MCIERR_BASE+83
  MCIERR_SEQ_PORT_MISCERROR* = MCIERR_BASE+84
  MCIERR_SEQ_TIMER* = MCIERR_BASE+85
  MCIERR_SEQ_PORTUNSPECIFIED* = MCIERR_BASE+86
  MCIERR_SEQ_NOMIDIPRESENT* = MCIERR_BASE+87
  MCIERR_NO_WINDOW* = MCIERR_BASE+90
  MCIERR_CREATEWINDOW* = MCIERR_BASE+91
  MCIERR_FILE_READ* = MCIERR_BASE+92
  MCIERR_FILE_WRITE* = MCIERR_BASE+93
  MCIERR_NO_IDENTITY* = MCIERR_BASE+94
  MCIERR_CUSTOM_DRIVER_BASE* = MCIERR_BASE+256
  MCI_FIRST* = DRV_MCI_FIRST
  MCI_OPEN* = 0x0803
  MCI_CLOSE* = 0x0804
  MCI_ESCAPE* = 0x0805
  MCI_PLAY* = 0x0806
  MCI_SEEK* = 0x0807
  MCI_STOP* = 0x0808
  MCI_PAUSE* = 0x0809
  MCI_INFO* = 0x080A
  MCI_GETDEVCAPS* = 0x080B
  MCI_SPIN* = 0x080C
  MCI_SET* = 0x080D
  MCI_STEP* = 0x080E
  MCI_RECORD* = 0x080F
  MCI_SYSINFO* = 0x0810
  MCI_BREAK* = 0x0811
  MCI_SAVE* = 0x0813
  MCI_STATUS* = 0x0814
  MCI_CUE* = 0x0830
  MCI_REALIZE* = 0x0840
  MCI_WINDOW* = 0x0841
  MCI_PUT* = 0x0842
  MCI_WHERE* = 0x0843
  MCI_FREEZE* = 0x0844
  MCI_UNFREEZE* = 0x0845
  MCI_LOAD* = 0x0850
  MCI_CUT* = 0x0851
  MCI_COPY* = 0x0852
  MCI_PASTE* = 0x0853
  MCI_UPDATE* = 0x0854
  MCI_RESUME* = 0x0855
  MCI_DELETE* = 0x0856
  MCI_USER_MESSAGES* = DRV_MCI_FIRST+0x400
  MCI_LAST* = 0x0FFF
  MCI_ALL_DEVICE_ID* = MCIDEVICEID(-1)
  MCI_DEVTYPE_VCR* = 513
  MCI_DEVTYPE_VIDEODISC* = 514
  MCI_DEVTYPE_OVERLAY* = 515
  MCI_DEVTYPE_CD_AUDIO* = 516
  MCI_DEVTYPE_DAT* = 517
  MCI_DEVTYPE_SCANNER* = 518
  MCI_DEVTYPE_ANIMATION* = 519
  MCI_DEVTYPE_DIGITAL_VIDEO* = 520
  MCI_DEVTYPE_OTHER* = 521
  MCI_DEVTYPE_WAVEFORM_AUDIO* = 522
  MCI_DEVTYPE_SEQUENCER* = 523
  MCI_DEVTYPE_FIRST* = MCI_DEVTYPE_VCR
  MCI_DEVTYPE_LAST* = MCI_DEVTYPE_SEQUENCER
  MCI_DEVTYPE_FIRST_USER* = 0x1000
  MCI_MODE_NOT_READY* = MCI_STRING_OFFSET+12
  MCI_MODE_STOP* = MCI_STRING_OFFSET+13
  MCI_MODE_PLAY* = MCI_STRING_OFFSET+14
  MCI_MODE_RECORD* = MCI_STRING_OFFSET+15
  MCI_MODE_SEEK* = MCI_STRING_OFFSET+16
  MCI_MODE_PAUSE* = MCI_STRING_OFFSET+17
  MCI_MODE_OPEN* = MCI_STRING_OFFSET+18
  MCI_FORMAT_MILLISECONDS* = 0
  MCI_FORMAT_HMS* = 1
  MCI_FORMAT_MSF* = 2
  MCI_FORMAT_FRAMES* = 3
  MCI_FORMAT_SMPTE_24* = 4
  MCI_FORMAT_SMPTE_25* = 5
  MCI_FORMAT_SMPTE_30* = 6
  MCI_FORMAT_SMPTE_30DROP* = 7
  MCI_FORMAT_BYTES* = 8
  MCI_FORMAT_SAMPLES* = 9
  MCI_FORMAT_TMSF* = 10
  MCI_NOTIFY_SUCCESSFUL* = 0x0001
  MCI_NOTIFY_SUPERSEDED* = 0x0002
  MCI_NOTIFY_ABORTED* = 0x0004
  MCI_NOTIFY_FAILURE* = 0x0008
  MCI_NOTIFY* = 0x00000001
  MCI_WAIT* = 0x00000002
  MCI_FROM* = 0x00000004
  MCI_TO* = 0x00000008
  MCI_TRACK* = 0x00000010
  MCI_OPEN_SHAREABLE* = 0x00000100
  MCI_OPEN_ELEMENT* = 0x00000200
  MCI_OPEN_ALIAS* = 0x00000400
  MCI_OPEN_ELEMENT_ID* = 0x00000800
  MCI_OPEN_TYPE_ID* = 0x00001000
  MCI_OPEN_TYPE* = 0x00002000
  MCI_SEEK_TO_START* = 0x00000100
  MCI_SEEK_TO_END* = 0x00000200
  MCI_STATUS_ITEM* = 0x00000100
  MCI_STATUS_START* = 0x00000200
  MCI_STATUS_LENGTH* = 0x00000001
  MCI_STATUS_POSITION* = 0x00000002
  MCI_STATUS_NUMBER_OF_TRACKS* = 0x00000003
  MCI_STATUS_MODE* = 0x00000004
  MCI_STATUS_MEDIA_PRESENT* = 0x00000005
  MCI_STATUS_TIME_FORMAT* = 0x00000006
  MCI_STATUS_READY* = 0x00000007
  MCI_STATUS_CURRENT_TRACK* = 0x00000008
  MCI_INFO_PRODUCT* = 0x00000100
  MCI_INFO_FILE* = 0x00000200
  MCI_INFO_MEDIA_UPC* = 0x00000400
  MCI_INFO_MEDIA_IDENTITY* = 0x00000800
  MCI_INFO_NAME* = 0x00001000
  MCI_INFO_COPYRIGHT* = 0x00002000
  MCI_GETDEVCAPS_ITEM* = 0x00000100
  MCI_GETDEVCAPS_CAN_RECORD* = 0x00000001
  MCI_GETDEVCAPS_HAS_AUDIO* = 0x00000002
  MCI_GETDEVCAPS_HAS_VIDEO* = 0x00000003
  MCI_GETDEVCAPS_DEVICE_TYPE* = 0x00000004
  MCI_GETDEVCAPS_USES_FILES* = 0x00000005
  MCI_GETDEVCAPS_COMPOUND_DEVICE* = 0x00000006
  MCI_GETDEVCAPS_CAN_EJECT* = 0x00000007
  MCI_GETDEVCAPS_CAN_PLAY* = 0x00000008
  MCI_GETDEVCAPS_CAN_SAVE* = 0x00000009
  MCI_SYSINFO_QUANTITY* = 0x00000100
  MCI_SYSINFO_OPEN* = 0x00000200
  MCI_SYSINFO_NAME* = 0x00000400
  MCI_SYSINFO_INSTALLNAME* = 0x00000800
  MCI_SET_DOOR_OPEN* = 0x00000100
  MCI_SET_DOOR_CLOSED* = 0x00000200
  MCI_SET_TIME_FORMAT* = 0x00000400
  MCI_SET_AUDIO* = 0x00000800
  MCI_SET_VIDEO* = 0x00001000
  MCI_SET_ON* = 0x00002000
  MCI_SET_OFF* = 0x00004000
  MCI_SET_AUDIO_ALL* = 0x00000000
  MCI_SET_AUDIO_LEFT* = 0x00000001
  MCI_SET_AUDIO_RIGHT* = 0x00000002
  MCI_BREAK_KEY* = 0x00000100
  MCI_BREAK_HWND* = 0x00000200
  MCI_BREAK_OFF* = 0x00000400
  MCI_RECORD_INSERT* = 0x00000100
  MCI_RECORD_OVERWRITE* = 0x00000200
  MCI_SAVE_FILE* = 0x00000100
  MCI_LOAD_FILE* = 0x00000100
  MCI_VD_MODE_PARK* = MCI_VD_OFFSET+1
  MCI_VD_MEDIA_CLV* = MCI_VD_OFFSET+2
  MCI_VD_MEDIA_CAV* = MCI_VD_OFFSET+3
  MCI_VD_MEDIA_OTHER* = MCI_VD_OFFSET+4
  MCI_VD_FORMAT_TRACK* = 0x4001
  MCI_VD_PLAY_REVERSE* = 0x00010000
  MCI_VD_PLAY_FAST* = 0x00020000
  MCI_VD_PLAY_SPEED* = 0x00040000
  MCI_VD_PLAY_SCAN* = 0x00080000
  MCI_VD_PLAY_SLOW* = 0x00100000
  MCI_VD_SEEK_REVERSE* = 0x00010000
  MCI_VD_STATUS_SPEED* = 0x00004002
  MCI_VD_STATUS_FORWARD* = 0x00004003
  MCI_VD_STATUS_MEDIA_TYPE* = 0x00004004
  MCI_VD_STATUS_SIDE* = 0x00004005
  MCI_VD_STATUS_DISC_SIZE* = 0x00004006
  MCI_VD_GETDEVCAPS_CLV* = 0x00010000
  MCI_VD_GETDEVCAPS_CAV* = 0x00020000
  MCI_VD_SPIN_UP* = 0x00010000
  MCI_VD_SPIN_DOWN* = 0x00020000
  MCI_VD_GETDEVCAPS_CAN_REVERSE* = 0x00004002
  MCI_VD_GETDEVCAPS_FAST_RATE* = 0x00004003
  MCI_VD_GETDEVCAPS_SLOW_RATE* = 0x00004004
  MCI_VD_GETDEVCAPS_NORMAL_RATE* = 0x00004005
  MCI_VD_STEP_FRAMES* = 0x00010000
  MCI_VD_STEP_REVERSE* = 0x00020000
  MCI_VD_ESCAPE_STRING* = 0x00000100
  MCI_CDA_STATUS_TYPE_TRACK* = 0x00004001
  MCI_CDA_TRACK_AUDIO* = MCI_CD_OFFSET+0
  MCI_CDA_TRACK_OTHER* = MCI_CD_OFFSET+1
  MCI_WAVE_PCM* = MCI_WAVE_OFFSET+0
  MCI_WAVE_MAPPER* = MCI_WAVE_OFFSET+1
  MCI_WAVE_OPEN_BUFFER* = 0x00010000
  MCI_WAVE_SET_FORMATTAG* = 0x00010000
  MCI_WAVE_SET_CHANNELS* = 0x00020000
  MCI_WAVE_SET_SAMPLESPERSEC* = 0x00040000
  MCI_WAVE_SET_AVGBYTESPERSEC* = 0x00080000
  MCI_WAVE_SET_BLOCKALIGN* = 0x00100000
  MCI_WAVE_SET_BITSPERSAMPLE* = 0x00200000
  MCI_WAVE_INPUT* = 0x00400000
  MCI_WAVE_OUTPUT* = 0x00800000
  MCI_WAVE_STATUS_FORMATTAG* = 0x00004001
  MCI_WAVE_STATUS_CHANNELS* = 0x00004002
  MCI_WAVE_STATUS_SAMPLESPERSEC* = 0x00004003
  MCI_WAVE_STATUS_AVGBYTESPERSEC* = 0x00004004
  MCI_WAVE_STATUS_BLOCKALIGN* = 0x00004005
  MCI_WAVE_STATUS_BITSPERSAMPLE* = 0x00004006
  MCI_WAVE_STATUS_LEVEL* = 0x00004007
  MCI_WAVE_SET_ANYINPUT* = 0x04000000
  MCI_WAVE_SET_ANYOUTPUT* = 0x08000000
  MCI_WAVE_GETDEVCAPS_INPUTS* = 0x00004001
  MCI_WAVE_GETDEVCAPS_OUTPUTS* = 0x00004002
  MCI_SEQ_DIV_PPQN* = 0+MCI_SEQ_OFFSET
  MCI_SEQ_DIV_SMPTE_24* = 1+MCI_SEQ_OFFSET
  MCI_SEQ_DIV_SMPTE_25* = 2+MCI_SEQ_OFFSET
  MCI_SEQ_DIV_SMPTE_30DROP* = 3+MCI_SEQ_OFFSET
  MCI_SEQ_DIV_SMPTE_30* = 4+MCI_SEQ_OFFSET
  MCI_SEQ_FORMAT_SONGPTR* = 0x4001
  MCI_SEQ_FILE* = 0x4002
  MCI_SEQ_MIDI* = 0x4003
  MCI_SEQ_SMPTE* = 0x4004
  MCI_SEQ_NONE* = 65533
  MCI_SEQ_MAPPER* = 65535
  MCI_SEQ_STATUS_TEMPO* = 0x00004002
  MCI_SEQ_STATUS_PORT* = 0x00004003
  MCI_SEQ_STATUS_SLAVE* = 0x00004007
  MCI_SEQ_STATUS_MASTER* = 0x00004008
  MCI_SEQ_STATUS_OFFSET* = 0x00004009
  MCI_SEQ_STATUS_DIVTYPE* = 0x0000400A
  MCI_SEQ_STATUS_NAME* = 0x0000400B
  MCI_SEQ_STATUS_COPYRIGHT* = 0x0000400C
  MCI_SEQ_SET_TEMPO* = 0x00010000
  MCI_SEQ_SET_PORT* = 0x00020000
  MCI_SEQ_SET_SLAVE* = 0x00040000
  MCI_SEQ_SET_MASTER* = 0x00080000
  MCI_SEQ_SET_OFFSET* = 0x01000000
  MCI_ANIM_OPEN_WS* = 0x00010000
  MCI_ANIM_OPEN_PARENT* = 0x00020000
  MCI_ANIM_OPEN_NOSTATIC* = 0x00040000
  MCI_ANIM_PLAY_SPEED* = 0x00010000
  MCI_ANIM_PLAY_REVERSE* = 0x00020000
  MCI_ANIM_PLAY_FAST* = 0x00040000
  MCI_ANIM_PLAY_SLOW* = 0x00080000
  MCI_ANIM_PLAY_SCAN* = 0x00100000
  MCI_ANIM_STEP_REVERSE* = 0x00010000
  MCI_ANIM_STEP_FRAMES* = 0x00020000
  MCI_ANIM_STATUS_SPEED* = 0x00004001
  MCI_ANIM_STATUS_FORWARD* = 0x00004002
  MCI_ANIM_STATUS_HWND* = 0x00004003
  MCI_ANIM_STATUS_HPAL* = 0x00004004
  MCI_ANIM_STATUS_STRETCH* = 0x00004005
  MCI_ANIM_INFO_TEXT* = 0x00010000
  MCI_ANIM_GETDEVCAPS_CAN_REVERSE* = 0x00004001
  MCI_ANIM_GETDEVCAPS_FAST_RATE* = 0x00004002
  MCI_ANIM_GETDEVCAPS_SLOW_RATE* = 0x00004003
  MCI_ANIM_GETDEVCAPS_NORMAL_RATE* = 0x00004004
  MCI_ANIM_GETDEVCAPS_PALETTES* = 0x00004006
  MCI_ANIM_GETDEVCAPS_CAN_STRETCH* = 0x00004007
  MCI_ANIM_GETDEVCAPS_MAX_WINDOWS* = 0x00004008
  MCI_ANIM_REALIZE_NORM* = 0x00010000
  MCI_ANIM_REALIZE_BKGD* = 0x00020000
  MCI_ANIM_WINDOW_HWND* = 0x00010000
  MCI_ANIM_WINDOW_STATE* = 0x00040000
  MCI_ANIM_WINDOW_TEXT* = 0x00080000
  MCI_ANIM_WINDOW_ENABLE_STRETCH* = 0x00100000
  MCI_ANIM_WINDOW_DISABLE_STRETCH* = 0x00200000
  MCI_ANIM_WINDOW_DEFAULT* = 0x00000000
  MCI_ANIM_RECT* = 0x00010000
  MCI_ANIM_PUT_SOURCE* = 0x00020000
  MCI_ANIM_PUT_DESTINATION* = 0x00040000
  MCI_ANIM_WHERE_SOURCE* = 0x00020000
  MCI_ANIM_WHERE_DESTINATION* = 0x00040000
  MCI_ANIM_UPDATE_HDC* = 0x00020000
  MCI_OVLY_OPEN_WS* = 0x00010000
  MCI_OVLY_OPEN_PARENT* = 0x00020000
  MCI_OVLY_STATUS_HWND* = 0x00004001
  MCI_OVLY_STATUS_STRETCH* = 0x00004002
  MCI_OVLY_INFO_TEXT* = 0x00010000
  MCI_OVLY_GETDEVCAPS_CAN_STRETCH* = 0x00004001
  MCI_OVLY_GETDEVCAPS_CAN_FREEZE* = 0x00004002
  MCI_OVLY_GETDEVCAPS_MAX_WINDOWS* = 0x00004003
  MCI_OVLY_WINDOW_HWND* = 0x00010000
  MCI_OVLY_WINDOW_STATE* = 0x00040000
  MCI_OVLY_WINDOW_TEXT* = 0x00080000
  MCI_OVLY_WINDOW_ENABLE_STRETCH* = 0x00100000
  MCI_OVLY_WINDOW_DISABLE_STRETCH* = 0x00200000
  MCI_OVLY_WINDOW_DEFAULT* = 0x00000000
  MCI_OVLY_RECT* = 0x00010000
  MCI_OVLY_PUT_SOURCE* = 0x00020000
  MCI_OVLY_PUT_DESTINATION* = 0x00040000
  MCI_OVLY_PUT_FRAME* = 0x00080000
  MCI_OVLY_PUT_VIDEO* = 0x00100000
  MCI_OVLY_WHERE_SOURCE* = 0x00020000
  MCI_OVLY_WHERE_DESTINATION* = 0x00040000
  MCI_OVLY_WHERE_FRAME* = 0x00080000
  MCI_OVLY_WHERE_VIDEO* = 0x00100000
  NEWTRANSPARENT* = 3
  QUERYROPSUPPORT* = 40
  SELECTDIB* = 41
  INC_MMREG* = 158
  MM_MICROSOFT* = 1
  MM_CREATIVE* = 2
  MM_MEDIAVISION* = 3
  MM_FUJITSU* = 4
  MM_PRAGMATRAX* = 5
  MM_CYRIX* = 6
  MM_PHILIPS_SPEECH_PROCESSING* = 7
  MM_NETXL* = 8
  MM_ZYXEL* = 9
  MM_BECUBED* = 10
  MM_AARDVARK* = 11
  MM_BINTEC* = 12
  MM_HEWLETT_PACKARD* = 13
  MM_ACULAB* = 14
  MM_FAITH* = 15
  MM_MITEL* = 16
  MM_QUANTUM3D* = 17
  MM_SNI* = 18
  MM_EMU* = 19
  MM_ARTISOFT* = 20
  MM_TURTLE_BEACH* = 21
  MM_IBM* = 22
  MM_VOCALTEC* = 23
  MM_ROLAND* = 24
  MM_DSP_SOLUTIONS* = 25
  MM_NEC* = 26
  MM_ATI* = 27
  MM_WANGLABS* = 28
  MM_TANDY* = 29
  MM_VOYETRA* = 30
  MM_ANTEX* = 31
  MM_ICL_PS* = 32
  MM_INTEL* = 33
  MM_GRAVIS* = 34
  MM_VAL* = 35
  MM_INTERACTIVE* = 36
  MM_YAMAHA* = 37
  MM_EVEREX* = 38
  MM_ECHO* = 39
  MM_SIERRA* = 40
  MM_CAT* = 41
  MM_APPS* = 42
  MM_DSP_GROUP* = 43
  MM_MELABS* = 44
  MM_COMPUTER_FRIENDS* = 45
  MM_ESS* = 46
  MM_AUDIOFILE* = 47
  MM_MOTOROLA* = 48
  MM_CANOPUS* = 49
  MM_EPSON* = 50
  MM_TRUEVISION* = 51
  MM_AZTECH* = 52
  MM_VIDEOLOGIC* = 53
  MM_SCALACS* = 54
  MM_KORG* = 55
  MM_APT* = 56
  MM_ICS* = 57
  MM_ITERATEDSYS* = 58
  MM_METHEUS* = 59
  MM_LOGITECH* = 60
  MM_WINNOV* = 61
  MM_NCR* = 62
  MM_EXAN* = 63
  MM_AST* = 64
  MM_WILLOWPOND* = 65
  MM_SONICFOUNDRY* = 66
  MM_VITEC* = 67
  MM_MOSCOM* = 68
  MM_SILICONSOFT* = 69
  MM_TERRATEC* = 70
  MM_MEDIASONIC* = 71
  MM_SANYO* = 72
  MM_SUPERMAC* = 73
  MM_AUDIOPT* = 74
  MM_NOGATECH* = 75
  MM_SPEECHCOMP* = 76
  MM_AHEAD* = 77
  MM_DOLBY* = 78
  MM_OKI* = 79
  MM_AURAVISION* = 80
  MM_OLIVETTI* = 81
  MM_IOMAGIC* = 82
  MM_MATSUSHITA* = 83
  MM_CONTROLRES* = 84
  MM_XEBEC* = 85
  MM_NEWMEDIA* = 86
  MM_NMS* = 87
  MM_LYRRUS* = 88
  MM_COMPUSIC* = 89
  MM_OPTI* = 90
  MM_ADLACC* = 91
  MM_COMPAQ* = 92
  MM_DIALOGIC* = 93
  MM_INSOFT* = 94
  MM_MPTUS* = 95
  MM_WEITEK* = 96
  MM_LERNOUT_AND_HAUSPIE* = 97
  MM_QCIAR* = 98
  MM_APPLE* = 99
  MM_DIGITAL* = 100
  MM_MOTU* = 101
  MM_WORKBIT* = 102
  MM_OSITECH* = 103
  MM_MIRO* = 104
  MM_CIRRUSLOGIC* = 105
  MM_ISOLUTION* = 106
  MM_HORIZONS* = 107
  MM_CONCEPTS* = 108
  MM_VTG* = 109
  MM_RADIUS* = 110
  MM_ROCKWELL* = 111
  MM_XYZ* = 112
  MM_OPCODE* = 113
  MM_VOXWARE* = 114
  MM_NORTHERN_TELECOM* = 115
  MM_APICOM* = 116
  MM_GRANDE* = 117
  MM_ADDX* = 118
  MM_WILDCAT* = 119
  MM_RHETOREX* = 120
  MM_BROOKTREE* = 121
  MM_ENSONIQ* = 125
  MM_FAST* = 126
  MM_NVIDIA* = 127
  MM_OKSORI* = 128
  MM_DIACOUSTICS* = 129
  MM_GULBRANSEN* = 130
  MM_KAY_ELEMETRICS* = 131
  MM_CRYSTAL* = 132
  MM_SPLASH_STUDIOS* = 133
  MM_QUARTERDECK* = 134
  MM_TDK* = 135
  MM_DIGITAL_AUDIO_LABS* = 136
  MM_SEERSYS* = 137
  MM_PICTURETEL* = 138
  MM_ATT_MICROELECTRONICS* = 139
  MM_OSPREY* = 140
  MM_MEDIATRIX* = 141
  MM_SOUNDESIGNS* = 142
  MM_ALDIGITAL* = 143
  MM_SPECTRUM_SIGNAL_PROCESSING* = 144
  MM_ECS* = 145
  MM_AMD* = 146
  MM_COREDYNAMICS* = 147
  MM_CANAM* = 148
  MM_SOFTSOUND* = 149
  MM_NORRIS* = 150
  MM_DDD* = 151
  MM_EUPHONICS* = 152
  MM_PRECEPT* = 153
  MM_CRYSTAL_NET* = 154
  MM_CHROMATIC* = 155
  MM_VOICEINFO* = 156
  MM_VIENNASYS* = 157
  MM_CONNECTIX* = 158
  MM_GADGETLABS* = 159
  MM_FRONTIER* = 160
  MM_VIONA* = 161
  MM_CASIO* = 162
  MM_DIAMONDMM* = 163
  MM_S3* = 164
  MM_DVISION* = 165
  MM_NETSCAPE* = 166
  MM_SOUNDSPACE* = 167
  MM_VANKOEVERING* = 168
  MM_QTEAM* = 169
  MM_ZEFIRO* = 170
  MM_STUDER* = 171
  MM_FRAUNHOFER_IIS* = 172
  MM_QUICKNET* = 173
  MM_ALARIS* = 174
  MM_SICRESOURCE* = 175
  MM_NEOMAGIC* = 176
  MM_MERGING_TECHNOLOGIES* = 177
  MM_XIRLINK* = 178
  MM_COLORGRAPH* = 179
  MM_OTI* = 180
  MM_AUREAL* = 181
  MM_VIVO* = 182
  MM_SHARP* = 183
  MM_LUCENT* = 184
  MM_ATT* = 185
  MM_SUNCOM* = 186
  MM_SORVIS* = 187
  MM_INVISION* = 188
  MM_BERKOM* = 189
  MM_MARIAN* = 190
  MM_DPSINC* = 191
  MM_BCB* = 192
  MM_MOTIONPIXELS* = 193
  MM_QDESIGN* = 194
  MM_NMP* = 195
  MM_DATAFUSION* = 196
  MM_DUCK* = 197
  MM_FTR* = 198
  MM_BERCOS* = 199
  MM_ONLIVE* = 200
  MM_SIEMENS_SBC* = 201
  MM_TERALOGIC* = 202
  MM_PHONET* = 203
  MM_WINBOND* = 204
  MM_VIRTUALMUSIC* = 205
  MM_ENET* = 206
  MM_GUILLEMOT* = 207
  MM_EMAGIC* = 208
  MM_MWM* = 209
  MM_PACIFICRESEARCH* = 210
  MM_SIPROLAB* = 211
  MM_LYNX* = 212
  MM_SPECTRUM_PRODUCTIONS* = 213
  MM_DICTAPHONE* = 214
  MM_QUALCOMM* = 215
  MM_RZS* = 216
  MM_AUDIOSCIENCE* = 217
  MM_PINNACLE* = 218
  MM_EES* = 219
  MM_HAFTMANN* = 220
  MM_LUCID* = 221
  MM_HEADSPACE* = 222
  MM_UNISYS* = 223
  MM_LUMINOSITI* = 224
  MM_ACTIVEVOICE* = 225
  MM_DTS* = 226
  MM_DIGIGRAM* = 227
  MM_SOFTLAB_NSK* = 228
  MM_FORTEMEDIA* = 229
  MM_SONORUS* = 230
  MM_ARRAY* = 231
  MM_DATARAN* = 232
  MM_I_LINK* = 233
  MM_SELSIUS_SYSTEMS* = 234
  MM_ADMOS* = 235
  MM_LEXICON* = 236
  MM_SGI* = 237
  MM_IPI* = 238
  MM_ICE* = 239
  MM_VQST* = 240
  MM_ETEK* = 241
  MM_CS* = 242
  MM_ALESIS* = 243
  MM_INTERNET* = 244
  MM_SONY* = 245
  MM_HYPERACTIVE* = 246
  MM_UHER_INFORMATIC* = 247
  MM_SYDEC_NV* = 248
  MM_FLEXION* = 249
  MM_VIA* = 250
  MM_MICRONAS* = 251
  MM_ANALOGDEVICES* = 252
  MM_HP* = 253
  MM_MATROX_DIV* = 254
  MM_QUICKAUDIO* = 255
  MM_YOUCOM* = 256
  MM_RICHMOND* = 257
  MM_IODD* = 258
  MM_ICCC* = 259
  MM_3COM* = 260
  MM_MALDEN* = 261
  MM_3DFX* = 262
  MM_MINDMAKER* = 263
  MM_TELEKOL* = 264
  MM_ST_MICROELECTRONICS* = 265
  MM_ALGOVISION* = 266
  MM_UNMAPPED* = 0xffff
  MM_PID_UNMAPPED* = MM_UNMAPPED
  MM_MIDI_MAPPER* = 1
  MM_WAVE_MAPPER* = 2
  MM_SNDBLST_MIDIOUT* = 3
  MM_SNDBLST_MIDIIN* = 4
  MM_SNDBLST_SYNTH* = 5
  MM_SNDBLST_WAVEOUT* = 6
  MM_SNDBLST_WAVEIN* = 7
  MM_ADLIB* = 9
  MM_MPU401_MIDIOUT* = 10
  MM_MPU401_MIDIIN* = 11
  MM_PC_JOYSTICK* = 12
  MM_PCSPEAKER_WAVEOUT* = 13
  MM_MSFT_WSS_WAVEIN* = 14
  MM_MSFT_WSS_WAVEOUT* = 15
  MM_MSFT_WSS_FMSYNTH_STEREO* = 16
  MM_MSFT_WSS_MIXER* = 17
  MM_MSFT_WSS_OEM_WAVEIN* = 18
  MM_MSFT_WSS_OEM_WAVEOUT* = 19
  MM_MSFT_WSS_OEM_FMSYNTH_STEREO* = 20
  MM_MSFT_WSS_AUX* = 21
  MM_MSFT_WSS_OEM_AUX* = 22
  MM_MSFT_GENERIC_WAVEIN* = 23
  MM_MSFT_GENERIC_WAVEOUT* = 24
  MM_MSFT_GENERIC_MIDIIN* = 25
  MM_MSFT_GENERIC_MIDIOUT* = 26
  MM_MSFT_GENERIC_MIDISYNTH* = 27
  MM_MSFT_GENERIC_AUX_LINE* = 28
  MM_MSFT_GENERIC_AUX_MIC* = 29
  MM_MSFT_GENERIC_AUX_CD* = 30
  MM_MSFT_WSS_OEM_MIXER* = 31
  MM_MSFT_MSACM* = 32
  MM_MSFT_ACM_MSADPCM* = 33
  MM_MSFT_ACM_IMAADPCM* = 34
  MM_MSFT_ACM_MSFILTER* = 35
  MM_MSFT_ACM_GSM610* = 36
  MM_MSFT_ACM_G711* = 37
  MM_MSFT_ACM_PCM* = 38
  MM_WSS_SB16_WAVEIN* = 39
  MM_WSS_SB16_WAVEOUT* = 40
  MM_WSS_SB16_MIDIIN* = 41
  MM_WSS_SB16_MIDIOUT* = 42
  MM_WSS_SB16_SYNTH* = 43
  MM_WSS_SB16_AUX_LINE* = 44
  MM_WSS_SB16_AUX_CD* = 45
  MM_WSS_SB16_MIXER* = 46
  MM_WSS_SBPRO_WAVEIN* = 47
  MM_WSS_SBPRO_WAVEOUT* = 48
  MM_WSS_SBPRO_MIDIIN* = 49
  MM_WSS_SBPRO_MIDIOUT* = 50
  MM_WSS_SBPRO_SYNTH* = 51
  MM_WSS_SBPRO_AUX_LINE* = 52
  MM_WSS_SBPRO_AUX_CD* = 53
  MM_WSS_SBPRO_MIXER* = 54
  MM_MSFT_WSS_NT_WAVEIN* = 55
  MM_MSFT_WSS_NT_WAVEOUT* = 56
  MM_MSFT_WSS_NT_FMSYNTH_STEREO* = 57
  MM_MSFT_WSS_NT_MIXER* = 58
  MM_MSFT_WSS_NT_AUX* = 59
  MM_MSFT_SB16_WAVEIN* = 60
  MM_MSFT_SB16_WAVEOUT* = 61
  MM_MSFT_SB16_MIDIIN* = 62
  MM_MSFT_SB16_MIDIOUT* = 63
  MM_MSFT_SB16_SYNTH* = 64
  MM_MSFT_SB16_AUX_LINE* = 65
  MM_MSFT_SB16_AUX_CD* = 66
  MM_MSFT_SB16_MIXER* = 67
  MM_MSFT_SBPRO_WAVEIN* = 68
  MM_MSFT_SBPRO_WAVEOUT* = 69
  MM_MSFT_SBPRO_MIDIIN* = 70
  MM_MSFT_SBPRO_MIDIOUT* = 71
  MM_MSFT_SBPRO_SYNTH* = 72
  MM_MSFT_SBPRO_AUX_LINE* = 73
  MM_MSFT_SBPRO_AUX_CD* = 74
  MM_MSFT_SBPRO_MIXER* = 75
  MM_MSFT_MSOPL_SYNTH* = 76
  MM_MSFT_VMDMS_LINE_WAVEIN* = 80
  MM_MSFT_VMDMS_LINE_WAVEOUT* = 81
  MM_MSFT_VMDMS_HANDSET_WAVEIN* = 82
  MM_MSFT_VMDMS_HANDSET_WAVEOUT* = 83
  MM_MSFT_VMDMW_LINE_WAVEIN* = 84
  MM_MSFT_VMDMW_LINE_WAVEOUT* = 85
  MM_MSFT_VMDMW_HANDSET_WAVEIN* = 86
  MM_MSFT_VMDMW_HANDSET_WAVEOUT* = 87
  MM_MSFT_VMDMW_MIXER* = 88
  MM_MSFT_VMDM_GAME_WAVEOUT* = 89
  MM_MSFT_VMDM_GAME_WAVEIN* = 90
  MM_MSFT_ACM_MSNAUDIO* = 91
  MM_MSFT_ACM_MSG723* = 92
  MM_MSFT_ACM_MSRT24* = 93
  MM_MSFT_WDMAUDIO_WAVEOUT* = 100
  MM_MSFT_WDMAUDIO_WAVEIN* = 101
  MM_MSFT_WDMAUDIO_MIDIOUT* = 102
  MM_MSFT_WDMAUDIO_MIDIIN* = 103
  MM_MSFT_WDMAUDIO_MIXER* = 104
  MM_MSFT_WDMAUDIO_AUX* = 105
  MM_CREATIVE_SB15_WAVEIN* = 1
  MM_CREATIVE_SB20_WAVEIN* = 2
  MM_CREATIVE_SBPRO_WAVEIN* = 3
  MM_CREATIVE_SBP16_WAVEIN* = 4
  MM_CREATIVE_PHNBLST_WAVEIN* = 5
  MM_CREATIVE_SB15_WAVEOUT* = 101
  MM_CREATIVE_SB20_WAVEOUT* = 102
  MM_CREATIVE_SBPRO_WAVEOUT* = 103
  MM_CREATIVE_SBP16_WAVEOUT* = 104
  MM_CREATIVE_PHNBLST_WAVEOUT* = 105
  MM_CREATIVE_MIDIOUT* = 201
  MM_CREATIVE_MIDIIN* = 202
  MM_CREATIVE_FMSYNTH_MONO* = 301
  MM_CREATIVE_FMSYNTH_STEREO* = 302
  MM_CREATIVE_MIDI_AWE32* = 303
  MM_CREATIVE_AUX_CD* = 401
  MM_CREATIVE_AUX_LINE* = 402
  MM_CREATIVE_AUX_MIC* = 403
  MM_CREATIVE_AUX_MASTER* = 404
  MM_CREATIVE_AUX_PCSPK* = 405
  MM_CREATIVE_AUX_WAVE* = 406
  MM_CREATIVE_AUX_MIDI* = 407
  MM_CREATIVE_SBPRO_MIXER* = 408
  MM_CREATIVE_SB16_MIXER* = 409
  MM_MEDIAVISION_PROAUDIO* = 0x10
  MM_PROAUD_MIDIOUT* = MM_MEDIAVISION_PROAUDIO+1
  MM_PROAUD_MIDIIN* = MM_MEDIAVISION_PROAUDIO+2
  MM_PROAUD_SYNTH* = MM_MEDIAVISION_PROAUDIO+3
  MM_PROAUD_WAVEOUT* = MM_MEDIAVISION_PROAUDIO+4
  MM_PROAUD_WAVEIN* = MM_MEDIAVISION_PROAUDIO+5
  MM_PROAUD_MIXER* = MM_MEDIAVISION_PROAUDIO+6
  MM_PROAUD_AUX* = MM_MEDIAVISION_PROAUDIO+7
  MM_MEDIAVISION_THUNDER* = 0x20
  MM_THUNDER_SYNTH* = MM_MEDIAVISION_THUNDER+3
  MM_THUNDER_WAVEOUT* = MM_MEDIAVISION_THUNDER+4
  MM_THUNDER_WAVEIN* = MM_MEDIAVISION_THUNDER+5
  MM_THUNDER_AUX* = MM_MEDIAVISION_THUNDER+7
  MM_MEDIAVISION_TPORT* = 0x40
  MM_TPORT_WAVEOUT* = MM_MEDIAVISION_TPORT+1
  MM_TPORT_WAVEIN* = MM_MEDIAVISION_TPORT+2
  MM_TPORT_SYNTH* = MM_MEDIAVISION_TPORT+3
  MM_MEDIAVISION_PROAUDIO_PLUS* = 0x50
  MM_PROAUD_PLUS_MIDIOUT* = MM_MEDIAVISION_PROAUDIO_PLUS+1
  MM_PROAUD_PLUS_MIDIIN* = MM_MEDIAVISION_PROAUDIO_PLUS+2
  MM_PROAUD_PLUS_SYNTH* = MM_MEDIAVISION_PROAUDIO_PLUS+3
  MM_PROAUD_PLUS_WAVEOUT* = MM_MEDIAVISION_PROAUDIO_PLUS+4
  MM_PROAUD_PLUS_WAVEIN* = MM_MEDIAVISION_PROAUDIO_PLUS+5
  MM_PROAUD_PLUS_MIXER* = MM_MEDIAVISION_PROAUDIO_PLUS+6
  MM_PROAUD_PLUS_AUX* = MM_MEDIAVISION_PROAUDIO_PLUS+7
  MM_MEDIAVISION_PROAUDIO_16* = 0x60
  MM_PROAUD_16_MIDIOUT* = MM_MEDIAVISION_PROAUDIO_16+1
  MM_PROAUD_16_MIDIIN* = MM_MEDIAVISION_PROAUDIO_16+2
  MM_PROAUD_16_SYNTH* = MM_MEDIAVISION_PROAUDIO_16+3
  MM_PROAUD_16_WAVEOUT* = MM_MEDIAVISION_PROAUDIO_16+4
  MM_PROAUD_16_WAVEIN* = MM_MEDIAVISION_PROAUDIO_16+5
  MM_PROAUD_16_MIXER* = MM_MEDIAVISION_PROAUDIO_16+6
  MM_PROAUD_16_AUX* = MM_MEDIAVISION_PROAUDIO_16+7
  MM_MEDIAVISION_PROSTUDIO_16* = 0x60
  MM_STUDIO_16_MIDIOUT* = MM_MEDIAVISION_PROSTUDIO_16+1
  MM_STUDIO_16_MIDIIN* = MM_MEDIAVISION_PROSTUDIO_16+2
  MM_STUDIO_16_SYNTH* = MM_MEDIAVISION_PROSTUDIO_16+3
  MM_STUDIO_16_WAVEOUT* = MM_MEDIAVISION_PROSTUDIO_16+4
  MM_STUDIO_16_WAVEIN* = MM_MEDIAVISION_PROSTUDIO_16+5
  MM_STUDIO_16_MIXER* = MM_MEDIAVISION_PROSTUDIO_16+6
  MM_STUDIO_16_AUX* = MM_MEDIAVISION_PROSTUDIO_16+7
  MM_MEDIAVISION_CDPC* = 0x70
  MM_CDPC_MIDIOUT* = MM_MEDIAVISION_CDPC+1
  MM_CDPC_MIDIIN* = MM_MEDIAVISION_CDPC+2
  MM_CDPC_SYNTH* = MM_MEDIAVISION_CDPC+3
  MM_CDPC_WAVEOUT* = MM_MEDIAVISION_CDPC+4
  MM_CDPC_WAVEIN* = MM_MEDIAVISION_CDPC+5
  MM_CDPC_MIXER* = MM_MEDIAVISION_CDPC+6
  MM_CDPC_AUX* = MM_MEDIAVISION_CDPC+7
  MM_MEDIAVISION_OPUS1208* = 0x80
  MM_OPUS401_MIDIOUT* = MM_MEDIAVISION_OPUS1208+1
  MM_OPUS401_MIDIIN* = MM_MEDIAVISION_OPUS1208+2
  MM_OPUS1208_SYNTH* = MM_MEDIAVISION_OPUS1208+3
  MM_OPUS1208_WAVEOUT* = MM_MEDIAVISION_OPUS1208+4
  MM_OPUS1208_WAVEIN* = MM_MEDIAVISION_OPUS1208+5
  MM_OPUS1208_MIXER* = MM_MEDIAVISION_OPUS1208+6
  MM_OPUS1208_AUX* = MM_MEDIAVISION_OPUS1208+7
  MM_MEDIAVISION_OPUS1216* = 0x90
  MM_OPUS1216_MIDIOUT* = MM_MEDIAVISION_OPUS1216+1
  MM_OPUS1216_MIDIIN* = MM_MEDIAVISION_OPUS1216+2
  MM_OPUS1216_SYNTH* = MM_MEDIAVISION_OPUS1216+3
  MM_OPUS1216_WAVEOUT* = MM_MEDIAVISION_OPUS1216+4
  MM_OPUS1216_WAVEIN* = MM_MEDIAVISION_OPUS1216+5
  MM_OPUS1216_MIXER* = MM_MEDIAVISION_OPUS1216+6
  MM_OPUS1216_AUX* = MM_MEDIAVISION_OPUS1216+7
  MM_CYRIX_XASYNTH* = 1
  MM_CYRIX_XAMIDIIN* = 2
  MM_CYRIX_XAMIDIOUT* = 3
  MM_CYRIX_XAWAVEIN* = 4
  MM_CYRIX_XAWAVEOUT* = 5
  MM_CYRIX_XAAUX* = 6
  MM_CYRIX_XAMIXER* = 7
  MM_PHILIPS_ACM_LPCBB* = 1
  MM_NETXL_XLVIDEO* = 1
  MM_ZYXEL_ACM_ADPCM* = 1
  MM_AARDVARK_STUDIO12_WAVEOUT* = 1
  MM_AARDVARK_STUDIO12_WAVEIN* = 2
  MM_AARDVARK_STUDIO88_WAVEOUT* = 3
  MM_AARDVARK_STUDIO88_WAVEIN* = 4
  MM_BINTEC_TAPI_WAVE* = 1
  MM_HEWLETT_PACKARD_CU_CODEC* = 1
  MM_MITEL_TALKTO_LINE_WAVEOUT* = 100
  MM_MITEL_TALKTO_LINE_WAVEIN* = 101
  MM_MITEL_TALKTO_HANDSET_WAVEOUT* = 102
  MM_MITEL_TALKTO_HANDSET_WAVEIN* = 103
  MM_MITEL_TALKTO_BRIDGED_WAVEOUT* = 104
  MM_MITEL_TALKTO_BRIDGED_WAVEIN* = 105
  MM_MITEL_MPA_HANDSET_WAVEOUT* = 200
  MM_MITEL_MPA_HANDSET_WAVEIN* = 201
  MM_MITEL_MPA_HANDSFREE_WAVEOUT* = 202
  MM_MITEL_MPA_HANDSFREE_WAVEIN* = 203
  MM_MITEL_MPA_LINE1_WAVEOUT* = 204
  MM_MITEL_MPA_LINE1_WAVEIN* = 205
  MM_MITEL_MPA_LINE2_WAVEOUT* = 206
  MM_MITEL_MPA_LINE2_WAVEIN* = 207
  MM_MITEL_MEDIAPATH_WAVEOUT* = 300
  MM_MITEL_MEDIAPATH_WAVEIN* = 301
  MM_SNI_ACM_G721* = 1
  MM_EMU_APSSYNTH* = 1
  MM_EMU_APSMIDIIN* = 2
  MM_EMU_APSMIDIOUT* = 3
  MM_EMU_APSWAVEIN* = 4
  MM_EMU_APSWAVEOUT* = 5
  MM_ARTISOFT_SBWAVEIN* = 1
  MM_ARTISOFT_SBWAVEOUT* = 2
  MM_TBS_TROPEZ_WAVEIN* = 37
  MM_TBS_TROPEZ_WAVEOUT* = 38
  MM_TBS_TROPEZ_AUX1* = 39
  MM_TBS_TROPEZ_AUX2* = 40
  MM_TBS_TROPEZ_LINE* = 41
  MM_MMOTION_WAVEAUX* = 1
  MM_MMOTION_WAVEOUT* = 2
  MM_MMOTION_WAVEIN* = 3
  MM_IBM_PCMCIA_WAVEIN* = 11
  MM_IBM_PCMCIA_WAVEOUT* = 12
  MM_IBM_PCMCIA_SYNTH* = 13
  MM_IBM_PCMCIA_MIDIIN* = 14
  MM_IBM_PCMCIA_MIDIOUT* = 15
  MM_IBM_PCMCIA_AUX* = 16
  MM_IBM_THINKPAD200* = 17
  MM_IBM_MWAVE_WAVEIN* = 18
  MM_IBM_MWAVE_WAVEOUT* = 19
  MM_IBM_MWAVE_MIXER* = 20
  MM_IBM_MWAVE_MIDIIN* = 21
  MM_IBM_MWAVE_MIDIOUT* = 22
  MM_IBM_MWAVE_AUX* = 23
  MM_IBM_WC_MIDIOUT* = 30
  MM_IBM_WC_WAVEOUT* = 31
  MM_IBM_WC_MIXEROUT* = 33
  MM_VOCALTEC_WAVEOUT* = 1
  MM_VOCALTEC_WAVEIN* = 2
  MM_ROLAND_RAP10_MIDIOUT* = 10
  MM_ROLAND_RAP10_MIDIIN* = 11
  MM_ROLAND_RAP10_SYNTH* = 12
  MM_ROLAND_RAP10_WAVEOUT* = 13
  MM_ROLAND_RAP10_WAVEIN* = 14
  MM_ROLAND_MPU401_MIDIOUT* = 15
  MM_ROLAND_MPU401_MIDIIN* = 16
  MM_ROLAND_SMPU_MIDIOUTA* = 17
  MM_ROLAND_SMPU_MIDIOUTB* = 18
  MM_ROLAND_SMPU_MIDIINA* = 19
  MM_ROLAND_SMPU_MIDIINB* = 20
  MM_ROLAND_SC7_MIDIOUT* = 21
  MM_ROLAND_SC7_MIDIIN* = 22
  MM_ROLAND_SERIAL_MIDIOUT* = 23
  MM_ROLAND_SERIAL_MIDIIN* = 24
  MM_ROLAND_SCP_MIDIOUT* = 38
  MM_ROLAND_SCP_MIDIIN* = 39
  MM_ROLAND_SCP_WAVEOUT* = 40
  MM_ROLAND_SCP_WAVEIN* = 41
  MM_ROLAND_SCP_MIXER* = 42
  MM_ROLAND_SCP_AUX* = 48
  MM_DSP_SOLUTIONS_WAVEOUT* = 1
  MM_DSP_SOLUTIONS_WAVEIN* = 2
  MM_DSP_SOLUTIONS_SYNTH* = 3
  MM_DSP_SOLUTIONS_AUX* = 4
  MM_NEC_73_86_SYNTH* = 5
  MM_NEC_73_86_WAVEOUT* = 6
  MM_NEC_73_86_WAVEIN* = 7
  MM_NEC_26_SYNTH* = 9
  MM_NEC_MPU401_MIDIOUT* = 10
  MM_NEC_MPU401_MIDIIN* = 11
  MM_NEC_JOYSTICK* = 12
  MM_WANGLABS_WAVEIN1* = 1
  MM_WANGLABS_WAVEOUT1* = 2
  MM_TANDY_VISWAVEIN* = 1
  MM_TANDY_VISWAVEOUT* = 2
  MM_TANDY_VISBIOSSYNTH* = 3
  MM_TANDY_SENS_MMAWAVEIN* = 4
  MM_TANDY_SENS_MMAWAVEOUT* = 5
  MM_TANDY_SENS_MMAMIDIIN* = 6
  MM_TANDY_SENS_MMAMIDIOUT* = 7
  MM_TANDY_SENS_VISWAVEOUT* = 8
  MM_TANDY_PSSJWAVEIN* = 9
  MM_TANDY_PSSJWAVEOUT* = 10
  MM_ANTEX_SX12_WAVEIN* = 1
  MM_ANTEX_SX12_WAVEOUT* = 2
  MM_ANTEX_SX15_WAVEIN* = 3
  MM_ANTEX_SX15_WAVEOUT* = 4
  MM_ANTEX_VP625_WAVEIN* = 5
  MM_ANTEX_VP625_WAVEOUT* = 6
  MM_ANTEX_AUDIOPORT22_WAVEIN* = 7
  MM_ANTEX_AUDIOPORT22_WAVEOUT* = 8
  MM_ANTEX_AUDIOPORT22_FEEDTHRU* = 9
  MM_INTELOPD_WAVEIN* = 1
  MM_INTELOPD_WAVEOUT* = 101
  MM_INTELOPD_AUX* = 401
  MM_INTEL_NSPMODEMLINEIN* = 501
  MM_INTEL_NSPMODEMLINEOUT* = 502
  MM_VAL_MICROKEY_AP_WAVEIN* = 1
  MM_VAL_MICROKEY_AP_WAVEOUT* = 2
  MM_INTERACTIVE_WAVEIN* = 0x45
  MM_INTERACTIVE_WAVEOUT* = 0x45
  MM_YAMAHA_GSS_SYNTH* = 0x01
  MM_YAMAHA_GSS_WAVEOUT* = 0x02
  MM_YAMAHA_GSS_WAVEIN* = 0x03
  MM_YAMAHA_GSS_MIDIOUT* = 0x04
  MM_YAMAHA_GSS_MIDIIN* = 0x05
  MM_YAMAHA_GSS_AUX* = 0x06
  MM_YAMAHA_SERIAL_MIDIOUT* = 0x07
  MM_YAMAHA_SERIAL_MIDIIN* = 0x08
  MM_YAMAHA_OPL3SA_WAVEOUT* = 0x10
  MM_YAMAHA_OPL3SA_WAVEIN* = 0x11
  MM_YAMAHA_OPL3SA_FMSYNTH* = 0x12
  MM_YAMAHA_OPL3SA_YSYNTH* = 0x13
  MM_YAMAHA_OPL3SA_MIDIOUT* = 0x14
  MM_YAMAHA_OPL3SA_MIDIIN* = 0x15
  MM_YAMAHA_OPL3SA_MIXER* = 0x17
  MM_YAMAHA_OPL3SA_JOYSTICK* = 0x18
  MM_YAMAHA_YMF724LEG_MIDIOUT* = 0x19
  MM_YAMAHA_YMF724LEG_MIDIIN* = 0x1a
  MM_YAMAHA_YMF724_WAVEOUT* = 0x1b
  MM_YAMAHA_YMF724_WAVEIN* = 0x1c
  MM_YAMAHA_YMF724_MIDIOUT* = 0x1d
  MM_YAMAHA_YMF724_AUX* = 0x1e
  MM_YAMAHA_YMF724_MIXER* = 0x1f
  MM_YAMAHA_YMF724LEG_FMSYNTH* = 0x20
  MM_YAMAHA_YMF724LEG_MIXER* = 0x21
  MM_YAMAHA_SXG_MIDIOUT* = 0x22
  MM_YAMAHA_SXG_WAVEOUT* = 0x23
  MM_YAMAHA_SXG_MIXER* = 0x24
  MM_YAMAHA_ACXG_WAVEIN* = 0x25
  MM_YAMAHA_ACXG_WAVEOUT* = 0x26
  MM_YAMAHA_ACXG_MIDIOUT* = 0x27
  MM_YAMAHA_ACXG_MIXER* = 0x28
  MM_YAMAHA_ACXG_AUX* = 0x29
  MM_EVEREX_CARRIER* = 1
  MM_ECHO_SYNTH* = 1
  MM_ECHO_WAVEOUT* = 2
  MM_ECHO_WAVEIN* = 3
  MM_ECHO_MIDIOUT* = 4
  MM_ECHO_MIDIIN* = 5
  MM_ECHO_AUX* = 6
  MM_SIERRA_ARIA_MIDIOUT* = 0x14
  MM_SIERRA_ARIA_MIDIIN* = 0x15
  MM_SIERRA_ARIA_SYNTH* = 0x16
  MM_SIERRA_ARIA_WAVEOUT* = 0x17
  MM_SIERRA_ARIA_WAVEIN* = 0x18
  MM_SIERRA_ARIA_AUX* = 0x19
  MM_SIERRA_ARIA_AUX2* = 0x20
  MM_SIERRA_QUARTET_WAVEIN* = 0x50
  MM_SIERRA_QUARTET_WAVEOUT* = 0x51
  MM_SIERRA_QUARTET_MIDIIN* = 0x52
  MM_SIERRA_QUARTET_MIDIOUT* = 0x53
  MM_SIERRA_QUARTET_SYNTH* = 0x54
  MM_SIERRA_QUARTET_AUX_CD* = 0x55
  MM_SIERRA_QUARTET_AUX_LINE* = 0x56
  MM_SIERRA_QUARTET_AUX_MODEM* = 0x57
  MM_SIERRA_QUARTET_MIXER* = 0x58
  MM_CAT_WAVEOUT* = 1
  MM_DSP_GROUP_TRUESPEECH* = 1
  MM_MELABS_MIDI2GO* = 1
  MM_ESS_AMWAVEOUT* = 0x01
  MM_ESS_AMWAVEIN* = 0x02
  MM_ESS_AMAUX* = 0x03
  MM_ESS_AMSYNTH* = 0x04
  MM_ESS_AMMIDIOUT* = 0x05
  MM_ESS_AMMIDIIN* = 0x06
  MM_ESS_MIXER* = 0x07
  MM_ESS_AUX_CD* = 0x08
  MM_ESS_MPU401_MIDIOUT* = 0x09
  MM_ESS_MPU401_MIDIIN* = 0x0a
  MM_ESS_ES488_WAVEOUT* = 0x10
  MM_ESS_ES488_WAVEIN* = 0x11
  MM_ESS_ES488_MIXER* = 0x12
  MM_ESS_ES688_WAVEOUT* = 0x13
  MM_ESS_ES688_WAVEIN* = 0x14
  MM_ESS_ES688_MIXER* = 0x15
  MM_ESS_ES1488_WAVEOUT* = 0x16
  MM_ESS_ES1488_WAVEIN* = 0x17
  MM_ESS_ES1488_MIXER* = 0x18
  MM_ESS_ES1688_WAVEOUT* = 0x19
  MM_ESS_ES1688_WAVEIN* = 0x1a
  MM_ESS_ES1688_MIXER* = 0x1b
  MM_ESS_ES1788_WAVEOUT* = 0x1c
  MM_ESS_ES1788_WAVEIN* = 0x1d
  MM_ESS_ES1788_MIXER* = 0x1e
  MM_ESS_ES1888_WAVEOUT* = 0x1f
  MM_ESS_ES1888_WAVEIN* = 0x20
  MM_ESS_ES1888_MIXER* = 0x21
  MM_ESS_ES1868_WAVEOUT* = 0x22
  MM_ESS_ES1868_WAVEIN* = 0x23
  MM_ESS_ES1868_MIXER* = 0x24
  MM_ESS_ES1878_WAVEOUT* = 0x25
  MM_ESS_ES1878_WAVEIN* = 0x26
  MM_ESS_ES1878_MIXER* = 0x27
  MM_CANOPUS_ACM_DVREX* = 1
  MM_EPS_FMSND* = 1
  MM_TRUEVISION_WAVEIN1* = 1
  MM_TRUEVISION_WAVEOUT1* = 2
  MM_AZTECH_MIDIOUT* = 3
  MM_AZTECH_MIDIIN* = 4
  MM_AZTECH_WAVEIN* = 17
  MM_AZTECH_WAVEOUT* = 18
  MM_AZTECH_FMSYNTH* = 20
  MM_AZTECH_MIXER* = 21
  MM_AZTECH_PRO16_WAVEIN* = 33
  MM_AZTECH_PRO16_WAVEOUT* = 34
  MM_AZTECH_PRO16_FMSYNTH* = 38
  MM_AZTECH_DSP16_WAVEIN* = 65
  MM_AZTECH_DSP16_WAVEOUT* = 66
  MM_AZTECH_DSP16_FMSYNTH* = 68
  MM_AZTECH_DSP16_WAVESYNTH* = 70
  MM_AZTECH_NOVA16_WAVEIN* = 71
  MM_AZTECH_NOVA16_WAVEOUT* = 72
  MM_AZTECH_NOVA16_MIXER* = 73
  MM_AZTECH_WASH16_WAVEIN* = 74
  MM_AZTECH_WASH16_WAVEOUT* = 75
  MM_AZTECH_WASH16_MIXER* = 76
  MM_AZTECH_AUX_CD* = 401
  MM_AZTECH_AUX_LINE* = 402
  MM_AZTECH_AUX_MIC* = 403
  MM_AZTECH_AUX* = 404
  MM_VIDEOLOGIC_MSWAVEIN* = 1
  MM_VIDEOLOGIC_MSWAVEOUT* = 2
  MM_KORG_PCIF_MIDIOUT* = 1
  MM_KORG_PCIF_MIDIIN* = 2
  MM_KORG_1212IO_MSWAVEIN* = 3
  MM_KORG_1212IO_MSWAVEOUT* = 4
  MM_APT_ACE100CD* = 1
  MM_ICS_WAVEDECK_WAVEOUT* = 1
  MM_ICS_WAVEDECK_WAVEIN* = 2
  MM_ICS_WAVEDECK_MIXER* = 3
  MM_ICS_WAVEDECK_AUX* = 4
  MM_ICS_WAVEDECK_SYNTH* = 5
  MM_ICS_WAVEDEC_SB_WAVEOUT* = 6
  MM_ICS_WAVEDEC_SB_WAVEIN* = 7
  MM_ICS_WAVEDEC_SB_FM_MIDIOUT* = 8
  MM_ICS_WAVEDEC_SB_MPU401_MIDIOUT* = 9
  MM_ICS_WAVEDEC_SB_MPU401_MIDIIN* = 10
  MM_ICS_WAVEDEC_SB_MIXER* = 11
  MM_ICS_WAVEDEC_SB_AUX* = 12
  MM_ICS_2115_LITE_MIDIOUT* = 13
  MM_ICS_2120_LITE_MIDIOUT* = 14
  MM_ITERATEDSYS_FUFCODEC* = 1
  MM_METHEUS_ZIPPER* = 1
  MM_WINNOV_CAVIAR_WAVEIN* = 1
  MM_WINNOV_CAVIAR_WAVEOUT* = 2
  MM_WINNOV_CAVIAR_VIDC* = 3
  MM_WINNOV_CAVIAR_CHAMPAGNE* = 4
  MM_WINNOV_CAVIAR_YUV8* = 5
  MM_NCR_BA_WAVEIN* = 1
  MM_NCR_BA_WAVEOUT* = 2
  MM_NCR_BA_SYNTH* = 3
  MM_NCR_BA_AUX* = 4
  MM_NCR_BA_MIXER* = 5
  MM_AST_MODEMWAVE_WAVEIN* = 13
  MM_AST_MODEMWAVE_WAVEOUT* = 14
  MM_WILLOWPOND_FMSYNTH_STEREO* = 20
  MM_WILLOWPOND_MPU401* = 21
  MM_WILLOWPOND_SNDPORT_WAVEIN* = 100
  MM_WILLOWPOND_SNDPORT_WAVEOUT* = 101
  MM_WILLOWPOND_SNDPORT_MIXER* = 102
  MM_WILLOWPOND_SNDPORT_AUX* = 103
  MM_WILLOWPOND_PH_WAVEIN* = 104
  MM_WILLOWPOND_PH_WAVEOUT* = 105
  MM_WILLOWPOND_PH_MIXER* = 106
  MM_WILLOWPOND_PH_AUX* = 107
  MM_WILLOPOND_SNDCOMM_WAVEIN* = 108
  MM_WILLOWPOND_SNDCOMM_WAVEOUT* = 109
  MM_WILLOWPOND_SNDCOMM_MIXER* = 110
  MM_WILLOWPOND_SNDCOMM_AUX* = 111
  MM_WILLOWPOND_GENERIC_WAVEIN* = 112
  MM_WILLOWPOND_GENERIC_WAVEOUT* = 113
  MM_WILLOWPOND_GENERIC_MIXER* = 114
  MM_WILLOWPOND_GENERIC_AUX* = 115
  MM_VITEC_VMAKER* = 1
  MM_VITEC_VMPRO* = 2
  MM_MOSCOM_VPC2400_IN* = 1
  MM_MOSCOM_VPC2400_OUT* = 2
  MM_SILICONSOFT_SC1_WAVEIN* = 1
  MM_SILICONSOFT_SC1_WAVEOUT* = 2
  MM_SILICONSOFT_SC2_WAVEIN* = 3
  MM_SILICONSOFT_SC2_WAVEOUT* = 4
  MM_SILICONSOFT_SOUNDJR2_WAVEOUT* = 5
  MM_SILICONSOFT_SOUNDJR2PR_WAVEIN* = 6
  MM_SILICONSOFT_SOUNDJR2PR_WAVEOUT* = 7
  MM_SILICONSOFT_SOUNDJR3_WAVEOUT* = 8
  MM_TTEWS_WAVEIN* = 1
  MM_TTEWS_WAVEOUT* = 2
  MM_TTEWS_MIDIIN* = 3
  MM_TTEWS_MIDIOUT* = 4
  MM_TTEWS_MIDISYNTH* = 5
  MM_TTEWS_MIDIMONITOR* = 6
  MM_TTEWS_VMIDIIN* = 7
  MM_TTEWS_VMIDIOUT* = 8
  MM_TTEWS_AUX* = 9
  MM_TTEWS_MIXER* = 10
  MM_MEDIASONIC_ACM_G723* = 1
  MM_MEDIASONIC_ICOM* = 2
  MM_ICOM_WAVEIN* = 3
  MM_ICOM_WAVEOUT* = 4
  MM_ICOM_MIXER* = 5
  MM_ICOM_AUX* = 6
  MM_ICOM_LINE* = 7
  MM_SANYO_ACM_LD_ADPCM* = 1
  MM_AHEAD_MULTISOUND* = 1
  MM_AHEAD_SOUNDBLASTER* = 2
  MM_AHEAD_PROAUDIO* = 3
  MM_AHEAD_GENERIC* = 4
  MM_OLIVETTI_WAVEIN* = 1
  MM_OLIVETTI_WAVEOUT* = 2
  MM_OLIVETTI_MIXER* = 3
  MM_OLIVETTI_AUX* = 4
  MM_OLIVETTI_MIDIIN* = 5
  MM_OLIVETTI_MIDIOUT* = 6
  MM_OLIVETTI_SYNTH* = 7
  MM_OLIVETTI_JOYSTICK* = 8
  MM_OLIVETTI_ACM_GSM* = 9
  MM_OLIVETTI_ACM_ADPCM* = 10
  MM_OLIVETTI_ACM_CELP* = 11
  MM_OLIVETTI_ACM_SBC* = 12
  MM_OLIVETTI_ACM_OPR* = 13
  MM_IOMAGIC_TEMPO_WAVEOUT* = 1
  MM_IOMAGIC_TEMPO_WAVEIN* = 2
  MM_IOMAGIC_TEMPO_SYNTH* = 3
  MM_IOMAGIC_TEMPO_MIDIOUT* = 4
  MM_IOMAGIC_TEMPO_MXDOUT* = 5
  MM_IOMAGIC_TEMPO_AUXOUT* = 6
  MM_MATSUSHITA_WAVEIN* = 1
  MM_MATSUSHITA_WAVEOUT* = 2
  MM_MATSUSHITA_FMSYNTH_STEREO* = 3
  MM_MATSUSHITA_MIXER* = 4
  MM_MATSUSHITA_AUX* = 5
  MM_NEWMEDIA_WAVJAMMER* = 1
  MM_LYRRUS_BRIDGE_GUITAR* = 1
  MM_OPTI_M16_FMSYNTH_STEREO* = 0x0001
  MM_OPTI_M16_MIDIIN* = 0x0002
  MM_OPTI_M16_MIDIOUT* = 0x0003
  MM_OPTI_M16_WAVEIN* = 0x0004
  MM_OPTI_M16_WAVEOUT* = 0x0005
  MM_OPTI_M16_MIXER* = 0x0006
  MM_OPTI_M16_AUX* = 0x0007
  MM_OPTI_P16_FMSYNTH_STEREO* = 0x0010
  MM_OPTI_P16_MIDIIN* = 0x0011
  MM_OPTI_P16_MIDIOUT* = 0x0012
  MM_OPTI_P16_WAVEIN* = 0x0013
  MM_OPTI_P16_WAVEOUT* = 0x0014
  MM_OPTI_P16_MIXER* = 0x0015
  MM_OPTI_P16_AUX* = 0x0016
  MM_OPTI_M32_WAVEIN* = 0x0020
  MM_OPTI_M32_WAVEOUT* = 0x0021
  MM_OPTI_M32_MIDIIN* = 0x0022
  MM_OPTI_M32_MIDIOUT* = 0x0023
  MM_OPTI_M32_SYNTH_STEREO* = 0x0024
  MM_OPTI_M32_MIXER* = 0x0025
  MM_OPTI_M32_AUX* = 0x0026
  MM_COMPAQ_BB_WAVEIN* = 1
  MM_COMPAQ_BB_WAVEOUT* = 2
  MM_COMPAQ_BB_WAVEAUX* = 3
  MM_MPTUS_SPWAVEOUT* = 1
  MM_LERNOUT_ANDHAUSPIE_LHCODECACM* = 1
  MM_DIGITAL_AV320_WAVEIN* = 1
  MM_DIGITAL_AV320_WAVEOUT* = 2
  MM_DIGITAL_ACM_G723* = 3
  MM_DIGITAL_ICM_H263* = 4
  MM_DIGITAL_ICM_H261* = 5
  MM_MOTU_MTP_MIDIOUT_ALL* = 100
  MM_MOTU_MTP_MIDIIN_1* = 101
  MM_MOTU_MTP_MIDIOUT_1* = 101
  MM_MOTU_MTP_MIDIIN_2* = 102
  MM_MOTU_MTP_MIDIOUT_2* = 102
  MM_MOTU_MTP_MIDIIN_3* = 103
  MM_MOTU_MTP_MIDIOUT_3* = 103
  MM_MOTU_MTP_MIDIIN_4* = 104
  MM_MOTU_MTP_MIDIOUT_4* = 104
  MM_MOTU_MTP_MIDIIN_5* = 105
  MM_MOTU_MTP_MIDIOUT_5* = 105
  MM_MOTU_MTP_MIDIIN_6* = 106
  MM_MOTU_MTP_MIDIOUT_6* = 106
  MM_MOTU_MTP_MIDIIN_7* = 107
  MM_MOTU_MTP_MIDIOUT_7* = 107
  MM_MOTU_MTP_MIDIIN_8* = 108
  MM_MOTU_MTP_MIDIOUT_8* = 108
  MM_MOTU_MTPII_MIDIOUT_ALL* = 200
  MM_MOTU_MTPII_MIDIIN_SYNC* = 200
  MM_MOTU_MTPII_MIDIIN_1* = 201
  MM_MOTU_MTPII_MIDIOUT_1* = 201
  MM_MOTU_MTPII_MIDIIN_2* = 202
  MM_MOTU_MTPII_MIDIOUT_2* = 202
  MM_MOTU_MTPII_MIDIIN_3* = 203
  MM_MOTU_MTPII_MIDIOUT_3* = 203
  MM_MOTU_MTPII_MIDIIN_4* = 204
  MM_MOTU_MTPII_MIDIOUT_4* = 204
  MM_MOTU_MTPII_MIDIIN_5* = 205
  MM_MOTU_MTPII_MIDIOUT_5* = 205
  MM_MOTU_MTPII_MIDIIN_6* = 206
  MM_MOTU_MTPII_MIDIOUT_6* = 206
  MM_MOTU_MTPII_MIDIIN_7* = 207
  MM_MOTU_MTPII_MIDIOUT_7* = 207
  MM_MOTU_MTPII_MIDIIN_8* = 208
  MM_MOTU_MTPII_MIDIOUT_8* = 208
  MM_MOTU_MTPII_NET_MIDIIN_1* = 209
  MM_MOTU_MTPII_NET_MIDIOUT_1* = 209
  MM_MOTU_MTPII_NET_MIDIIN_2* = 210
  MM_MOTU_MTPII_NET_MIDIOUT_2* = 210
  MM_MOTU_MTPII_NET_MIDIIN_3* = 211
  MM_MOTU_MTPII_NET_MIDIOUT_3* = 211
  MM_MOTU_MTPII_NET_MIDIIN_4* = 212
  MM_MOTU_MTPII_NET_MIDIOUT_4* = 212
  MM_MOTU_MTPII_NET_MIDIIN_5* = 213
  MM_MOTU_MTPII_NET_MIDIOUT_5* = 213
  MM_MOTU_MTPII_NET_MIDIIN_6* = 214
  MM_MOTU_MTPII_NET_MIDIOUT_6* = 214
  MM_MOTU_MTPII_NET_MIDIIN_7* = 215
  MM_MOTU_MTPII_NET_MIDIOUT_7* = 215
  MM_MOTU_MTPII_NET_MIDIIN_8* = 216
  MM_MOTU_MTPII_NET_MIDIOUT_8* = 216
  MM_MOTU_MXP_MIDIIN_MIDIOUT_ALL* = 300
  MM_MOTU_MXP_MIDIIN_SYNC* = 300
  MM_MOTU_MXP_MIDIIN_MIDIIN_1* = 301
  MM_MOTU_MXP_MIDIIN_MIDIOUT_1* = 301
  MM_MOTU_MXP_MIDIIN_MIDIIN_2* = 302
  MM_MOTU_MXP_MIDIIN_MIDIOUT_2* = 302
  MM_MOTU_MXP_MIDIIN_MIDIIN_3* = 303
  MM_MOTU_MXP_MIDIIN_MIDIOUT_3* = 303
  MM_MOTU_MXP_MIDIIN_MIDIIN_4* = 304
  MM_MOTU_MXP_MIDIIN_MIDIOUT_4* = 304
  MM_MOTU_MXP_MIDIIN_MIDIIN_5* = 305
  MM_MOTU_MXP_MIDIIN_MIDIOUT_5* = 305
  MM_MOTU_MXP_MIDIIN_MIDIIN_6* = 306
  MM_MOTU_MXP_MIDIIN_MIDIOUT_6* = 306
  MM_MOTU_MXPMPU_MIDIOUT_ALL* = 400
  MM_MOTU_MXPMPU_MIDIIN_SYNC* = 400
  MM_MOTU_MXPMPU_MIDIIN_1* = 401
  MM_MOTU_MXPMPU_MIDIOUT_1* = 401
  MM_MOTU_MXPMPU_MIDIIN_2* = 402
  MM_MOTU_MXPMPU_MIDIOUT_2* = 402
  MM_MOTU_MXPMPU_MIDIIN_3* = 403
  MM_MOTU_MXPMPU_MIDIOUT_3* = 403
  MM_MOTU_MXPMPU_MIDIIN_4* = 404
  MM_MOTU_MXPMPU_MIDIOUT_4* = 404
  MM_MOTU_MXPMPU_MIDIIN_5* = 405
  MM_MOTU_MXPMPU_MIDIOUT_5* = 405
  MM_MOTU_MXPMPU_MIDIIN_6* = 406
  MM_MOTU_MXPMPU_MIDIOUT_6* = 406
  MM_MOTU_MXN_MIDIOUT_ALL* = 500
  MM_MOTU_MXN_MIDIIN_SYNC* = 500
  MM_MOTU_MXN_MIDIIN_1* = 501
  MM_MOTU_MXN_MIDIOUT_1* = 501
  MM_MOTU_MXN_MIDIIN_2* = 502
  MM_MOTU_MXN_MIDIOUT_2* = 502
  MM_MOTU_MXN_MIDIIN_3* = 503
  MM_MOTU_MXN_MIDIOUT_3* = 503
  MM_MOTU_MXN_MIDIIN_4* = 504
  MM_MOTU_MXN_MIDIOUT_4* = 504
  MM_MOTU_FLYER_MIDI_IN_SYNC* = 600
  MM_MOTU_FLYER_MIDI_IN_A* = 601
  MM_MOTU_FLYER_MIDI_OUT_A* = 601
  MM_MOTU_FLYER_MIDI_IN_B* = 602
  MM_MOTU_FLYER_MIDI_OUT_B* = 602
  MM_MOTU_PKX_MIDI_IN_SYNC* = 700
  MM_MOTU_PKX_MIDI_IN_A* = 701
  MM_MOTU_PKX_MIDI_OUT_A* = 701
  MM_MOTU_PKX_MIDI_IN_B* = 702
  MM_MOTU_PKX_MIDI_OUT_B* = 702
  MM_MOTU_DTX_MIDI_IN_SYNC* = 800
  MM_MOTU_DTX_MIDI_IN_A* = 801
  MM_MOTU_DTX_MIDI_OUT_A* = 801
  MM_MOTU_DTX_MIDI_IN_B* = 802
  MM_MOTU_DTX_MIDI_OUT_B* = 802
  MM_MOTU_MTPAV_MIDIOUT_ALL* = 900
  MM_MOTU_MTPAV_MIDIIN_SYNC* = 900
  MM_MOTU_MTPAV_MIDIIN_1* = 901
  MM_MOTU_MTPAV_MIDIOUT_1* = 901
  MM_MOTU_MTPAV_MIDIIN_2* = 902
  MM_MOTU_MTPAV_MIDIOUT_2* = 902
  MM_MOTU_MTPAV_MIDIIN_3* = 903
  MM_MOTU_MTPAV_MIDIOUT_3* = 903
  MM_MOTU_MTPAV_MIDIIN_4* = 904
  MM_MOTU_MTPAV_MIDIOUT_4* = 904
  MM_MOTU_MTPAV_MIDIIN_5* = 905
  MM_MOTU_MTPAV_MIDIOUT_5* = 905
  MM_MOTU_MTPAV_MIDIIN_6* = 906
  MM_MOTU_MTPAV_MIDIOUT_6* = 906
  MM_MOTU_MTPAV_MIDIIN_7* = 907
  MM_MOTU_MTPAV_MIDIOUT_7* = 907
  MM_MOTU_MTPAV_MIDIIN_8* = 908
  MM_MOTU_MTPAV_MIDIOUT_8* = 908
  MM_MOTU_MTPAV_NET_MIDIIN_1* = 909
  MM_MOTU_MTPAV_NET_MIDIOUT_1* = 909
  MM_MOTU_MTPAV_NET_MIDIIN_2* = 910
  MM_MOTU_MTPAV_NET_MIDIOUT_2* = 910
  MM_MOTU_MTPAV_NET_MIDIIN_3* = 911
  MM_MOTU_MTPAV_NET_MIDIOUT_3* = 911
  MM_MOTU_MTPAV_NET_MIDIIN_4* = 912
  MM_MOTU_MTPAV_NET_MIDIOUT_4* = 912
  MM_MOTU_MTPAV_NET_MIDIIN_5* = 913
  MM_MOTU_MTPAV_NET_MIDIOUT_5* = 913
  MM_MOTU_MTPAV_NET_MIDIIN_6* = 914
  MM_MOTU_MTPAV_NET_MIDIOUT_6* = 914
  MM_MOTU_MTPAV_NET_MIDIIN_7* = 915
  MM_MOTU_MTPAV_NET_MIDIOUT_7* = 915
  MM_MOTU_MTPAV_NET_MIDIIN_8* = 916
  MM_MOTU_MTPAV_NET_MIDIOUT_8* = 916
  MM_MOTU_MTPAV_MIDIIN_ADAT* = 917
  MM_MOTU_MTPAV_MIDIOUT_ADAT* = 917
  MM_MOTU_MXPXT_MIDIIN_SYNC* = 1000
  MM_MOTU_MXPXT_MIDIOUT_ALL* = 1000
  MM_MOTU_MXPXT_MIDIIN_1* = 1001
  MM_MOTU_MXPXT_MIDIOUT_1* = 1001
  MM_MOTU_MXPXT_MIDIOUT_2* = 1002
  MM_MOTU_MXPXT_MIDIIN_2* = 1002
  MM_MOTU_MXPXT_MIDIIN_3* = 1003
  MM_MOTU_MXPXT_MIDIOUT_3* = 1003
  MM_MOTU_MXPXT_MIDIIN_4* = 1004
  MM_MOTU_MXPXT_MIDIOUT_4* = 1004
  MM_MOTU_MXPXT_MIDIIN_5* = 1005
  MM_MOTU_MXPXT_MIDIOUT_5* = 1005
  MM_MOTU_MXPXT_MIDIOUT_6* = 1006
  MM_MOTU_MXPXT_MIDIIN_6* = 1006
  MM_MOTU_MXPXT_MIDIOUT_7* = 1007
  MM_MOTU_MXPXT_MIDIIN_7* = 1007
  MM_MOTU_MXPXT_MIDIOUT_8* = 1008
  MM_MOTU_MXPXT_MIDIIN_8* = 1008
  MM_WORKBIT_MIXER* = 1
  MM_WORKBIT_WAVEOUT* = 2
  MM_WORKBIT_WAVEIN* = 3
  MM_WORKBIT_MIDIIN* = 4
  MM_WORKBIT_MIDIOUT* = 5
  MM_WORKBIT_FMSYNTH* = 6
  MM_WORKBIT_AUX* = 7
  MM_WORKBIT_JOYSTICK* = 8
  MM_OSITECH_TRUMPCARD* = 1
  MM_MIRO_MOVIEPRO* = 1
  MM_MIRO_VIDEOD1* = 2
  MM_MIRO_VIDEODC1TV* = 3
  MM_MIRO_VIDEOTD* = 4
  MM_MIRO_DC30_WAVEOUT* = 5
  MM_MIRO_DC30_WAVEIN* = 6
  MM_MIRO_DC30_MIX* = 7
  MM_ISOLUTION_PASCAL* = 1
  MM_VOICEMIXER* = 1
  ROCKWELL_WA1_WAVEIN* = 100
  ROCKWELL_WA1_WAVEOUT* = 101
  ROCKWELL_WA1_SYNTH* = 102
  ROCKWELL_WA1_MIXER* = 103
  ROCKWELL_WA1_MPU401_IN* = 104
  ROCKWELL_WA1_MPU401_OUT* = 105
  ROCKWELL_WA2_WAVEIN* = 200
  ROCKWELL_WA2_WAVEOUT* = 201
  ROCKWELL_WA2_SYNTH* = 202
  ROCKWELL_WA2_MIXER* = 203
  ROCKWELL_WA2_MPU401_IN* = 204
  ROCKWELL_WA2_MPU401_OUT* = 205
  MM_VOXWARE_CODEC* = 1
  MM_NORTEL_MPXAC_WAVEIN* = 1
  MM_NORTEL_MPXAC_WAVEOUT* = 2
  MM_ADDX_PCTV_DIGITALMIX* = 1
  MM_ADDX_PCTV_WAVEIN* = 2
  MM_ADDX_PCTV_WAVEOUT* = 3
  MM_ADDX_PCTV_MIXER* = 4
  MM_ADDX_PCTV_AUX_CD* = 5
  MM_ADDX_PCTV_AUX_LINE* = 6
  MM_WILDCAT_AUTOSCOREMIDIIN* = 1
  MM_RHETOREX_WAVEIN* = 1
  MM_RHETOREX_WAVEOUT* = 2
  MM_BTV_WAVEIN* = 1
  MM_BTV_WAVEOUT* = 2
  MM_BTV_MIDIIN* = 3
  MM_BTV_MIDIOUT* = 4
  MM_BTV_MIDISYNTH* = 5
  MM_BTV_AUX_LINE* = 6
  MM_BTV_AUX_MIC* = 7
  MM_BTV_AUX_CD* = 8
  MM_BTV_DIGITALIN* = 9
  MM_BTV_DIGITALOUT* = 10
  MM_BTV_MIDIWAVESTREAM* = 11
  MM_BTV_MIXER* = 12
  MM_ENSONIQ_SOUNDSCAPE* = 0x10
  MM_SOUNDSCAPE_WAVEOUT* = MM_ENSONIQ_SOUNDSCAPE+1
  MM_SOUNDSCAPE_WAVEOUT_AUX* = MM_ENSONIQ_SOUNDSCAPE+2
  MM_SOUNDSCAPE_WAVEIN* = MM_ENSONIQ_SOUNDSCAPE+3
  MM_SOUNDSCAPE_MIDIOUT* = MM_ENSONIQ_SOUNDSCAPE+4
  MM_SOUNDSCAPE_MIDIIN* = MM_ENSONIQ_SOUNDSCAPE+5
  MM_SOUNDSCAPE_SYNTH* = MM_ENSONIQ_SOUNDSCAPE+6
  MM_SOUNDSCAPE_MIXER* = MM_ENSONIQ_SOUNDSCAPE+7
  MM_SOUNDSCAPE_AUX* = MM_ENSONIQ_SOUNDSCAPE+8
  MM_NVIDIA_WAVEOUT* = 1
  MM_NVIDIA_WAVEIN* = 2
  MM_NVIDIA_MIDIOUT* = 3
  MM_NVIDIA_MIDIIN* = 4
  MM_NVIDIA_GAMEPORT* = 5
  MM_NVIDIA_MIXER* = 6
  MM_NVIDIA_AUX* = 7
  MM_OKSORI_BASE* = 0
  MM_OKSORI_OSR8_WAVEOUT* = MM_OKSORI_BASE+1
  MM_OKSORI_OSR8_WAVEIN* = MM_OKSORI_BASE+2
  MM_OKSORI_OSR16_WAVEOUT* = MM_OKSORI_BASE+3
  MM_OKSORI_OSR16_WAVEIN* = MM_OKSORI_BASE+4
  MM_OKSORI_FM_OPL4* = MM_OKSORI_BASE+5
  MM_OKSORI_MIX_MASTER* = MM_OKSORI_BASE+6
  MM_OKSORI_MIX_WAVE* = MM_OKSORI_BASE+7
  MM_OKSORI_MIX_FM* = MM_OKSORI_BASE+8
  MM_OKSORI_MIX_LINE* = MM_OKSORI_BASE+9
  MM_OKSORI_MIX_CD* = MM_OKSORI_BASE+10
  MM_OKSORI_MIX_MIC* = MM_OKSORI_BASE+11
  MM_OKSORI_MIX_ECHO* = MM_OKSORI_BASE+12
  MM_OKSORI_MIX_AUX1* = MM_OKSORI_BASE+13
  MM_OKSORI_MIX_LINE1* = MM_OKSORI_BASE+14
  MM_OKSORI_EXT_MIC1* = MM_OKSORI_BASE+15
  MM_OKSORI_EXT_MIC2* = MM_OKSORI_BASE+16
  MM_OKSORI_MIDIOUT* = MM_OKSORI_BASE+17
  MM_OKSORI_MIDIIN* = MM_OKSORI_BASE+18
  MM_OKSORI_MPEG_CDVISION* = MM_OKSORI_BASE+19
  MM_DIACOUSTICS_DRUM_ACTION* = 1
  MM_KAY_ELEMETRICS_CSL* = 0x4300
  MM_KAY_ELEMETRICS_CSL_DAT* = 0x4308
  MM_KAY_ELEMETRICS_CSL_4CHANNEL* = 0x4309
  MM_CRYSTAL_CS4232_WAVEIN* = 1
  MM_CRYSTAL_CS4232_WAVEOUT* = 2
  MM_CRYSTAL_CS4232_WAVEMIXER* = 3
  MM_CRYSTAL_CS4232_WAVEAUX_AUX1* = 4
  MM_CRYSTAL_CS4232_WAVEAUX_AUX2* = 5
  MM_CRYSTAL_CS4232_WAVEAUX_LINE* = 6
  MM_CRYSTAL_CS4232_WAVEAUX_MONO* = 7
  MM_CRYSTAL_CS4232_WAVEAUX_MASTER* = 8
  MM_CRYSTAL_CS4232_MIDIIN* = 9
  MM_CRYSTAL_CS4232_MIDIOUT* = 10
  MM_CRYSTAL_CS4232_INPUTGAIN_AUX1* = 13
  MM_CRYSTAL_CS4232_INPUTGAIN_LOOP* = 14
  MM_CRYSTAL_SOUND_FUSION_WAVEIN* = 21
  MM_CRYSTAL_SOUND_FUSION_WAVEOUT* = 22
  MM_CRYSTAL_SOUND_FUSION_MIXER* = 23
  MM_CRYSTAL_SOUND_FUSION_MIDIIN* = 24
  MM_CRYSTAL_SOUND_FUSION_MIDIOUT* = 25
  MM_CRYSTAL_SOUND_FUSION_JOYSTICK* = 26
  MM_QUARTERDECK_LHWAVEIN* = 0
  MM_QUARTERDECK_LHWAVEOUT* = 1
  MM_TDK_MW_MIDI_SYNTH* = 1
  MM_TDK_MW_MIDI_IN* = 2
  MM_TDK_MW_MIDI_OUT* = 3
  MM_TDK_MW_WAVE_IN* = 4
  MM_TDK_MW_WAVE_OUT* = 5
  MM_TDK_MW_AUX* = 6
  MM_TDK_MW_MIXER* = 10
  MM_TDK_MW_AUX_MASTER* = 100
  MM_TDK_MW_AUX_BASS* = 101
  MM_TDK_MW_AUX_TREBLE* = 102
  MM_TDK_MW_AUX_MIDI_VOL* = 103
  MM_TDK_MW_AUX_WAVE_VOL* = 104
  MM_TDK_MW_AUX_WAVE_RVB* = 105
  MM_TDK_MW_AUX_WAVE_CHR* = 106
  MM_TDK_MW_AUX_VOL* = 107
  MM_TDK_MW_AUX_RVB* = 108
  MM_TDK_MW_AUX_CHR* = 109
  MM_DIGITAL_AUDIO_LABS_TC* = 0x01
  MM_DIGITAL_AUDIO_LABS_DOC* = 0x02
  MM_DIGITAL_AUDIO_LABS_V8* = 0x10
  MM_DIGITAL_AUDIO_LABS_CPRO* = 0x11
  MM_DIGITAL_AUDIO_LABS_VP* = 0x12
  MM_DIGITAL_AUDIO_LABS_CDLX* = 0x13
  MM_DIGITAL_AUDIO_LABS_CTDIF* = 0x14
  MM_SEERSYS_SEERSYNTH* = 1
  MM_SEERSYS_SEERWAVE* = 2
  MM_SEERSYS_SEERMIX* = 3
  MM_SEERSYS_WAVESYNTH* = 4
  MM_SEERSYS_WAVESYNTH_WG* = 5
  MM_SEERSYS_REALITY* = 6
  MM_OSPREY_1000WAVEIN* = 1
  MM_OSPREY_1000WAVEOUT* = 2
  MM_SOUNDESIGNS_WAVEIN* = 1
  MM_SOUNDESIGNS_WAVEOUT* = 2
  MM_SSP_SNDFESWAVEIN* = 1
  MM_SSP_SNDFESWAVEOUT* = 2
  MM_SSP_SNDFESMIDIIN* = 3
  MM_SSP_SNDFESMIDIOUT* = 4
  MM_SSP_SNDFESSYNTH* = 5
  MM_SSP_SNDFESMIX* = 6
  MM_SSP_SNDFESAUX* = 7
  MM_ECS_AADF_MIDI_IN* = 10
  MM_ECS_AADF_MIDI_OUT* = 11
  MM_ECS_AADF_WAVE2MIDI_IN* = 12
  MM_AMD_INTERWAVE_WAVEIN* = 1
  MM_AMD_INTERWAVE_WAVEOUT* = 2
  MM_AMD_INTERWAVE_SYNTH* = 3
  MM_AMD_INTERWAVE_MIXER1* = 4
  MM_AMD_INTERWAVE_MIXER2* = 5
  MM_AMD_INTERWAVE_JOYSTICK* = 6
  MM_AMD_INTERWAVE_EX_CD* = 7
  MM_AMD_INTERWAVE_MIDIIN* = 8
  MM_AMD_INTERWAVE_MIDIOUT* = 9
  MM_AMD_INTERWAVE_AUX1* = 10
  MM_AMD_INTERWAVE_AUX2* = 11
  MM_AMD_INTERWAVE_AUX_MIC* = 12
  MM_AMD_INTERWAVE_AUX_CD* = 13
  MM_AMD_INTERWAVE_MONO_IN* = 14
  MM_AMD_INTERWAVE_MONO_OUT* = 15
  MM_AMD_INTERWAVE_EX_TELEPHONY* = 16
  MM_AMD_INTERWAVE_WAVEOUT_BASE* = 17
  MM_AMD_INTERWAVE_WAVEOUT_TREBLE* = 18
  MM_AMD_INTERWAVE_STEREO_ENHANCED* = 19
  MM_COREDYNAMICS_DYNAMIXHR* = 1
  MM_COREDYNAMICS_DYNASONIX_SYNTH* = 2
  MM_COREDYNAMICS_DYNASONIX_MIDI_IN* = 3
  MM_COREDYNAMICS_DYNASONIX_MIDI_OUT* = 4
  MM_COREDYNAMICS_DYNASONIX_WAVE_IN* = 5
  MM_COREDYNAMICS_DYNASONIX_WAVE_OUT* = 6
  MM_COREDYNAMICS_DYNASONIX_AUDIO_IN* = 7
  MM_COREDYNAMICS_DYNASONIX_AUDIO_OUT* = 8
  MM_COREDYNAMICS_DYNAGRAFX_VGA* = 9
  MM_COREDYNAMICS_DYNAGRAFX_WAVE_IN* = 10
  MM_COREDYNAMICS_DYNAGRAFX_WAVE_OUT* = 11
  MM_CANAM_CBXWAVEOUT* = 1
  MM_CANAM_CBXWAVEIN* = 2
  MM_SOFTSOUND_CODEC* = 1
  MM_NORRIS_VOICELINK* = 1
  MM_DDD_MIDILINK_MIDIIN* = 1
  MM_DDD_MIDILINK_MIDIOUT* = 2
  MM_EUPHONICS_AUX_CD* = 1
  MM_EUPHONICS_AUX_LINE* = 2
  MM_EUPHONICS_AUX_MASTER* = 3
  MM_EUPHONICS_AUX_MIC* = 4
  MM_EUPHONICS_AUX_MIDI* = 5
  MM_EUPHONICS_AUX_WAVE* = 6
  MM_EUPHONICS_FMSYNTH_MONO* = 7
  MM_EUPHONICS_FMSYNTH_STEREO* = 8
  MM_EUPHONICS_MIDIIN* = 9
  MM_EUPHONICS_MIDIOUT* = 10
  MM_EUPHONICS_MIXER* = 11
  MM_EUPHONICS_WAVEIN* = 12
  MM_EUPHONICS_WAVEOUT* = 13
  MM_EUPHONICS_EUSYNTH* = 14
  CRYSTAL_NET_SFM_CODEC* = 1
  MM_CHROMATIC_M1* = 0x0001
  MM_CHROMATIC_M1_WAVEIN* = 0x0002
  MM_CHROMATIC_M1_WAVEOUT* = 0x0003
  MM_CHROMATIC_M1_FMSYNTH* = 0x0004
  MM_CHROMATIC_M1_MIXER* = 0x0005
  MM_CHROMATIC_M1_AUX* = 0x0006
  MM_CHROMATIC_M1_AUX_CD* = 0x0007
  MM_CHROMATIC_M1_MIDIIN* = 0x0008
  MM_CHROMATIC_M1_MIDIOUT* = 0x0009
  MM_CHROMATIC_M1_WTSYNTH* = 0x0010
  MM_CHROMATIC_M1_MPEGWAVEIN* = 0x0011
  MM_CHROMATIC_M1_MPEGWAVEOUT* = 0x0012
  MM_CHROMATIC_M2* = 0x0013
  MM_CHROMATIC_M2_WAVEIN* = 0x0014
  MM_CHROMATIC_M2_WAVEOUT* = 0x0015
  MM_CHROMATIC_M2_FMSYNTH* = 0x0016
  MM_CHROMATIC_M2_MIXER* = 0x0017
  MM_CHROMATIC_M2_AUX* = 0x0018
  MM_CHROMATIC_M2_AUX_CD* = 0x0019
  MM_CHROMATIC_M2_MIDIIN* = 0x0020
  MM_CHROMATIC_M2_MIDIOUT* = 0x0021
  MM_CHROMATIC_M2_WTSYNTH* = 0x0022
  MM_CHROMATIC_M2_MPEGWAVEIN* = 0x0023
  MM_CHROMATIC_M2_MPEGWAVEOUT* = 0x0024
  MM_VIENNASYS_TSP_WAVE_DRIVER* = 1
  MM_CONNECTIX_VIDEC_CODEC* = 1
  MM_GADGETLABS_WAVE44_WAVEIN* = 1
  MM_GADGETLABS_WAVE44_WAVEOUT* = 2
  MM_GADGETLABS_WAVE42_WAVEIN* = 3
  MM_GADGETLABS_WAVE42_WAVEOUT* = 4
  MM_GADGETLABS_WAVE4_MIDIIN* = 5
  MM_GADGETLABS_WAVE4_MIDIOUT* = 6
  MM_FRONTIER_WAVECENTER_MIDIIN* = 1
  MM_FRONTIER_WAVECENTER_MIDIOUT* = 2
  MM_FRONTIER_WAVECENTER_WAVEIN* = 3
  MM_FRONTIER_WAVECENTER_WAVEOUT* = 4
  MM_VIONA_QVINPCI_MIXER* = 1
  MM_VIONA_QVINPCI_WAVEIN* = 2
  MM_VIONAQVINPCI_WAVEOUT* = 3
  MM_VIONA_BUSTER_MIXER* = 4
  MM_VIONA_CINEMASTER_MIXER* = 5
  MM_VIONA_CONCERTO_MIXER* = 6
  MM_CASIO_WP150_MIDIOUT* = 1
  MM_CASIO_WP150_MIDIIN* = 2
  MM_CASIO_LSG_MIDIOUT* = 3
  MM_DIMD_PLATFORM* = 0
  MM_DIMD_DIRSOUND* = 1
  MM_DIMD_VIRTMPU* = 2
  MM_DIMD_VIRTSB* = 3
  MM_DIMD_VIRTJOY* = 4
  MM_DIMD_WAVEIN* = 5
  MM_DIMD_WAVEOUT* = 6
  MM_DIMD_MIDIIN* = 7
  MM_DIMD_MIDIOUT* = 8
  MM_DIMD_AUX_LINE* = 9
  MM_DIMD_MIXER* = 10
  MM_DIMD_WSS_WAVEIN* = 14
  MM_DIMD_WSS_WAVEOUT* = 15
  MM_DIMD_WSS_MIXER* = 17
  MM_DIMD_WSS_AUX* = 21
  MM_DIMD_WSS_SYNTH* = 76
  MM_S3_WAVEOUT* = 1
  MM_S3_WAVEIN* = 2
  MM_S3_MIDIOUT* = 3
  MM_S3_MIDIIN* = 4
  MM_S3_FMSYNTH* = 5
  MM_S3_MIXER* = 6
  MM_S3_AUX* = 7
  MM_VKC_MPU401_MIDIIN* = 0x0100
  MM_VKC_SERIAL_MIDIIN* = 0x0101
  MM_VKC_MPU401_MIDIOUT* = 0x0200
  MM_VKC_SERIAL_MIDIOUT* = 0x0201
  MM_ZEFIRO_ZA2* = 2
  MM_FHGIIS_MPEGLAYER3_DECODE* = 9
  MM_FHGIIS_MPEGLAYER3* = 10
  MM_FHGIIS_MPEGLAYER3_LITE* = 10
  MM_FHGIIS_MPEGLAYER3_BASIC* = 11
  MM_FHGIIS_MPEGLAYER3_ADVANCED* = 12
  MM_FHGIIS_MPEGLAYER3_PROFESSIONAL* = 13
  MM_FHGIIS_MPEGLAYER3_ADVANCEDPLUS* = 14
  MM_QUICKNET_PJWAVEIN* = 1
  MM_QUICKNET_PJWAVEOUT* = 2
  MM_SICRESOURCE_SSO3D* = 2
  MM_SICRESOURCE_SSOW3DI* = 3
  MM_NEOMAGIC_SYNTH* = 1
  MM_NEOMAGIC_WAVEOUT* = 2
  MM_NEOMAGIC_WAVEIN* = 3
  MM_NEOMAGIC_MIDIOUT* = 4
  MM_NEOMAGIC_MIDIIN* = 5
  MM_NEOMAGIC_AUX* = 6
  MM_NEOMAGIC_MW3DX_WAVEOUT* = 10
  MM_NEOMAGIC_MW3DX_WAVEIN* = 11
  MM_NEOMAGIC_MW3DX_MIDIOUT* = 12
  MM_NEOMAGIC_MW3DX_MIDIIN* = 13
  MM_NEOMAGIC_MW3DX_FMSYNTH* = 14
  MM_NEOMAGIC_MW3DX_GMSYNTH* = 15
  MM_NEOMAGIC_MW3DX_MIXER* = 16
  MM_NEOMAGIC_MW3DX_AUX* = 17
  MM_NEOMAGIC_MWAVE_WAVEOUT* = 20
  MM_NEOMAGIC_MWAVE_WAVEIN* = 21
  MM_NEOMAGIC_MWAVE_MIDIOUT* = 22
  MM_NEOMAGIC_MWAVE_MIDIIN* = 23
  MM_NEOMAGIC_MWAVE_MIXER* = 24
  MM_NEOMAGIC_MWAVE_AUX* = 25
  MM_MERGING_MPEGL3* = 1
  MM_XIRLINK_VISIONLINK* = 1
  MM_OTI_611WAVEIN* = 5
  MM_OTI_611WAVEOUT* = 6
  MM_OTI_611MIXER* = 7
  MM_OTI_611MIDIN* = 0x12
  MM_OTI_611MIDIOUT* = 0x13
  MM_AUREAL_AU8820* = 16
  MM_AU8820_SYNTH* = 17
  MM_AU8820_WAVEOUT* = 18
  MM_AU8820_WAVEIN* = 19
  MM_AU8820_MIXER* = 20
  MM_AU8820_AUX* = 21
  MM_AU8820_MIDIOUT* = 22
  MM_AU8820_MIDIIN* = 23
  MM_AUREAL_AU8830* = 32
  MM_AU8830_SYNTH* = 33
  MM_AU8830_WAVEOUT* = 34
  MM_AU8830_WAVEIN* = 35
  MM_AU8830_MIXER* = 36
  MM_AU8830_AUX* = 37
  MM_AU8830_MIDIOUT* = 38
  MM_AU8830_MIDIIN* = 39
  MM_VIVO_AUDIO_CODEC* = 1
  MM_SHARP_MDC_MIDI_SYNTH* = 1
  MM_SHARP_MDC_MIDI_IN* = 2
  MM_SHARP_MDC_MIDI_OUT* = 3
  MM_SHARP_MDC_WAVE_IN* = 4
  MM_SHARP_MDC_WAVE_OUT* = 5
  MM_SHARP_MDC_AUX* = 6
  MM_SHARP_MDC_MIXER* = 10
  MM_SHARP_MDC_AUX_MASTER* = 100
  MM_SHARP_MDC_AUX_BASS* = 101
  MM_SHARP_MDC_AUX_TREBLE* = 102
  MM_SHARP_MDC_AUX_MIDI_VOL* = 103
  MM_SHARP_MDC_AUX_WAVE_VOL* = 104
  MM_SHARP_MDC_AUX_WAVE_RVB* = 105
  MM_SHARP_MDC_AUX_WAVE_CHR* = 106
  MM_SHARP_MDC_AUX_VOL* = 107
  MM_SHARP_MDC_AUX_RVB* = 108
  MM_SHARP_MDC_AUX_CHR* = 109
  MM_LUCENT_ACM_G723* = 0
  MM_ATT_G729A* = 1
  MM_MARIAN_ARC44WAVEIN* = 1
  MM_MARIAN_ARC44WAVEOUT* = 2
  MM_MARIAN_PRODIF24WAVEIN* = 3
  MM_MARIAN_PRODIF24WAVEOUT* = 4
  MM_MARIAN_ARC88WAVEIN* = 5
  MM_MARIAN_ARC88WAVEOUT* = 6
  MM_BCB_NETBOARD_10* = 1
  MM_BCB_TT75_10* = 2
  MM_MOTIONPIXELS_MVI2* = 1
  MM_QDESIGN_ACM_MPEG* = 1
  MM_QDESIGN_ACM_QDESIGN_MUSIC* = 2
  MM_NMP_CCP_WAVEIN* = 1
  MM_NMP_CCP_WAVEOUT* = 2
  MM_NMP_ACM_AMR* = 10
  MM_DF_ACM_G726* = 1
  MM_DF_ACM_GSM610* = 2
  MM_BERCOS_WAVEIN* = 1
  MM_BERCOS_MIXER* = 2
  MM_BERCOS_WAVEOUT* = 3
  MM_ONLIVE_MPCODEC* = 1
  MM_PHONET_PP_WAVEOUT* = 1
  MM_PHONET_PP_WAVEIN* = 2
  MM_PHONET_PP_MIXER* = 3
  MM_FTR_ENCODER_WAVEIN* = 1
  MM_FTR_ACM* = 2
  MM_ENET_T2000_LINEIN* = 1
  MM_ENET_T2000_LINEOUT* = 2
  MM_ENET_T2000_HANDSETIN* = 3
  MM_ENET_T2000_HANDSETOUT* = 4
  MM_EMAGIC_UNITOR8* = 1
  MM_SIPROLAB_ACELPNET* = 1
  MM_DICTAPHONE_G726* = 1
  MM_RZS_ACM_TUBGSM* = 1
  MM_EES_PCMIDI14* = 1
  MM_EES_PCMIDI14_IN* = 2
  MM_EES_PCMIDI14_OUT1* = 3
  MM_EES_PCMIDI14_OUT2* = 4
  MM_EES_PCMIDI14_OUT3* = 5
  MM_EES_PCMIDI14_OUT4* = 6
  MM_HAFTMANN_LPTDAC2* = 1
  MM_LUCID_PCI24WAVEIN* = 1
  MM_LUCID_PCI24WAVEOUT* = 2
  MM_HEADSPACE_HAESYNTH* = 1
  MM_HEADSPACE_HAEWAVEOUT* = 2
  MM_HEADSPACE_HAEWAVEIN* = 3
  MM_HEADSPACE_HAEMIXER* = 4
  MM_UNISYS_ACM_NAP* = 1
  MM_LUMINOSITI_SCWAVEIN* = 1
  MM_LUMINOSITI_SCWAVEOUT* = 2
  MM_LUMINOSITI_SCWAVEMIX* = 3
  MM_ACTIVEVOICE_ACM_VOXADPCM* = 1
  MM_DTS_DS* = 1
  MM_SOFTLAB_NSK_FRW_WAVEIN* = 1
  MM_SOFTLAB_NSK_FRW_WAVEOUT* = 2
  MM_SOFTLAB_NSK_FRW_MIXER* = 3
  MM_SOFTLAB_NSK_FRW_AUX* = 4
  MM_FORTEMEDIA_WAVEIN* = 1
  MM_FORTEMEDIA_WAVEOUT* = 2
  MM_FORTEMEDIA_FMSYNC* = 3
  MM_FORTEMEDIA_MIXER* = 4
  MM_FORTEMEDIA_AUX* = 5
  MM_SONORUS_STUDIO* = 1
  MM_I_LINK_VOICE_CODER* = 1
  MM_SELSIUS_SYSTEMS_RTPWAVEOUT* = 1
  MM_SELSIUS_SYSTEMS_RTPWAVEIN* = 2
  MM_ADMOS_FM_SYNTH* = 1
  MM_ADMOS_QS3AMIDIOUT* = 2
  MM_ADMOS_QS3AMIDIIN* = 3
  MM_ADMOS_QS3AWAVEOUT* = 4
  MM_ADMOS_QS3AWAVEIN* = 5
  MM_LEXICON_STUDIO_WAVE_OUT* = 1
  MM_LEXICON_STUDIO_WAVE_IN* = 2
  MM_SGI_320_WAVEIN* = 1
  MM_SGI_320_WAVEOUT* = 2
  MM_SGI_320_MIXER* = 3
  MM_SGI_540_WAVEIN* = 4
  MM_SGI_540_WAVEOUT* = 5
  MM_SGI_540_MIXER* = 6
  MM_SGI_RAD_ADATMONO1_WAVEIN* = 7
  MM_SGI_RAD_ADATMONO2_WAVEIN* = 8
  MM_SGI_RAD_ADATMONO3_WAVEIN* = 9
  MM_SGI_RAD_ADATMONO4_WAVEIN* = 10
  MM_SGI_RAD_ADATMONO5_WAVEIN* = 11
  MM_SGI_RAD_ADATMONO6_WAVEIN* = 12
  MM_SGI_RAD_ADATMONO7_WAVEIN* = 13
  MM_SGI_RAD_ADATMONO8_WAVEIN* = 14
  MM_SGI_RAD_ADATSTEREO12_WAVEIN* = 15
  MM_SGI_RAD_ADATSTEREO34_WAVEIN* = 16
  MM_SGI_RAD_ADATSTEREO56_WAVEIN* = 17
  MM_SGI_RAD_ADATSTEREO78_WAVEIN* = 18
  MM_SGI_RAD_ADAT8CHAN_WAVEIN* = 19
  MM_SGI_RAD_ADATMONO1_WAVEOUT* = 20
  MM_SGI_RAD_ADATMONO2_WAVEOUT* = 21
  MM_SGI_RAD_ADATMONO3_WAVEOUT* = 22
  MM_SGI_RAD_ADATMONO4_WAVEOUT* = 23
  MM_SGI_RAD_ADATMONO5_WAVEOUT* = 24
  MM_SGI_RAD_ADATMONO6_WAVEOUT* = 25
  MM_SGI_RAD_ADATMONO7_WAVEOUT* = 26
  MM_SGI_RAD_ADATMONO8_WAVEOUT* = 27
  MM_SGI_RAD_ADATSTEREO12_WAVEOUT* = 28
  MM_SGI_RAD_ADATSTEREO32_WAVEOUT* = 29
  MM_SGI_RAD_ADATSTEREO56_WAVEOUT* = 30
  MM_SGI_RAD_ADATSTEREO78_WAVEOUT* = 31
  MM_SGI_RAD_ADAT8CHAN_WAVEOUT* = 32
  MM_SGI_RAD_AESMONO1_WAVEIN* = 33
  MM_SGI_RAD_AESMONO2_WAVEIN* = 34
  MM_SGI_RAD_AESSTEREO_WAVEIN* = 35
  MM_SGI_RAD_AESMONO1_WAVEOUT* = 36
  MM_SGI_RAD_AESMONO2_WAVEOUT* = 37
  MM_SGI_RAD_AESSTEREO_WAVEOUT* = 38
  MM_IPI_ACM_HSX* = 1
  MM_IPI_ACM_RPELP* = 2
  MM_IPI_WF_ASSS* = 3
  MM_IPI_AT_WAVEOUT* = 4
  MM_IPI_AT_WAVEIN* = 5
  MM_IPI_AT_MIXER* = 6
  MM_ICE_WAVEOUT* = 1
  MM_ICE_WAVEIN* = 2
  MM_ICE_MTWAVEOUT* = 3
  MM_ICE_MTWAVEIN* = 4
  MM_ICE_MIDIOUT1* = 5
  MM_ICE_MIDIIN1* = 6
  MM_ICE_MIDIOUT2* = 7
  MM_ICE_MIDIIN2* = 8
  MM_ICE_SYNTH* = 9
  MM_ICE_MIXER* = 10
  MM_ICE_AUX* = 11
  MM_VQST_VQC1* = 1
  MM_VQST_VQC2* = 2
  MM_ETEK_KWIKMIDI_MIDIIN* = 1
  MM_ETEK_KWIKMIDI_MIDIOUT* = 2
  MM_INTERNET_SSW_MIDIOUT* = 10
  MM_INTERNET_SSW_MIDIIN* = 11
  MM_INTERNET_SSW_WAVEOUT* = 12
  MM_INTERNET_SSW_WAVEIN* = 13
  MM_SONY_ACM_SCX* = 1
  MM_UH_ACM_ADPCM* = 1
  MM_SYDEC_NV_WAVEIN* = 1
  MM_SYDEC_NV_WAVEOUT* = 2
  MM_FLEXION_X300_WAVEIN* = 1
  MM_FLEXION_X300_WAVEOUT* = 2
  MM_VIA_WAVEOUT* = 1
  MM_VIA_WAVEIN* = 2
  MM_VIA_MIXER* = 3
  MM_VIA_AUX* = 4
  MM_VIA_MPU401_MIDIOUT* = 5
  MM_VIA_MPU401_MIDIIN* = 6
  MM_VIA_SWFM_SYNTH* = 7
  MM_VIA_WDM_WAVEOUT* = 8
  MM_VIA_WDM_WAVEIN* = 9
  MM_VIA_WDM_MIXER* = 10
  MM_VIA_WDM_MPU401_MIDIOUT* = 11
  MM_VIA_WDM_MPU401_MIDIIN* = 12
  MM_MICRONAS_SC4* = 1
  MM_MICRONAS_CLP833* = 2
  MM_HP_WAVEOUT* = 1
  MM_HP_WAVEIN* = 2
  MM_QUICKAUDIO_MINIMIDI* = 1
  MM_QUICKAUDIO_MAXIMIDI* = 2
  MM_ICCC_UNA3_WAVEIN* = 1
  MM_ICCC_UNA3_WAVEOUT* = 2
  MM_ICCC_UNA3_AUX* = 3
  MM_ICCC_UNA3_MIXER* = 4
  MM_3COM_CB_MIXER* = 1
  MM_3COM_CB_WAVEIN* = 2
  MM_3COM_CB_WAVEOUT* = 3
  MM_MINDMAKER_GC_WAVEIN* = 1
  MM_MINDMAKER_GC_WAVEOUT* = 2
  MM_MINDMAKER_GC_MIXER* = 3
  MM_TELEKOL_WAVEOUT* = 1
  MM_TELEKOL_WAVEIN* = 2
  MM_ALGOVISION_VB80WAVEOUT* = 1
  MM_ALGOVISION_VB80WAVEIN* = 2
  MM_ALGOVISION_VB80MIXER* = 3
  MM_ALGOVISION_VB80AUX* = 4
  MM_ALGOVISION_VB80AUX2* = 5
template mmioFOURCC*(c0: untyped, c1: untyped, c2: untyped, c3: untyped): untyped = c0.DWORD or (c1.DWORD shl 8) or (c2.DWORD shl 16) or (c3.DWORD shl 24)
const
  RIFFINFO_IARL* = mmioFOURCC('I', 'A', 'R', 'L')
  RIFFINFO_IART* = mmioFOURCC('I', 'A', 'R', 'T')
  RIFFINFO_ICMS* = mmioFOURCC('I', 'C', 'M', 'S')
  RIFFINFO_ICMT* = mmioFOURCC('I', 'C', 'M', 'T')
  RIFFINFO_ICOP* = mmioFOURCC('I', 'C', 'O', 'P')
  RIFFINFO_ICRD* = mmioFOURCC('I', 'C', 'R', 'D')
  RIFFINFO_ICRP* = mmioFOURCC('I', 'C', 'R', 'P')
  RIFFINFO_IDIM* = mmioFOURCC('I', 'D', 'I', 'M')
  RIFFINFO_IDPI* = mmioFOURCC('I', 'D', 'P', 'I')
  RIFFINFO_IENG* = mmioFOURCC('I', 'E', 'N', 'G')
  RIFFINFO_IGNR* = mmioFOURCC('I', 'G', 'N', 'R')
  RIFFINFO_IKEY* = mmioFOURCC('I', 'K', 'E', 'Y')
  RIFFINFO_ILGT* = mmioFOURCC('I', 'L', 'G', 'T')
  RIFFINFO_IMED* = mmioFOURCC('I', 'M', 'E', 'D')
  RIFFINFO_INAM* = mmioFOURCC('I', 'N', 'A', 'M')
  RIFFINFO_IPLT* = mmioFOURCC('I', 'P', 'L', 'T')
  RIFFINFO_IPRD* = mmioFOURCC('I', 'P', 'R', 'D')
  RIFFINFO_ISBJ* = mmioFOURCC('I', 'S', 'B', 'J')
  RIFFINFO_ISFT* = mmioFOURCC('I', 'S', 'F', 'T')
  RIFFINFO_ISHP* = mmioFOURCC('I', 'S', 'H', 'P')
  RIFFINFO_ISRC* = mmioFOURCC('I', 'S', 'R', 'C')
  RIFFINFO_ISRF* = mmioFOURCC('I', 'S', 'R', 'F')
  RIFFINFO_ITCH* = mmioFOURCC('I', 'T', 'C', 'H')
  RIFFINFO_ISMP* = mmioFOURCC('I', 'S', 'M', 'P')
  RIFFINFO_IDIT* = mmioFOURCC('I', 'D', 'I', 'T')
  RIFFINFO_ITRK* = mmioFOURCC('I', 'T', 'R', 'K')
  RIFFINFO_ITOC* = mmioFOURCC('I', 'T', 'O', 'C')
  WAVE_FORMAT_UNKNOWN* = 0x0000
  WAVE_FORMAT_ADPCM* = 0x0002
  WAVE_FORMAT_IEEE_FLOAT* = 0x0003
  WAVE_FORMAT_VSELP* = 0x0004
  WAVE_FORMAT_IBM_CVSD* = 0x0005
  WAVE_FORMAT_ALAW* = 0x0006
  WAVE_FORMAT_MULAW* = 0x0007
  WAVE_FORMAT_DTS* = 0x0008
  WAVE_FORMAT_DRM* = 0x0009
  WAVE_FORMAT_WMAVOICE9* = 0x000a
  WAVE_FORMAT_WMAVOICE10* = 0x000b
  WAVE_FORMAT_OKI_ADPCM* = 0x0010
  WAVE_FORMAT_DVI_ADPCM* = 0x0011
  WAVE_FORMAT_IMA_ADPCM* = WAVE_FORMAT_DVI_ADPCM
  WAVE_FORMAT_MEDIASPACE_ADPCM* = 0x0012
  WAVE_FORMAT_SIERRA_ADPCM* = 0x0013
  WAVE_FORMAT_G723_ADPCM* = 0x0014
  WAVE_FORMAT_DIGISTD* = 0x0015
  WAVE_FORMAT_DIGIFIX* = 0x0016
  WAVE_FORMAT_DIALOGIC_OKI_ADPCM* = 0x0017
  WAVE_FORMAT_MEDIAVISION_ADPCM* = 0x0018
  WAVE_FORMAT_CU_CODEC* = 0x0019
  WAVE_FORMAT_HP_DYN_VOICE* = 0x001a
  WAVE_FORMAT_YAMAHA_ADPCM* = 0x0020
  WAVE_FORMAT_SONARC* = 0x0021
  WAVE_FORMAT_DSPGROUP_TRUESPEECH* = 0x0022
  WAVE_FORMAT_ECHOSC1* = 0x0023
  WAVE_FORMAT_AUDIOFILE_AF36* = 0x0024
  WAVE_FORMAT_APTX* = 0x0025
  WAVE_FORMAT_AUDIOFILE_AF10* = 0x0026
  WAVE_FORMAT_PROSODY_1612* = 0x0027
  WAVE_FORMAT_LRC* = 0x0028
  WAVE_FORMAT_DOLBY_AC2* = 0x0030
  WAVE_FORMAT_MSNAUDIO* = 0x0032
  WAVE_FORMAT_ANTEX_ADPCME* = 0x0033
  WAVE_FORMAT_CONTROL_RES_VQLPC* = 0x0034
  WAVE_FORMAT_DIGIREAL* = 0x0035
  WAVE_FORMAT_DIGIADPCM* = 0x0036
  WAVE_FORMAT_CONTROL_RES_CR10* = 0x0037
  WAVE_FORMAT_NMS_VBXADPCM* = 0x0038
  WAVE_FORMAT_CS_IMAADPCM* = 0x0039
  WAVE_FORMAT_ECHOSC3* = 0x003a
  WAVE_FORMAT_ROCKWELL_ADPCM* = 0x003b
  WAVE_FORMAT_ROCKWELL_DIGITALK* = 0x003c
  WAVE_FORMAT_XEBEC* = 0x003d
  WAVE_FORMAT_G721_ADPCM* = 0x0040
  WAVE_FORMAT_G728_CELP* = 0x0041
  WAVE_FORMAT_MSG723* = 0x0042
  WAVE_FORMAT_INTEL_G723_1* = 0x0043
  WAVE_FORMAT_INTEL_G729* = 0x0044
  WAVE_FORMAT_SHARP_G726* = 0x0045
  WAVE_FORMAT_MPEG* = 0x0050
  WAVE_FORMAT_RT24* = 0x0052
  WAVE_FORMAT_PAC* = 0x0053
  WAVE_FORMAT_MPEGLAYER3* = 0x0055
  WAVE_FORMAT_LUCENT_G723* = 0x0059
  WAVE_FORMAT_CIRRUS* = 0x0060
  WAVE_FORMAT_ESPCM* = 0x0061
  WAVE_FORMAT_VOXWARE* = 0x0062
  WAVE_FORMAT_CANOPUS_ATRAC* = 0x0063
  WAVE_FORMAT_G726_ADPCM* = 0x0064
  WAVE_FORMAT_G722_ADPCM* = 0x0065
  WAVE_FORMAT_DSAT* = 0x0066
  WAVE_FORMAT_DSAT_DISPLAY* = 0x0067
  WAVE_FORMAT_VOXWARE_BYTE_ALIGNED* = 0x0069
  WAVE_FORMAT_VOXWARE_AC8* = 0x0070
  WAVE_FORMAT_VOXWARE_AC10* = 0x0071
  WAVE_FORMAT_VOXWARE_AC16* = 0x0072
  WAVE_FORMAT_VOXWARE_AC20* = 0x0073
  WAVE_FORMAT_VOXWARE_RT24* = 0x0074
  WAVE_FORMAT_VOXWARE_RT29* = 0x0075
  WAVE_FORMAT_VOXWARE_RT29HW* = 0x0076
  WAVE_FORMAT_VOXWARE_VR12* = 0x0077
  WAVE_FORMAT_VOXWARE_VR18* = 0x0078
  WAVE_FORMAT_VOXWARE_TQ40* = 0x0079
  WAVE_FORMAT_VOXWARE_SC3* = 0x007a
  WAVE_FORMAT_VOXWARE_SC3_1* = 0x007b
  WAVE_FORMAT_SOFTSOUND* = 0x0080
  WAVE_FORMAT_VOXWARE_TQ60* = 0x0081
  WAVE_FORMAT_MSRT24* = 0x0082
  WAVE_FORMAT_G729A* = 0x0083
  WAVE_FORMAT_MVI_MVI2* = 0x0084
  WAVE_FORMAT_DF_G726* = 0x0085
  WAVE_FORMAT_DF_GSM610* = 0x0086
  WAVE_FORMAT_ISIAUDIO* = 0x0088
  WAVE_FORMAT_ONLIVE* = 0x0089
  WAVE_FORMAT_MULTITUDE_FT_SX20* = 0x008a
  WAVE_FORMAT_INFOCOM_ITS_G721_ADPCM* = 0x008b
  WAVE_FORMAT_CONVEDIA_G729* = 0x008c
  WAVE_FORMAT_CONGRUENCY* = 0x008d
  WAVE_FORMAT_SBC24* = 0x0091
  WAVE_FORMAT_DOLBY_AC3_SPDIF* = 0x0092
  WAVE_FORMAT_MEDIASONIC_G723* = 0x0093
  WAVE_FORMAT_PROSODY_8KBPS* = 0x0094
  WAVE_FORMAT_ZYXEL_ADPCM* = 0x0097
  WAVE_FORMAT_PHILIPS_LPCBB* = 0x0098
  WAVE_FORMAT_PACKED* = 0x0099
  WAVE_FORMAT_MALDEN_PHONYTALK* = 0x00a0
  WAVE_FORMAT_RACAL_RECORDER_GSM* = 0x00a1
  WAVE_FORMAT_RACAL_RECORDER_G720_A* = 0x00a2
  WAVE_FORMAT_RACAL_RECORDER_G723_1* = 0x00a3
  WAVE_FORMAT_RACAL_RECORDER_TETRA_ACELP* = 0x00a4
  WAVE_FORMAT_NEC_AAC* = 0x00b0
  WAVE_FORMAT_RAW_AAC1* = 0x00ff
  WAVE_FORMAT_RHETOREX_ADPCM* = 0x0100
  WAVE_FORMAT_IRAT* = 0x0101
  WAVE_FORMAT_VIVO_G723* = 0x0111
  WAVE_FORMAT_VIVO_SIREN* = 0x0112
  WAVE_FORMAT_PHILIPS_CELP* = 0x0120
  WAVE_FORMAT_PHILIPS_GRUNDIG* = 0x0121
  WAVE_FORMAT_DIGITAL_G723* = 0x0123
  WAVE_FORMAT_SANYO_LD_ADPCM* = 0x0125
  WAVE_FORMAT_SIPROLAB_ACEPLNET* = 0x0130
  WAVE_FORMAT_SIPROLAB_ACELP4800* = 0x0131
  WAVE_FORMAT_SIPROLAB_ACELP8V3* = 0x0132
  WAVE_FORMAT_SIPROLAB_G729* = 0x0133
  WAVE_FORMAT_SIPROLAB_G729A* = 0x0134
  WAVE_FORMAT_SIPROLAB_KELVIN* = 0x0135
  WAVE_FORMAT_VOICEAGE_AMR* = 0x0136
  WAVE_FORMAT_DICTAPHONE_CELP68* = 0x0141
  WAVE_FORMAT_DICTAPHONE_CELP54* = 0x0142
  WAVE_FORMAT_QUALCOMM_PUREVOICE* = 0x0150
  WAVE_FORMAT_QUALCOMM_HALFRATE* = 0x0151
  WAVE_FORMAT_TUBGSM* = 0x0155
  WAVE_FORMAT_MSAUDIO1* = 0x0160
  WAVE_FORMAT_WMAUDIO2* = 0x0161
  WAVE_FORMAT_WMAUDIO3* = 0x0162
  WAVE_FORMAT_WMAUDIO_LOSSLESS* = 0x0163
  WAVE_FORMAT_WMASPDIF* = 0x0164
  WAVE_FORMAT_UNISYS_NAP_ADPCM* = 0x0170
  WAVE_FORMAT_UNISYS_NAP_ULAW* = 0x0171
  WAVE_FORMAT_UNISYS_NAP_ALAW* = 0x0172
  WAVE_FORMAT_UNISYS_NAP_16K* = 0x0173
  WAVE_FORMAT_SYCOM_ACM_SYC008* = 0x0174
  WAVE_FORMAT_SYCOM_ACM_SYC701_G726L* = 0x0175
  WAVE_FORMAT_SYCOM_ACM_SYC701_CELP54* = 0x0176
  WAVE_FORMAT_SYCOM_ACM_SYC701_CELP68* = 0x0177
  WAVE_FORMAT_KNOWLEDGE_ADVENTURE_ADPCM* = 0x0178
  WAVE_FORMAT_FRAUNHOFER_IIS_MPEG2_AAC* = 0x0180
  WAVE_FORMAT_DTS_DS* = 0x0190
  WAVE_FORMAT_CREATIVE_ADPCM* = 0x0200
  WAVE_FORMAT_CREATIVE_FASTSPEECH8* = 0x0202
  WAVE_FORMAT_CREATIVE_FASTSPEECH10* = 0x0203
  WAVE_FORMAT_UHER_ADPCM* = 0x0210
  WAVE_FORMAT_ULEAD_DV_AUDIO* = 0x0215
  WAVE_FORMAT_ULEAD_DV_AUDIO_1* = 0x0216
  WAVE_FORMAT_QUARTERDECK* = 0x0220
  WAVE_FORMAT_ILINK_VC* = 0x0230
  WAVE_FORMAT_RAW_SPORT* = 0x0240
  WAVE_FORMAT_ESST_AC3* = 0x0241
  WAVE_FORMAT_GENERIC_PASSTHRU* = 0x0249
  WAVE_FORMAT_IPI_HSX* = 0x0250
  WAVE_FORMAT_IPI_RPELP* = 0x0251
  WAVE_FORMAT_CS2* = 0x0260
  WAVE_FORMAT_SONY_SCX* = 0x0270
  WAVE_FORMAT_SONY_SCY* = 0x0271
  WAVE_FORMAT_SONY_ATRAC3* = 0x0272
  WAVE_FORMAT_SONY_SPC* = 0x0273
  WAVE_FORMAT_TELUM_AUDIO* = 0x0280
  WAVE_FORMAT_TELUM_IA_AUDIO* = 0x0281
  WAVE_FORMAT_NORCOM_VOICE_SYSTEMS_ADPCM* = 0x0285
  WAVE_FORMAT_FM_TOWNS_SND* = 0x0300
  WAVE_FORMAT_MICRONAS* = 0x0350
  WAVE_FORMAT_MICRONAS_CELP833* = 0x0351
  WAVE_FORMAT_BTV_DIGITAL* = 0x0400
  WAVE_FORMAT_INTEL_MUSIC_CODER* = 0x0401
  WAVE_FORMAT_INDEO_AUDIO* = 0x0402
  WAVE_FORMAT_QDESIGN_MUSIC* = 0x0450
  WAVE_FORMAT_ON2_VP7_AUDIO* = 0x0500
  WAVE_FORMAT_ON2_VP6_AUDIO* = 0x0501
  WAVE_FORMAT_VME_VMPCM* = 0x0680
  WAVE_FORMAT_TPC* = 0x0681
  WAVE_FORMAT_LIGHTWAVE_LOSSLESS* = 0x08ae
  WAVE_FORMAT_OLIGSM* = 0x1000
  WAVE_FORMAT_OLIADPCM* = 0x1001
  WAVE_FORMAT_OLICELP* = 0x1002
  WAVE_FORMAT_OLISBC* = 0x1003
  WAVE_FORMAT_OLIOPR* = 0x1004
  WAVE_FORMAT_LH_CODEC* = 0x1100
  WAVE_FORMAT_LH_CODEC_CELP* = 0x1101
  WAVE_FORMAT_LH_CODEC_SBC8* = 0x1102
  WAVE_FORMAT_LH_CODEC_SBC12* = 0x1103
  WAVE_FORMAT_LH_CODEC_SBC16* = 0x1104
  WAVE_FORMAT_NORRIS* = 0x1400
  WAVE_FORMAT_ISIAUDIO_2* = 0x1401
  WAVE_FORMAT_SOUNDSPACE_MUSICOMPRESS* = 0x1500
  WAVE_FORMAT_MPEG_ADTS_AAC* = 0x1600
  WAVE_FORMAT_MPEG_RAW_AAC* = 0x1601
  WAVE_FORMAT_MPEG_LOAS* = 0x1602
  WAVE_FORMAT_NOKIA_MPEG_ADTS_AAC* = 0x1608
  WAVE_FORMAT_NOKIA_MPEG_RAW_AAC* = 0x1609
  WAVE_FORMAT_VODAFONE_MPEG_ADTS_AAC* = 0x160a
  WAVE_FORMAT_VODAFONE_MPEG_RAW_AAC* = 0x160b
  WAVE_FORMAT_MPEG_HEAAC* = 0x1610
  WAVE_FORMAT_VOXWARE_RT24_SPEECH* = 0x181c
  WAVE_FORMAT_SONICFOUNDRY_LOSSLESS* = 0x1971
  WAVE_FORMAT_INNINGS_TELECOM_ADPCM* = 0x1979
  WAVE_FORMAT_LUCENT_SX8300P* = 0x1c07
  WAVE_FORMAT_LUCENT_SX5363S* = 0x1c0c
  WAVE_FORMAT_CUSEEME* = 0x1f03
  WAVE_FORMAT_NTCSOFT_ALF2CM_ACM* = 0x1fc4
  WAVE_FORMAT_DVM* = 0x2000
  WAVE_FORMAT_DTS2* = 0x2001
  WAVE_FORMAT_MAKEAVIS* = 0x3313
  WAVE_FORMAT_DIVIO_MPEG4_AAC* = 0x4143
  WAVE_FORMAT_NOKIA_ADAPTIVE_MULTIRATE* = 0x4201
  WAVE_FORMAT_DIVIO_G726* = 0x4243
  WAVE_FORMAT_LEAD_SPEECH* = 0x434c
  WAVE_FORMAT_LEAD_VORBIS* = 0x564c
  WAVE_FORMAT_WAVPACK_AUDIO* = 0x5756
  WAVE_FORMAT_OGG_VORBIS_MODE_1* = 0x674f
  WAVE_FORMAT_OGG_VORBIS_MODE_2* = 0x6750
  WAVE_FORMAT_OGG_VORBIS_MODE_3* = 0x6751
  WAVE_FORMAT_OGG_VORBIS_MODE_1_PLUS* = 0x676f
  WAVE_FORMAT_OGG_VORBIS_MODE_2_PLUS* = 0x6770
  WAVE_FORMAT_OGG_VORBIS_MODE_3_PLUS* = 0x6771
  WAVE_FORMAT_3COM_NBX* = 0x7000
  WAVE_FORMAT_FAAD_AAC* = 0x706d
  WAVE_FORMAT_GSM_AMR_CBR* = 0x7a21
  WAVE_FORMAT_GSM_AMR_VBR_SID* = 0x7a22
  WAVE_FORMAT_COMVERSE_INFOSYS_G723_1* = 0xa100
  WAVE_FORMAT_COMVERSE_INFOSYS_AVQSBC* = 0xa101
  WAVE_FORMAT_COMVERSE_INFOSYS_SBC* = 0xa102
  WAVE_FORMAT_SYMBOL_G729_A* = 0xa103
  WAVE_FORMAT_VOICEAGE_AMR_WB* = 0xa104
  WAVE_FORMAT_INGENIENT_G726* = 0xa105
  WAVE_FORMAT_MPEG4_AAC* = 0xa106
  WAVE_FORMAT_ENCORE_G726* = 0xa107
  WAVE_FORMAT_ZOLL_ASAO* = 0xa108
  WAVE_FORMAT_SPEEX_VOICE* = 0xa109
  WAVE_FORMAT_VIANIX_MASC* = 0xa10a
  WAVE_FORMAT_WM9_SPECTRUM_ANALYZER* = 0xa10b
  WAVE_FORMAT_WMF_SPECTRUM_ANAYZER* = 0xa10c
  WAVE_FORMAT_GSM_610* = 0xa10d
  WAVE_FORMAT_GSM_620* = 0xa10e
  WAVE_FORMAT_GSM_660* = 0xa10f
  WAVE_FORMAT_GSM_690* = 0xa110
  WAVE_FORMAT_GSM_ADAPTIVE_MULTIRATE_WB* = 0xa111
  WAVE_FORMAT_POLYCOM_G722* = 0xa112
  WAVE_FORMAT_POLYCOM_G728* = 0xa113
  WAVE_FORMAT_POLYCOM_G729_A* = 0xa114
  WAVE_FORMAT_POLYCOM_SIREN* = 0xa115
  WAVE_FORMAT_GLOBAL_IP_ILBC* = 0xa116
  WAVE_FORMAT_RADIOTIME_TIME_SHIFT_RADIO* = 0xa117
  WAVE_FORMAT_NICE_ACA* = 0xa118
  WAVE_FORMAT_NICE_ADPCM* = 0xa119
  WAVE_FORMAT_VOCORD_G721* = 0xa11a
  WAVE_FORMAT_VOCORD_G726* = 0xa11b
  WAVE_FORMAT_VOCORD_G722_1* = 0xa11c
  WAVE_FORMAT_VOCORD_G728* = 0xa11d
  WAVE_FORMAT_VOCORD_G729* = 0xa11e
  WAVE_FORMAT_VOCORD_G729_A* = 0xa11f
  WAVE_FORMAT_VOCORD_G723_1* = 0xa120
  WAVE_FORMAT_VOCORD_LBC* = 0xa121
  WAVE_FORMAT_NICE_G728* = 0xa122
  WAVE_FORMAT_FRACE_TELECOM_G729* = 0xa123
  WAVE_FORMAT_CODIAN* = 0xa124
  WAVE_FORMAT_FLAC* = 0xf1ac
  WAVE_FORMAT_EXTENSIBLE* = 0xfffe
  WAVE_FORMAT_DEVELOPMENT* = 0xffff
  STATIC_KSDATAFORMAT_SUBTYPE_PCM* = DEFINE_GUID("00000001-0000-0010-8000-00aa00389b71")
  KSDATAFORMAT_SUBTYPE_PCM* = DEFINE_GUID("00000001-0000-0010-8000-00aa00389b71")
  STATIC_KSDATAFORMAT_SUBTYPE_IEEE_FLOAT* = DEFINE_GUID("00000003-0000-0010-8000-00aa00389b71")
  KSDATAFORMAT_SUBTYPE_IEEE_FLOAT* = DEFINE_GUID("00000003-0000-0010-8000-00aa00389b71")
  STATIC_KSDATAFORMAT_SUBTYPE_WAVEFORMATEX* = 0x00000000
  KSDATAFORMAT_SUBTYPE_WAVEFORMATEX* = DEFINE_GUID("00000000-0000-0010-8000-00aa00389b71")
  SPEAKER_FRONT_LEFT* = 0x1
  SPEAKER_FRONT_RIGHT* = 0x2
  SPEAKER_FRONT_CENTER* = 0x4
  SPEAKER_LOW_FREQUENCY* = 0x8
  SPEAKER_BACK_LEFT* = 0x10
  SPEAKER_BACK_RIGHT* = 0x20
  SPEAKER_FRONT_LEFT_OF_CENTER* = 0x40
  SPEAKER_FRONT_RIGHT_OF_CENTER* = 0x80
  SPEAKER_BACK_CENTER* = 0x100
  SPEAKER_SIDE_LEFT* = 0x200
  SPEAKER_SIDE_RIGHT* = 0x400
  SPEAKER_TOP_CENTER* = 0x800
  SPEAKER_TOP_FRONT_LEFT* = 0x1000
  SPEAKER_TOP_FRONT_CENTER* = 0x2000
  SPEAKER_TOP_FRONT_RIGHT* = 0x4000
  SPEAKER_TOP_BACK_LEFT* = 0x8000
  SPEAKER_TOP_BACK_CENTER* = 0x10000
  SPEAKER_TOP_BACK_RIGHT* = 0x20000
  SPEAKER_RESERVED* = 0x7ffc0000
  SPEAKER_ALL* = 0x80000000'i32
  ACM_MPEG_LAYER1* = 0x0001
  ACM_MPEG_LAYER2* = 0x0002
  ACM_MPEG_LAYER3* = 0x0004
  ACM_MPEG_STEREO* = 0x0001
  ACM_MPEG_JOINTSTEREO* = 0x0002
  ACM_MPEG_DUALCHANNEL* = 0x0004
  ACM_MPEG_SINGLECHANNEL* = 0x0008
  ACM_MPEG_PRIVATEBIT* = 0x0001
  ACM_MPEG_COPYRIGHT* = 0x0002
  ACM_MPEG_ORIGINALHOME* = 0x0004
  ACM_MPEG_PROTECTIONBIT* = 0x0008
  ACM_MPEG_ID_MPEG1* = 0x0010
  MPEGLAYER3_WFX_EXTRA_BYTES* = 12
  MPEGLAYER3_ID_UNKNOWN* = 0
  MPEGLAYER3_ID_MPEG* = 1
  MPEGLAYER3_ID_CONSTANTFRAMESIZE* = 2
  MPEGLAYER3_FLAG_PADDING_ISO* = 0x00000000
  MPEGLAYER3_FLAG_PADDING_ON* = 0x00000001
  MPEGLAYER3_FLAG_PADDING_OFF* = 0x00000002
  MM_MSFT_ACM_WMAUDIO* = 39
  MM_MSFT_ACM_MSAUDIO1* = 39
  WMAUDIO_BITS_PER_SAMPLE* = 16
  WMAUDIO_MAX_CHANNELS* = 2
  MSAUDIO1_BITS_PER_SAMPLE* = WMAUDIO_BITS_PER_SAMPLE
  MSAUDIO1_MAX_CHANNELS* = WMAUDIO_MAX_CHANNELS
  MM_MSFT_ACM_WMAUDIO2* = 101
  WMAUDIO2_BITS_PER_SAMPLE* = WMAUDIO_BITS_PER_SAMPLE
  WMAUDIO2_MAX_CHANNELS* = WMAUDIO_MAX_CHANNELS
  WAVE_FILTER_UNKNOWN* = 0x0000
  WAVE_FILTER_DEVELOPMENT* = 0xffff
  WAVE_FILTER_VOLUME* = 0x0001
  WAVE_FILTER_ECHO* = 0x0002
  RIFFWAVE_inst* = mmioFOURCC('i', 'n', 's', 't')
  RIFFCPPO* = mmioFOURCC('C', 'P', 'P', 'O')
  RIFFCPPO_objr* = mmioFOURCC('o', 'b', 'j', 'r')
  RIFFCPPO_obji* = mmioFOURCC('o', 'b', 'j', 'i')
  RIFFCPPO_clsr* = mmioFOURCC('c', 'l', 's', 'r')
  RIFFCPPO_clsi* = mmioFOURCC('c', 'l', 's', 'i')
  RIFFCPPO_mbr* = mmioFOURCC('m', 'b', 'r', ' ')
  RIFFCPPO_char* = mmioFOURCC('c', 'h', 'a', 'r')
  RIFFCPPO_byte* = mmioFOURCC('b', 'y', 't', 'e')
  RIFFCPPO_int* = mmioFOURCC('i', 'n', 't', ' ')
  RIFFCPPO_word* = mmioFOURCC('w', 'o', 'r', 'd')
  RIFFCPPO_long* = mmioFOURCC('l', 'o', 'n', 'g')
  RIFFCPPO_dwrd* = mmioFOURCC('d', 'w', 'r', 'd')
  RIFFCPPO_flt* = mmioFOURCC('f', 'l', 't', ' ')
  RIFFCPPO_dbl* = mmioFOURCC('d', 'b', 'l', ' ')
  RIFFCPPO_str* = mmioFOURCC('s', 't', 'r', ' ')
  BICOMP_IBMULTIMOTION* = mmioFOURCC('U', 'L', 'T', 'I')
  BICOMP_IBMPHOTOMOTION* = mmioFOURCC('P', 'H', 'M', 'O')
  BICOMP_CREATIVEYUV* = mmioFOURCC('c', 'y', 'u', 'v')
  JPEG_DIB* = mmioFOURCC('J', 'P', 'E', 'G')
  MJPG_DIB* = mmioFOURCC('M', 'J', 'P', 'G')
  JPEG_PROCESS_BASELINE* = 0
  AVIIF_CONTROLFRAME* = 0x00000200
  JIFMK_SOF0* = 0xffc0
  JIFMK_SOF1* = 0xffc1
  JIFMK_SOF2* = 0xffc2
  JIFMK_SOF3* = 0xffc3
  JIFMK_SOF5* = 0xffc5
  JIFMK_SOF6* = 0xffc6
  JIFMK_SOF7* = 0xffc7
  JIFMK_JPG* = 0xffc8
  JIFMK_SOF9* = 0xffc9
  JIFMK_SOF10* = 0xffca
  JIFMK_SOF11* = 0xffcb
  JIFMK_SOF13* = 0xffcd
  JIFMK_SOF14* = 0xffce
  JIFMK_SOF15* = 0xffcf
  JIFMK_DHT* = 0xffc4
  JIFMK_DAC* = 0xffcc
  JIFMK_RST0* = 0xffd0
  JIFMK_RST1* = 0xffd1
  JIFMK_RST2* = 0xffd2
  JIFMK_RST3* = 0xffd3
  JIFMK_RST4* = 0xffd4
  JIFMK_RST5* = 0xffd5
  JIFMK_RST6* = 0xffd6
  JIFMK_RST7* = 0xffd7
  JIFMK_SOI* = 0xffd8
  JIFMK_EOI* = 0xffd9
  JIFMK_SOS* = 0xffda
  JIFMK_DQT* = 0xffdb
  JIFMK_DNL* = 0xffdc
  JIFMK_DRI* = 0xffdd
  JIFMK_DHP* = 0xffde
  JIFMK_EXP* = 0xffdf
  JIFMK_APP0* = 0xffe0
  JIFMK_APP1* = 0xffe1
  JIFMK_APP2* = 0xffe2
  JIFMK_APP3* = 0xffe3
  JIFMK_APP4* = 0xffe4
  JIFMK_APP5* = 0xffe5
  JIFMK_APP6* = 0xffe6
  JIFMK_APP7* = 0xffe7
  JIFMK_JPG0* = 0xfff0
  JIFMK_JPG1* = 0xfff1
  JIFMK_JPG2* = 0xfff2
  JIFMK_JPG3* = 0xfff3
  JIFMK_JPG4* = 0xfff4
  JIFMK_JPG5* = 0xfff5
  JIFMK_JPG6* = 0xfff6
  JIFMK_JPG7* = 0xfff7
  JIFMK_JPG8* = 0xfff8
  JIFMK_JPG9* = 0xfff9
  JIFMK_JPG10* = 0xfffa
  JIFMK_JPG11* = 0xfffb
  JIFMK_JPG12* = 0xfffc
  JIFMK_JPG13* = 0xfffd
  JIFMK_COM* = 0xfffe
  JIFMK_TEM* = 0xff01
  JIFMK_RES* = 0xff02
  JIFMK_00* = 0xff00
  JIFMK_FF* = 0xffff
  JPEG_Y* = 1
  JPEG_YCbCr* = 2
  JPEG_RGB* = 3
  ICTYPE_VIDEO* = mmioFOURCC('v', 'i', 'd', 'c')
  ICTYPE_AUDIO* = mmioFOURCC('a', 'u', 'd', 'c')
  FOURCC_RDSP* = mmioFOURCC('R', 'D', 'S', 'P')
  MIXERCONTROL_CONTROLTYPE_SRS_MTS* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+6
  MIXERCONTROL_CONTROLTYPE_SRS_ONOFF* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+7
  MIXERCONTROL_CONTROLTYPE_SRS_SYNTHSELECT* = MIXERCONTROL_CONTROLTYPE_BOOLEAN+8
  SND_ALIAS_SYSTEMASTERISK* = 0x00002A53
  SND_ALIAS_SYSTEMQUESTION* = 0x00003F53
  SND_ALIAS_SYSTEMHAND* = 0x00004853
  SND_ALIAS_SYSTEMEXIT* = 0x00004553
  SND_ALIAS_SYSTEMSTART* = 0x00005353
  SND_ALIAS_SYSTEMWELCOME* = 0x00005753
  SND_ALIAS_SYSTEMEXCLAMATION* = 0x00002153
  SND_ALIAS_SYSTEMDEFAULT* = 0x00004453
  FOURCC_RIFF* = 0x46464952
  FOURCC_LIST* = 0x5453494C
  FOURCC_DOS* = 0x20534F44
  FOURCC_MEM* = 0x204D454D
  JOY_POVCENTERED* = not WORD(0)
type
  DRIVERPROC* = proc (P1: DWORD_PTR, P2: HDRVR, P3: UINT, P4: LPARAM, P5: LPARAM): LRESULT {.stdcall.}
  YIELDPROC* = proc (mciId: MCIDEVICEID, dwYieldData: DWORD): UINT {.stdcall.}
  MIDIEVENT* {.pure.} = object
    dwDeltaTime*: DWORD
    dwStreamID*: DWORD
    dwEvent*: DWORD
    dwParms*: array[1, DWORD]
  MIDISTRMBUFFVER* {.pure.} = object
    dwVersion*: DWORD
    dwMid*: DWORD
    dwOEMVersion*: DWORD
  DOLBYAC2WAVEFORMAT* {.pure, packed.} = object
    wfx*: WAVEFORMATEX
    nAuxBitsCode*: WORD
  s_RIFFWAVE_inst* {.pure.} = object
    bUnshiftedNote*: BYTE
    chFineTune*: char
    chGain*: char
    bLowNote*: BYTE
    bHighNote*: BYTE
    bLowVelocity*: BYTE
    bHighVelocity*: BYTE
  EXBMINFOHEADER* {.pure.} = object
    bmi*: BITMAPINFOHEADER
    biExtDataOffset*: DWORD
  JPEGINFOHEADER* {.pure.} = object
    JPEGSize*: DWORD
    JPEGProcess*: DWORD
    JPEGColorSpaceID*: DWORD
    JPEGBitsPerSample*: DWORD
    JPEGHSubSampling*: DWORD
    JPEGVSubSampling*: DWORD
proc CloseDriver*(hDriver: HDRVR, lParam1: LPARAM, lParam2: LPARAM): LRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc OpenDriver*(szDriverName: LPCWSTR, szSectionName: LPCWSTR, lParam2: LPARAM): HDRVR {.winapi, stdcall, dynlib: "winmm", importc.}
proc SendDriverMessage*(hDriver: HDRVR, message: UINT, lParam1: LPARAM, lParam2: LPARAM): LRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc DrvGetModuleHandle*(hDriver: HDRVR): HMODULE {.winapi, stdcall, dynlib: "winmm", importc.}
proc GetDriverModuleHandle*(hDriver: HDRVR): HMODULE {.winapi, stdcall, dynlib: "winmm", importc.}
proc DefDriverProc*(dwDriverIdentifier: DWORD_PTR, hdrvr: HDRVR, uMsg: UINT, lParam1: LPARAM, lParam2: LPARAM): LRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc sndPlaySoundA*(pszSound: LPCSTR, fuSound: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc sndPlaySoundW*(pszSound: LPCWSTR, fuSound: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc PlaySoundA*(pszSound: LPCSTR, hmod: HMODULE, fdwSound: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc PlaySoundW*(pszSound: LPCWSTR, hmod: HMODULE, fdwSound: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetDevCapsA*(uDeviceID: UINT_PTR, pwoc: LPWAVEOUTCAPSA, cbwoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetDevCapsW*(uDeviceID: UINT_PTR, pwoc: LPWAVEOUTCAPSW, cbwoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetVolume*(hwo: HWAVEOUT, pdwVolume: LPDWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutSetVolume*(hwo: HWAVEOUT, dwVolume: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetErrorTextA*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetErrorTextW*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutOpen*(phwo: LPHWAVEOUT, uDeviceID: UINT, pwfx: LPCWAVEFORMATEX, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutClose*(hwo: HWAVEOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutPrepareHeader*(hwo: HWAVEOUT, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutUnprepareHeader*(hwo: HWAVEOUT, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutWrite*(hwo: HWAVEOUT, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutPause*(hwo: HWAVEOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutRestart*(hwo: HWAVEOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutReset*(hwo: HWAVEOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutBreakLoop*(hwo: HWAVEOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetPosition*(hwo: HWAVEOUT, pmmt: LPMMTIME, cbmmt: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetPitch*(hwo: HWAVEOUT, pdwPitch: LPDWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutSetPitch*(hwo: HWAVEOUT, dwPitch: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetPlaybackRate*(hwo: HWAVEOUT, pdwRate: LPDWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutSetPlaybackRate*(hwo: HWAVEOUT, dwRate: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutGetID*(hwo: HWAVEOUT, puDeviceID: LPUINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveOutMessage*(hwo: HWAVEOUT, uMsg: UINT, dw1: DWORD_PTR, dw2: DWORD_PTR): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetDevCapsA*(uDeviceID: UINT_PTR, pwic: LPWAVEINCAPSA, cbwic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetDevCapsW*(uDeviceID: UINT_PTR, pwic: LPWAVEINCAPSW, cbwic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetErrorTextA*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetErrorTextW*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInOpen*(phwi: LPHWAVEIN, uDeviceID: UINT, pwfx: LPCWAVEFORMATEX, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInClose*(hwi: HWAVEIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInPrepareHeader*(hwi: HWAVEIN, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInUnprepareHeader*(hwi: HWAVEIN, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInAddBuffer*(hwi: HWAVEIN, pwh: LPWAVEHDR, cbwh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInStart*(hwi: HWAVEIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInStop*(hwi: HWAVEIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInReset*(hwi: HWAVEIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetPosition*(hwi: HWAVEIN, pmmt: LPMMTIME, cbmmt: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInGetID*(hwi: HWAVEIN, puDeviceID: LPUINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc waveInMessage*(hwi: HWAVEIN, uMsg: UINT, dw1: DWORD_PTR, dw2: DWORD_PTR): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamOpen*(phms: LPHMIDISTRM, puDeviceID: LPUINT, cMidi: DWORD, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamClose*(hms: HMIDISTRM): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamProperty*(hms: HMIDISTRM, lppropdata: LPBYTE, dwProperty: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamPosition*(hms: HMIDISTRM, lpmmt: LPMMTIME, cbmmt: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamOut*(hms: HMIDISTRM, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamPause*(hms: HMIDISTRM): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamRestart*(hms: HMIDISTRM): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiStreamStop*(hms: HMIDISTRM): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiConnect*(hmi: HMIDI, hmo: HMIDIOUT, pReserved: LPVOID): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiDisconnect*(hmi: HMIDI, hmo: HMIDIOUT, pReserved: LPVOID): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetDevCapsA*(uDeviceID: UINT_PTR, pmoc: LPMIDIOUTCAPSA, cbmoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetDevCapsW*(uDeviceID: UINT_PTR, pmoc: LPMIDIOUTCAPSW, cbmoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetVolume*(hmo: HMIDIOUT, pdwVolume: LPDWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutSetVolume*(hmo: HMIDIOUT, dwVolume: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetErrorTextA*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetErrorTextW*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutOpen*(phmo: LPHMIDIOUT, uDeviceID: UINT, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutClose*(hmo: HMIDIOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutPrepareHeader*(hmo: HMIDIOUT, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutUnprepareHeader*(hmo: HMIDIOUT, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutShortMsg*(hmo: HMIDIOUT, dwMsg: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutLongMsg*(hmo: HMIDIOUT, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutReset*(hmo: HMIDIOUT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutCachePatches*(hmo: HMIDIOUT, uBank: UINT, pwpa: LPWORD, fuCache: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutCacheDrumPatches*(hmo: HMIDIOUT, uPatch: UINT, pwkya: LPWORD, fuCache: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutGetID*(hmo: HMIDIOUT, puDeviceID: LPUINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiOutMessage*(hmo: HMIDIOUT, uMsg: UINT, dw1: DWORD_PTR, dw2: DWORD_PTR): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetDevCapsA*(uDeviceID: UINT_PTR, pmic: LPMIDIINCAPSA, cbmic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetDevCapsW*(uDeviceID: UINT_PTR, pmic: LPMIDIINCAPSW, cbmic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetErrorTextA*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetErrorTextW*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInOpen*(phmi: LPHMIDIIN, uDeviceID: UINT, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInClose*(hmi: HMIDIIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInPrepareHeader*(hmi: HMIDIIN, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInUnprepareHeader*(hmi: HMIDIIN, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInAddBuffer*(hmi: HMIDIIN, pmh: LPMIDIHDR, cbmh: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInStart*(hmi: HMIDIIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInStop*(hmi: HMIDIIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInReset*(hmi: HMIDIIN): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInGetID*(hmi: HMIDIIN, puDeviceID: LPUINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc midiInMessage*(hmi: HMIDIIN, uMsg: UINT, dw1: DWORD_PTR, dw2: DWORD_PTR): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxGetDevCapsA*(uDeviceID: UINT_PTR, pac: LPAUXCAPSA, cbac: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxGetDevCapsW*(uDeviceID: UINT_PTR, pac: LPAUXCAPSW, cbac: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxSetVolume*(uDeviceID: UINT, dwVolume: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxGetVolume*(uDeviceID: UINT, pdwVolume: LPDWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc auxOutMessage*(uDeviceID: UINT, uMsg: UINT, dw1: DWORD_PTR, dw2: DWORD_PTR): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetDevCapsA*(uMxId: UINT_PTR, pmxcaps: LPMIXERCAPSA, cbmxcaps: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetDevCapsW*(uMxId: UINT_PTR, pmxcaps: LPMIXERCAPSW, cbmxcaps: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerOpen*(phmx: LPHMIXER, uMxId: UINT, dwCallback: DWORD_PTR, dwInstance: DWORD_PTR, fdwOpen: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerClose*(hmx: HMIXER): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerMessage*(hmx: HMIXER, uMsg: UINT, dwParam1: DWORD_PTR, dwParam2: DWORD_PTR): DWORD {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetLineInfoA*(hmxobj: HMIXEROBJ, pmxl: LPMIXERLINEA, fdwInfo: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetLineInfoW*(hmxobj: HMIXEROBJ, pmxl: LPMIXERLINEW, fdwInfo: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetID*(hmxobj: HMIXEROBJ, puMxId: ptr UINT, fdwId: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetLineControlsA*(hmxobj: HMIXEROBJ, pmxlc: LPMIXERLINECONTROLSA, fdwControls: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetLineControlsW*(hmxobj: HMIXEROBJ, pmxlc: LPMIXERLINECONTROLSW, fdwControls: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetControlDetailsA*(hmxobj: HMIXEROBJ, pmxcd: LPMIXERCONTROLDETAILS, fdwDetails: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerGetControlDetailsW*(hmxobj: HMIXEROBJ, pmxcd: LPMIXERCONTROLDETAILS, fdwDetails: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mixerSetControlDetails*(hmxobj: HMIXEROBJ, pmxcd: LPMIXERCONTROLDETAILS, fdwDetails: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeGetSystemTime*(pmmt: LPMMTIME, cbmmt: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeGetTime*(): DWORD {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeSetEvent*(uDelay: UINT, uResolution: UINT, fptc: LPTIMECALLBACK, dwUser: DWORD_PTR, fuEvent: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeKillEvent*(uTimerID: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeGetDevCaps*(ptc: LPTIMECAPS, cbtc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeBeginPeriod*(uPeriod: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc timeEndPeriod*(uPeriod: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetNumDevs*(): UINT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetDevCapsA*(uJoyID: UINT_PTR, pjc: LPJOYCAPSA, cbjc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetDevCapsW*(uJoyID: UINT_PTR, pjc: LPJOYCAPSW, cbjc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetPos*(uJoyID: UINT, pji: LPJOYINFO): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetPosEx*(uJoyID: UINT, pji: LPJOYINFOEX): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyGetThreshold*(uJoyID: UINT, puThreshold: LPUINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joyReleaseCapture*(uJoyID: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joySetCapture*(hwnd: HWND, uJoyID: UINT, uPeriod: UINT, fChanged: WINBOOL): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc joySetThreshold*(uJoyID: UINT, uThreshold: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioStringToFOURCCA*(sz: LPCSTR, uFlags: UINT): FOURCC {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioStringToFOURCCW*(sz: LPCWSTR, uFlags: UINT): FOURCC {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioInstallIOProcA*(fccIOProc: FOURCC, pIOProc: LPMMIOPROC, dwFlags: DWORD): LPMMIOPROC {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioInstallIOProcW*(fccIOProc: FOURCC, pIOProc: LPMMIOPROC, dwFlags: DWORD): LPMMIOPROC {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioOpenA*(pszFileName: LPSTR, pmmioinfo: LPMMIOINFO, fdwOpen: DWORD): HMMIO {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioOpenW*(pszFileName: LPWSTR, pmmioinfo: LPMMIOINFO, fdwOpen: DWORD): HMMIO {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioRenameA*(pszFileName: LPCSTR, pszNewFileName: LPCSTR, pmmioinfo: LPCMMIOINFO, fdwRename: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioRenameW*(pszFileName: LPCWSTR, pszNewFileName: LPCWSTR, pmmioinfo: LPCMMIOINFO, fdwRename: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioClose*(hmmio: HMMIO, fuClose: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioRead*(hmmio: HMMIO, pch: HPSTR, cch: LONG): LONG {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioWrite*(hmmio: HMMIO, pch: ptr char, cch: LONG): LONG {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioSeek*(hmmio: HMMIO, lOffset: LONG, iOrigin: int32): LONG {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioGetInfo*(hmmio: HMMIO, pmmioinfo: LPMMIOINFO, fuInfo: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioSetInfo*(hmmio: HMMIO, pmmioinfo: LPCMMIOINFO, fuInfo: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioSetBuffer*(hmmio: HMMIO, pchBuffer: LPSTR, cchBuffer: LONG, fuBuffer: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioFlush*(hmmio: HMMIO, fuFlush: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioAdvance*(hmmio: HMMIO, pmmioinfo: LPMMIOINFO, fuAdvance: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioSendMessage*(hmmio: HMMIO, uMsg: UINT, lParam1: LPARAM, lParam2: LPARAM): LRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioDescend*(hmmio: HMMIO, pmmcki: LPMMCKINFO, pmmckiParent: ptr MMCKINFO, fuDescend: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioAscend*(hmmio: HMMIO, pmmcki: LPMMCKINFO, fuAscend: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mmioCreateChunk*(hmmio: HMMIO, pmmcki: LPMMCKINFO, fuCreate: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciSendCommandA*(mciId: MCIDEVICEID, uMsg: UINT, dwParam1: DWORD_PTR, dwParam2: DWORD_PTR): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciSendCommandW*(mciId: MCIDEVICEID, uMsg: UINT, dwParam1: DWORD_PTR, dwParam2: DWORD_PTR): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciSendStringA*(lpstrCommand: LPCSTR, lpstrReturnString: LPSTR, uReturnLength: UINT, hwndCallback: HWND): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciSendStringW*(lpstrCommand: LPCWSTR, lpstrReturnString: LPWSTR, uReturnLength: UINT, hwndCallback: HWND): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetDeviceIDA*(pszDevice: LPCSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetDeviceIDW*(pszDevice: LPCWSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetDeviceIDFromElementIDA*(dwElementID: DWORD, lpstrType: LPCSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetDeviceIDFromElementIDW*(dwElementID: DWORD, lpstrType: LPCWSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetErrorStringA*(mcierr: MCIERROR, pszText: LPSTR, cchText: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetErrorStringW*(mcierr: MCIERROR, pszText: LPWSTR, cchText: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciSetYieldProc*(mciId: MCIDEVICEID, fpYieldProc: YIELDPROC, dwYieldData: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetCreatorTask*(mciId: MCIDEVICEID): HTASK {.winapi, stdcall, dynlib: "winmm", importc.}
proc mciGetYieldProc*(mciId: MCIDEVICEID, pdwYieldData: LPDWORD): YIELDPROC {.winapi, stdcall, dynlib: "winmm", importc.}
proc `lMinimum=`*(self: var MIXERCONTROLA, x: LONG) {.inline.} = self.Bounds.struct1.lMinimum = x
proc lMinimum*(self: MIXERCONTROLA): LONG {.inline.} = self.Bounds.struct1.lMinimum
proc lMinimum*(self: var MIXERCONTROLA): var LONG {.inline.} = self.Bounds.struct1.lMinimum
proc `lMaximum=`*(self: var MIXERCONTROLA, x: LONG) {.inline.} = self.Bounds.struct1.lMaximum = x
proc lMaximum*(self: MIXERCONTROLA): LONG {.inline.} = self.Bounds.struct1.lMaximum
proc lMaximum*(self: var MIXERCONTROLA): var LONG {.inline.} = self.Bounds.struct1.lMaximum
proc `dwMinimum=`*(self: var MIXERCONTROLA, x: DWORD) {.inline.} = self.Bounds.struct2.dwMinimum = x
proc dwMinimum*(self: MIXERCONTROLA): DWORD {.inline.} = self.Bounds.struct2.dwMinimum
proc dwMinimum*(self: var MIXERCONTROLA): var DWORD {.inline.} = self.Bounds.struct2.dwMinimum
proc `dwMaximum=`*(self: var MIXERCONTROLA, x: DWORD) {.inline.} = self.Bounds.struct2.dwMaximum = x
proc dwMaximum*(self: MIXERCONTROLA): DWORD {.inline.} = self.Bounds.struct2.dwMaximum
proc dwMaximum*(self: var MIXERCONTROLA): var DWORD {.inline.} = self.Bounds.struct2.dwMaximum
proc `lMinimum=`*(self: var MIXERCONTROLW, x: LONG) {.inline.} = self.Bounds.struct1.lMinimum = x
proc lMinimum*(self: MIXERCONTROLW): LONG {.inline.} = self.Bounds.struct1.lMinimum
proc lMinimum*(self: var MIXERCONTROLW): var LONG {.inline.} = self.Bounds.struct1.lMinimum
proc `lMaximum=`*(self: var MIXERCONTROLW, x: LONG) {.inline.} = self.Bounds.struct1.lMaximum = x
proc lMaximum*(self: MIXERCONTROLW): LONG {.inline.} = self.Bounds.struct1.lMaximum
proc lMaximum*(self: var MIXERCONTROLW): var LONG {.inline.} = self.Bounds.struct1.lMaximum
proc `dwMinimum=`*(self: var MIXERCONTROLW, x: DWORD) {.inline.} = self.Bounds.struct2.dwMinimum = x
proc dwMinimum*(self: MIXERCONTROLW): DWORD {.inline.} = self.Bounds.struct2.dwMinimum
proc dwMinimum*(self: var MIXERCONTROLW): var DWORD {.inline.} = self.Bounds.struct2.dwMinimum
proc `dwMaximum=`*(self: var MIXERCONTROLW, x: DWORD) {.inline.} = self.Bounds.struct2.dwMaximum = x
proc dwMaximum*(self: MIXERCONTROLW): DWORD {.inline.} = self.Bounds.struct2.dwMaximum
proc dwMaximum*(self: var MIXERCONTROLW): var DWORD {.inline.} = self.Bounds.struct2.dwMaximum
proc `dwControlID=`*(self: var MIXERLINECONTROLSA, x: DWORD) {.inline.} = self.union1.dwControlID = x
proc dwControlID*(self: MIXERLINECONTROLSA): DWORD {.inline.} = self.union1.dwControlID
proc dwControlID*(self: var MIXERLINECONTROLSA): var DWORD {.inline.} = self.union1.dwControlID
proc `dwControlType=`*(self: var MIXERLINECONTROLSA, x: DWORD) {.inline.} = self.union1.dwControlType = x
proc dwControlType*(self: MIXERLINECONTROLSA): DWORD {.inline.} = self.union1.dwControlType
proc dwControlType*(self: var MIXERLINECONTROLSA): var DWORD {.inline.} = self.union1.dwControlType
proc `dwControlID=`*(self: var MIXERLINECONTROLSW, x: DWORD) {.inline.} = self.union1.dwControlID = x
proc dwControlID*(self: MIXERLINECONTROLSW): DWORD {.inline.} = self.union1.dwControlID
proc dwControlID*(self: var MIXERLINECONTROLSW): var DWORD {.inline.} = self.union1.dwControlID
proc `dwControlType=`*(self: var MIXERLINECONTROLSW, x: DWORD) {.inline.} = self.union1.dwControlType = x
proc dwControlType*(self: MIXERLINECONTROLSW): DWORD {.inline.} = self.union1.dwControlType
proc dwControlType*(self: var MIXERLINECONTROLSW): var DWORD {.inline.} = self.union1.dwControlType
proc `hwndOwner=`*(self: var MIXERCONTROLDETAILS, x: HWND) {.inline.} = self.union1.hwndOwner = x
proc hwndOwner*(self: MIXERCONTROLDETAILS): HWND {.inline.} = self.union1.hwndOwner
proc hwndOwner*(self: var MIXERCONTROLDETAILS): var HWND {.inline.} = self.union1.hwndOwner
proc `cMultipleItems=`*(self: var MIXERCONTROLDETAILS, x: DWORD) {.inline.} = self.union1.cMultipleItems = x
proc cMultipleItems*(self: MIXERCONTROLDETAILS): DWORD {.inline.} = self.union1.cMultipleItems
proc cMultipleItems*(self: var MIXERCONTROLDETAILS): var DWORD {.inline.} = self.union1.cMultipleItems
when winimUnicode:
  type
    WAVEOUTCAPS* = WAVEOUTCAPSW
    PWAVEOUTCAPS* = PWAVEOUTCAPSW
    NPWAVEOUTCAPS* = NPWAVEOUTCAPSW
    LPWAVEOUTCAPS* = LPWAVEOUTCAPSW
    WAVEOUTCAPS2* = WAVEOUTCAPS2W
    PWAVEOUTCAPS2* = PWAVEOUTCAPS2W
    NPWAVEOUTCAPS2* = NPWAVEOUTCAPS2W
    LPWAVEOUTCAPS2* = LPWAVEOUTCAPS2W
    WAVEINCAPS* = WAVEINCAPSW
    PWAVEINCAPS* = PWAVEINCAPSW
    NPWAVEINCAPS* = NPWAVEINCAPSW
    LPWAVEINCAPS* = LPWAVEINCAPSW
    WAVEINCAPS2* = WAVEINCAPS2W
    PWAVEINCAPS2* = PWAVEINCAPS2W
    NPWAVEINCAPS2* = NPWAVEINCAPS2W
    LPWAVEINCAPS2* = LPWAVEINCAPS2W
    MIDIOUTCAPS* = MIDIOUTCAPSW
    PMIDIOUTCAPS* = PMIDIOUTCAPSW
    NPMIDIOUTCAPS* = NPMIDIOUTCAPSW
    LPMIDIOUTCAPS* = LPMIDIOUTCAPSW
    MIDIOUTCAPS2* = MIDIOUTCAPS2W
    PMIDIOUTCAPS2* = PMIDIOUTCAPS2W
    NPMIDIOUTCAPS2* = NPMIDIOUTCAPS2W
    LPMIDIOUTCAPS2* = LPMIDIOUTCAPS2W
    MIDIINCAPS* = MIDIINCAPSW
    PMIDIINCAPS* = PMIDIINCAPSW
    NPMIDIINCAPS* = NPMIDIINCAPSW
    LPMIDIINCAPS* = LPMIDIINCAPSW
    MIDIINCAPS2* = MIDIINCAPS2W
    PMIDIINCAPS2* = PMIDIINCAPS2W
    NPMIDIINCAPS2* = NPMIDIINCAPS2W
    LPMIDIINCAPS2* = LPMIDIINCAPS2W
    AUXCAPS* = AUXCAPSW
    PAUXCAPS* = PAUXCAPSW
    NPAUXCAPS* = NPAUXCAPSW
    LPAUXCAPS* = LPAUXCAPSW
    AUXCAPS2* = AUXCAPS2W
    PAUXCAPS2* = PAUXCAPS2W
    NPAUXCAPS2* = NPAUXCAPS2W
    LPAUXCAPS2* = LPAUXCAPS2W
    MIXERCAPS* = MIXERCAPSW
    PMIXERCAPS* = PMIXERCAPSW
    LPMIXERCAPS* = LPMIXERCAPSW
    MIXERCAPS2* = MIXERCAPS2W
    PMIXERCAPS2* = PMIXERCAPS2W
    LPMIXERCAPS2* = LPMIXERCAPS2W
    MIXERLINE* = MIXERLINEW
    PMIXERLINE* = PMIXERLINEW
    LPMIXERLINE* = LPMIXERLINEW
    MIXERCONTROL* = MIXERCONTROLW
    PMIXERCONTROL* = PMIXERCONTROLW
    LPMIXERCONTROL* = LPMIXERCONTROLW
    MIXERLINECONTROLS* = MIXERLINECONTROLSW
    PMIXERLINECONTROLS* = PMIXERLINECONTROLSW
    LPMIXERLINECONTROLS* = LPMIXERLINECONTROLSW
    MIXERCONTROLDETAILS_LISTTEXT* = MIXERCONTROLDETAILS_LISTTEXTW
    PMIXERCONTROLDETAILS_LISTTEXT* = PMIXERCONTROLDETAILS_LISTTEXTW
    LPMIXERCONTROLDETAILS_LISTTEXT* = LPMIXERCONTROLDETAILS_LISTTEXTW
    JOYCAPS* = JOYCAPSW
    PJOYCAPS* = PJOYCAPSW
    NPJOYCAPS* = NPJOYCAPSW
    LPJOYCAPS* = LPJOYCAPSW
    JOYCAPS2* = JOYCAPS2W
    PJOYCAPS2* = PJOYCAPS2W
    NPJOYCAPS2* = NPJOYCAPS2W
    LPJOYCAPS2* = LPJOYCAPS2W
    MCI_OPEN_PARMS* = MCI_OPEN_PARMSW
    PMCI_OPEN_PARMS* = PMCI_OPEN_PARMSW
    LPMCI_OPEN_PARMS* = LPMCI_OPEN_PARMSW
    MCI_INFO_PARMS* = MCI_INFO_PARMSW
    LPMCI_INFO_PARMS* = LPMCI_INFO_PARMSW
    MCI_SYSINFO_PARMS* = MCI_SYSINFO_PARMSW
    PMCI_SYSINFO_PARMS* = PMCI_SYSINFO_PARMSW
    LPMCI_SYSINFO_PARMS* = LPMCI_SYSINFO_PARMSW
    MCI_SAVE_PARMS* = MCI_SAVE_PARMSW
    PMCI_SAVE_PARMS* = PMCI_SAVE_PARMSW
    LPMCI_SAVE_PARMS* = LPMCI_SAVE_PARMSW
    MCI_LOAD_PARMS* = MCI_LOAD_PARMSW
    PMCI_LOAD_PARMS* = PMCI_LOAD_PARMSW
    LPMCI_LOAD_PARMS* = LPMCI_LOAD_PARMSW
    MCI_VD_ESCAPE_PARMS* = MCI_VD_ESCAPE_PARMSW
    PMCI_VD_ESCAPE_PARMS* = PMCI_VD_ESCAPE_PARMSW
    LPMCI_VD_ESCAPE_PARMS* = LPMCI_VD_ESCAPE_PARMSW
    MCI_WAVE_OPEN_PARMS* = MCI_WAVE_OPEN_PARMSW
    PMCI_WAVE_OPEN_PARMS* = PMCI_WAVE_OPEN_PARMSW
    LPMCI_WAVE_OPEN_PARMS* = LPMCI_WAVE_OPEN_PARMSW
    MCI_ANIM_OPEN_PARMS* = MCI_ANIM_OPEN_PARMSW
    PMCI_ANIM_OPEN_PARMS* = PMCI_ANIM_OPEN_PARMSW
    LPMCI_ANIM_OPEN_PARMS* = LPMCI_ANIM_OPEN_PARMSW
    MCI_ANIM_WINDOW_PARMS* = MCI_ANIM_WINDOW_PARMSW
    PMCI_ANIM_WINDOW_PARMS* = PMCI_ANIM_WINDOW_PARMSW
    LPMCI_ANIM_WINDOW_PARMS* = LPMCI_ANIM_WINDOW_PARMSW
    MCI_OVLY_OPEN_PARMS* = MCI_OVLY_OPEN_PARMSW
    PMCI_OVLY_OPEN_PARMS* = PMCI_OVLY_OPEN_PARMSW
    LPMCI_OVLY_OPEN_PARMS* = LPMCI_OVLY_OPEN_PARMSW
    MCI_OVLY_WINDOW_PARMS* = MCI_OVLY_WINDOW_PARMSW
    PMCI_OVLY_WINDOW_PARMS* = PMCI_OVLY_WINDOW_PARMSW
    LPMCI_OVLY_WINDOW_PARMS* = LPMCI_OVLY_WINDOW_PARMSW
    MCI_OVLY_SAVE_PARMS* = MCI_OVLY_SAVE_PARMSW
    PMCI_OVLY_SAVE_PARMS* = PMCI_OVLY_SAVE_PARMSW
    LPMCI_OVLY_SAVE_PARMS* = LPMCI_OVLY_SAVE_PARMSW
    MCI_OVLY_LOAD_PARMS* = MCI_OVLY_LOAD_PARMSW
    PMCI_OVLY_LOAD_PARMS* = PMCI_OVLY_LOAD_PARMSW
    LPMCI_OVLY_LOAD_PARMS* = LPMCI_OVLY_LOAD_PARMSW
  proc sndPlaySound*(pszSound: LPCWSTR, fuSound: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "sndPlaySoundW".}
  proc PlaySound*(pszSound: LPCWSTR, hmod: HMODULE, fdwSound: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "PlaySoundW".}
  proc waveOutGetDevCaps*(uDeviceID: UINT_PTR, pwoc: LPWAVEOUTCAPSW, cbwoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveOutGetDevCapsW".}
  proc waveOutGetErrorText*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveOutGetErrorTextW".}
  proc waveInGetDevCaps*(uDeviceID: UINT_PTR, pwic: LPWAVEINCAPSW, cbwic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveInGetDevCapsW".}
  proc waveInGetErrorText*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveInGetErrorTextW".}
  proc midiOutGetDevCaps*(uDeviceID: UINT_PTR, pmoc: LPMIDIOUTCAPSW, cbmoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiOutGetDevCapsW".}
  proc midiOutGetErrorText*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiOutGetErrorTextW".}
  proc midiInGetDevCaps*(uDeviceID: UINT_PTR, pmic: LPMIDIINCAPSW, cbmic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiInGetDevCapsW".}
  proc midiInGetErrorText*(mmrError: MMRESULT, pszText: LPWSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiInGetErrorTextW".}
  proc auxGetDevCaps*(uDeviceID: UINT_PTR, pac: LPAUXCAPSW, cbac: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "auxGetDevCapsW".}
  proc mixerGetDevCaps*(uMxId: UINT_PTR, pmxcaps: LPMIXERCAPSW, cbmxcaps: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetDevCapsW".}
  proc mixerGetLineInfo*(hmxobj: HMIXEROBJ, pmxl: LPMIXERLINEW, fdwInfo: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetLineInfoW".}
  proc mixerGetLineControls*(hmxobj: HMIXEROBJ, pmxlc: LPMIXERLINECONTROLSW, fdwControls: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetLineControlsW".}
  proc mixerGetControlDetails*(hmxobj: HMIXEROBJ, pmxcd: LPMIXERCONTROLDETAILS, fdwDetails: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetControlDetailsW".}
  proc joyGetDevCaps*(uJoyID: UINT_PTR, pjc: LPJOYCAPSW, cbjc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "joyGetDevCapsW".}
  proc mmioStringToFOURCC*(sz: LPCWSTR, uFlags: UINT): FOURCC {.winapi, stdcall, dynlib: "winmm", importc: "mmioStringToFOURCCW".}
  proc mmioInstallIOProc*(fccIOProc: FOURCC, pIOProc: LPMMIOPROC, dwFlags: DWORD): LPMMIOPROC {.winapi, stdcall, dynlib: "winmm", importc: "mmioInstallIOProcW".}
  proc mmioOpen*(pszFileName: LPWSTR, pmmioinfo: LPMMIOINFO, fdwOpen: DWORD): HMMIO {.winapi, stdcall, dynlib: "winmm", importc: "mmioOpenW".}
  proc mmioRename*(pszFileName: LPCWSTR, pszNewFileName: LPCWSTR, pmmioinfo: LPCMMIOINFO, fdwRename: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mmioRenameW".}
  proc mciSendCommand*(mciId: MCIDEVICEID, uMsg: UINT, dwParam1: DWORD_PTR, dwParam2: DWORD_PTR): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc: "mciSendCommandW".}
  proc mciSendString*(lpstrCommand: LPCWSTR, lpstrReturnString: LPWSTR, uReturnLength: UINT, hwndCallback: HWND): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc: "mciSendStringW".}
  proc mciGetDeviceID*(pszDevice: LPCWSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc: "mciGetDeviceIDW".}
  proc mciGetDeviceIDFromElementID*(dwElementID: DWORD, lpstrType: LPCWSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc: "mciGetDeviceIDFromElementIDW".}
  proc mciGetErrorString*(mcierr: MCIERROR, pszText: LPWSTR, cchText: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "mciGetErrorStringW".}
when winimAnsi:
  type
    WAVEOUTCAPS* = WAVEOUTCAPSA
    PWAVEOUTCAPS* = PWAVEOUTCAPSA
    NPWAVEOUTCAPS* = NPWAVEOUTCAPSA
    LPWAVEOUTCAPS* = LPWAVEOUTCAPSA
    WAVEOUTCAPS2* = WAVEOUTCAPS2A
    PWAVEOUTCAPS2* = PWAVEOUTCAPS2A
    NPWAVEOUTCAPS2* = NPWAVEOUTCAPS2A
    LPWAVEOUTCAPS2* = LPWAVEOUTCAPS2A
    WAVEINCAPS* = WAVEINCAPSA
    PWAVEINCAPS* = PWAVEINCAPSA
    NPWAVEINCAPS* = NPWAVEINCAPSA
    LPWAVEINCAPS* = LPWAVEINCAPSA
    WAVEINCAPS2* = WAVEINCAPS2A
    PWAVEINCAPS2* = PWAVEINCAPS2A
    NPWAVEINCAPS2* = NPWAVEINCAPS2A
    LPWAVEINCAPS2* = LPWAVEINCAPS2A
    MIDIOUTCAPS* = MIDIOUTCAPSA
    PMIDIOUTCAPS* = PMIDIOUTCAPSA
    NPMIDIOUTCAPS* = NPMIDIOUTCAPSA
    LPMIDIOUTCAPS* = LPMIDIOUTCAPSA
    MIDIOUTCAPS2* = MIDIOUTCAPS2A
    PMIDIOUTCAPS2* = PMIDIOUTCAPS2A
    NPMIDIOUTCAPS2* = NPMIDIOUTCAPS2A
    LPMIDIOUTCAPS2* = LPMIDIOUTCAPS2A
    MIDIINCAPS* = MIDIINCAPSA
    PMIDIINCAPS* = PMIDIINCAPSA
    NPMIDIINCAPS* = NPMIDIINCAPSA
    LPMIDIINCAPS* = LPMIDIINCAPSA
    MIDIINCAPS2* = MIDIINCAPS2A
    PMIDIINCAPS2* = PMIDIINCAPS2A
    NPMIDIINCAPS2* = NPMIDIINCAPS2A
    LPMIDIINCAPS2* = LPMIDIINCAPS2A
    AUXCAPS* = AUXCAPSA
    PAUXCAPS* = PAUXCAPSA
    NPAUXCAPS* = NPAUXCAPSA
    LPAUXCAPS* = LPAUXCAPSA
    AUXCAPS2* = AUXCAPS2A
    PAUXCAPS2* = PAUXCAPS2A
    NPAUXCAPS2* = NPAUXCAPS2A
    LPAUXCAPS2* = LPAUXCAPS2A
    MIXERCAPS* = MIXERCAPSA
    PMIXERCAPS* = PMIXERCAPSA
    LPMIXERCAPS* = LPMIXERCAPSA
    MIXERCAPS2* = MIXERCAPS2A
    PMIXERCAPS2* = PMIXERCAPS2A
    LPMIXERCAPS2* = LPMIXERCAPS2A
    MIXERLINE* = MIXERLINEA
    PMIXERLINE* = PMIXERLINEA
    LPMIXERLINE* = LPMIXERLINEA
    MIXERCONTROL* = MIXERCONTROLA
    PMIXERCONTROL* = PMIXERCONTROLA
    LPMIXERCONTROL* = LPMIXERCONTROLA
    MIXERLINECONTROLS* = MIXERLINECONTROLSA
    PMIXERLINECONTROLS* = PMIXERLINECONTROLSA
    LPMIXERLINECONTROLS* = LPMIXERLINECONTROLSA
    MIXERCONTROLDETAILS_LISTTEXT* = MIXERCONTROLDETAILS_LISTTEXTA
    PMIXERCONTROLDETAILS_LISTTEXT* = PMIXERCONTROLDETAILS_LISTTEXTA
    LPMIXERCONTROLDETAILS_LISTTEXT* = LPMIXERCONTROLDETAILS_LISTTEXTA
    JOYCAPS* = JOYCAPSA
    PJOYCAPS* = PJOYCAPSA
    NPJOYCAPS* = NPJOYCAPSA
    LPJOYCAPS* = LPJOYCAPSA
    JOYCAPS2* = JOYCAPS2A
    PJOYCAPS2* = PJOYCAPS2A
    NPJOYCAPS2* = NPJOYCAPS2A
    LPJOYCAPS2* = LPJOYCAPS2A
    MCI_OPEN_PARMS* = MCI_OPEN_PARMSA
    PMCI_OPEN_PARMS* = PMCI_OPEN_PARMSA
    LPMCI_OPEN_PARMS* = LPMCI_OPEN_PARMSA
    MCI_INFO_PARMS* = MCI_INFO_PARMSA
    LPMCI_INFO_PARMS* = LPMCI_INFO_PARMSA
    MCI_SYSINFO_PARMS* = MCI_SYSINFO_PARMSA
    PMCI_SYSINFO_PARMS* = PMCI_SYSINFO_PARMSA
    LPMCI_SYSINFO_PARMS* = LPMCI_SYSINFO_PARMSA
    MCI_SAVE_PARMS* = MCI_SAVE_PARMSA
    PMCI_SAVE_PARMS* = PMCI_SAVE_PARMSA
    LPMCI_SAVE_PARMS* = LPMCI_SAVE_PARMSA
    MCI_LOAD_PARMS* = MCI_LOAD_PARMSA
    PMCI_LOAD_PARMS* = PMCI_LOAD_PARMSA
    LPMCI_LOAD_PARMS* = LPMCI_LOAD_PARMSA
    MCI_VD_ESCAPE_PARMS* = MCI_VD_ESCAPE_PARMSA
    PMCI_VD_ESCAPE_PARMS* = PMCI_VD_ESCAPE_PARMSA
    LPMCI_VD_ESCAPE_PARMS* = LPMCI_VD_ESCAPE_PARMSA
    MCI_WAVE_OPEN_PARMS* = MCI_WAVE_OPEN_PARMSA
    PMCI_WAVE_OPEN_PARMS* = PMCI_WAVE_OPEN_PARMSA
    LPMCI_WAVE_OPEN_PARMS* = LPMCI_WAVE_OPEN_PARMSA
    MCI_ANIM_OPEN_PARMS* = MCI_ANIM_OPEN_PARMSA
    PMCI_ANIM_OPEN_PARMS* = PMCI_ANIM_OPEN_PARMSA
    LPMCI_ANIM_OPEN_PARMS* = LPMCI_ANIM_OPEN_PARMSA
    MCI_ANIM_WINDOW_PARMS* = MCI_ANIM_WINDOW_PARMSA
    PMCI_ANIM_WINDOW_PARMS* = PMCI_ANIM_WINDOW_PARMSA
    LPMCI_ANIM_WINDOW_PARMS* = LPMCI_ANIM_WINDOW_PARMSA
    MCI_OVLY_OPEN_PARMS* = MCI_OVLY_OPEN_PARMSA
    PMCI_OVLY_OPEN_PARMS* = PMCI_OVLY_OPEN_PARMSA
    LPMCI_OVLY_OPEN_PARMS* = LPMCI_OVLY_OPEN_PARMSA
    MCI_OVLY_WINDOW_PARMS* = MCI_OVLY_WINDOW_PARMSA
    PMCI_OVLY_WINDOW_PARMS* = PMCI_OVLY_WINDOW_PARMSA
    LPMCI_OVLY_WINDOW_PARMS* = LPMCI_OVLY_WINDOW_PARMSA
    MCI_OVLY_SAVE_PARMS* = MCI_OVLY_SAVE_PARMSA
    PMCI_OVLY_SAVE_PARMS* = PMCI_OVLY_SAVE_PARMSA
    LPMCI_OVLY_SAVE_PARMS* = LPMCI_OVLY_SAVE_PARMSA
    MCI_OVLY_LOAD_PARMS* = MCI_OVLY_LOAD_PARMSA
    PMCI_OVLY_LOAD_PARMS* = PMCI_OVLY_LOAD_PARMSA
    LPMCI_OVLY_LOAD_PARMS* = LPMCI_OVLY_LOAD_PARMSA
  proc sndPlaySound*(pszSound: LPCSTR, fuSound: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "sndPlaySoundA".}
  proc PlaySound*(pszSound: LPCSTR, hmod: HMODULE, fdwSound: DWORD): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "PlaySoundA".}
  proc waveOutGetDevCaps*(uDeviceID: UINT_PTR, pwoc: LPWAVEOUTCAPSA, cbwoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveOutGetDevCapsA".}
  proc waveOutGetErrorText*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveOutGetErrorTextA".}
  proc waveInGetDevCaps*(uDeviceID: UINT_PTR, pwic: LPWAVEINCAPSA, cbwic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveInGetDevCapsA".}
  proc waveInGetErrorText*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "waveInGetErrorTextA".}
  proc midiOutGetDevCaps*(uDeviceID: UINT_PTR, pmoc: LPMIDIOUTCAPSA, cbmoc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiOutGetDevCapsA".}
  proc midiOutGetErrorText*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiOutGetErrorTextA".}
  proc midiInGetDevCaps*(uDeviceID: UINT_PTR, pmic: LPMIDIINCAPSA, cbmic: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiInGetDevCapsA".}
  proc midiInGetErrorText*(mmrError: MMRESULT, pszText: LPSTR, cchText: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "midiInGetErrorTextA".}
  proc auxGetDevCaps*(uDeviceID: UINT_PTR, pac: LPAUXCAPSA, cbac: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "auxGetDevCapsA".}
  proc mixerGetDevCaps*(uMxId: UINT_PTR, pmxcaps: LPMIXERCAPSA, cbmxcaps: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetDevCapsA".}
  proc mixerGetLineInfo*(hmxobj: HMIXEROBJ, pmxl: LPMIXERLINEA, fdwInfo: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetLineInfoA".}
  proc mixerGetLineControls*(hmxobj: HMIXEROBJ, pmxlc: LPMIXERLINECONTROLSA, fdwControls: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetLineControlsA".}
  proc mixerGetControlDetails*(hmxobj: HMIXEROBJ, pmxcd: LPMIXERCONTROLDETAILS, fdwDetails: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mixerGetControlDetailsA".}
  proc joyGetDevCaps*(uJoyID: UINT_PTR, pjc: LPJOYCAPSA, cbjc: UINT): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "joyGetDevCapsA".}
  proc mmioStringToFOURCC*(sz: LPCSTR, uFlags: UINT): FOURCC {.winapi, stdcall, dynlib: "winmm", importc: "mmioStringToFOURCCA".}
  proc mmioInstallIOProc*(fccIOProc: FOURCC, pIOProc: LPMMIOPROC, dwFlags: DWORD): LPMMIOPROC {.winapi, stdcall, dynlib: "winmm", importc: "mmioInstallIOProcA".}
  proc mmioOpen*(pszFileName: LPSTR, pmmioinfo: LPMMIOINFO, fdwOpen: DWORD): HMMIO {.winapi, stdcall, dynlib: "winmm", importc: "mmioOpenA".}
  proc mmioRename*(pszFileName: LPCSTR, pszNewFileName: LPCSTR, pmmioinfo: LPCMMIOINFO, fdwRename: DWORD): MMRESULT {.winapi, stdcall, dynlib: "winmm", importc: "mmioRenameA".}
  proc mciSendCommand*(mciId: MCIDEVICEID, uMsg: UINT, dwParam1: DWORD_PTR, dwParam2: DWORD_PTR): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc: "mciSendCommandA".}
  proc mciSendString*(lpstrCommand: LPCSTR, lpstrReturnString: LPSTR, uReturnLength: UINT, hwndCallback: HWND): MCIERROR {.winapi, stdcall, dynlib: "winmm", importc: "mciSendStringA".}
  proc mciGetDeviceID*(pszDevice: LPCSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc: "mciGetDeviceIDA".}
  proc mciGetDeviceIDFromElementID*(dwElementID: DWORD, lpstrType: LPCSTR): MCIDEVICEID {.winapi, stdcall, dynlib: "winmm", importc: "mciGetDeviceIDFromElementIDA".}
  proc mciGetErrorString*(mcierr: MCIERROR, pszText: LPSTR, cchText: UINT): WINBOOL {.winapi, stdcall, dynlib: "winmm", importc: "mciGetErrorStringA".}
