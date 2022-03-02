#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import winbase
#include <winnls.h>
#include <datetimeapi.h>
#include <stringapiset.h>
type
  SYSNLS_FUNCTION* = int32
  SYSGEOTYPE* = int32
  SYSGEOCLASS* = int32
  NORM_FORM* = int32
  LGRPID* = DWORD
  LCTYPE* = DWORD
  CALTYPE* = DWORD
  CALID* = DWORD
  NLS_FUNCTION* = DWORD
  GEOID* = LONG
  GEOTYPE* = DWORD
  GEOCLASS* = DWORD
const
  MAX_DEFAULTCHAR* = 2
  MAX_LEADBYTES* = 12
type
  CPINFO* {.pure.} = object
    MaxCharSize*: UINT
    DefaultChar*: array[MAX_DEFAULTCHAR, BYTE]
    LeadByte*: array[MAX_LEADBYTES, BYTE]
  LPCPINFO* = ptr CPINFO
  CPINFOEXA* {.pure.} = object
    MaxCharSize*: UINT
    DefaultChar*: array[MAX_DEFAULTCHAR, BYTE]
    LeadByte*: array[MAX_LEADBYTES, BYTE]
    UnicodeDefaultChar*: WCHAR
    CodePage*: UINT
    CodePageName*: array[MAX_PATH, CHAR]
  LPCPINFOEXA* = ptr CPINFOEXA
  CPINFOEXW* {.pure.} = object
    MaxCharSize*: UINT
    DefaultChar*: array[MAX_DEFAULTCHAR, BYTE]
    LeadByte*: array[MAX_LEADBYTES, BYTE]
    UnicodeDefaultChar*: WCHAR
    CodePage*: UINT
    CodePageName*: array[MAX_PATH, WCHAR]
  LPCPINFOEXW* = ptr CPINFOEXW
  NUMBERFMTA* {.pure.} = object
    NumDigits*: UINT
    LeadingZero*: UINT
    Grouping*: UINT
    lpDecimalSep*: LPSTR
    lpThousandSep*: LPSTR
    NegativeOrder*: UINT
  LPNUMBERFMTA* = ptr NUMBERFMTA
  NUMBERFMTW* {.pure.} = object
    NumDigits*: UINT
    LeadingZero*: UINT
    Grouping*: UINT
    lpDecimalSep*: LPWSTR
    lpThousandSep*: LPWSTR
    NegativeOrder*: UINT
  LPNUMBERFMTW* = ptr NUMBERFMTW
  CURRENCYFMTA* {.pure.} = object
    NumDigits*: UINT
    LeadingZero*: UINT
    Grouping*: UINT
    lpDecimalSep*: LPSTR
    lpThousandSep*: LPSTR
    NegativeOrder*: UINT
    PositiveOrder*: UINT
    lpCurrencySymbol*: LPSTR
  LPCURRENCYFMTA* = ptr CURRENCYFMTA
  CURRENCYFMTW* {.pure.} = object
    NumDigits*: UINT
    LeadingZero*: UINT
    Grouping*: UINT
    lpDecimalSep*: LPWSTR
    lpThousandSep*: LPWSTR
    NegativeOrder*: UINT
    PositiveOrder*: UINT
    lpCurrencySymbol*: LPWSTR
  LPCURRENCYFMTW* = ptr CURRENCYFMTW
  NLSVERSIONINFO* {.pure.} = object
    dwNLSVersionInfoSize*: DWORD
    dwNLSVersion*: DWORD
    dwDefinedVersion*: DWORD
    dwEffectiveId*: DWORD
    guidCustomVersion*: GUID
  LPNLSVERSIONINFO* = ptr NLSVERSIONINFO
  NLSVERSIONINFOEX* {.pure.} = object
    dwNLSVersionInfoSize*: DWORD
    dwNLSVersion*: DWORD
    dwDefinedVersion*: DWORD
    dwEffectiveId*: DWORD
    guidCustomVersion*: GUID
  LPNLSVERSIONINFOEX* = ptr NLSVERSIONINFOEX
  FILEMUIINFO* {.pure.} = object
    dwSize*: DWORD
    dwVersion*: DWORD
    dwFileType*: DWORD
    pChecksum*: array[16, BYTE]
    pServiceChecksum*: array[16, BYTE]
    dwLanguageNameOffset*: DWORD
    dwTypeIDMainSize*: DWORD
    dwTypeIDMainOffset*: DWORD
    dwTypeNameMainOffset*: DWORD
    dwTypeIDMUISize*: DWORD
    dwTypeIDMUIOffset*: DWORD
    dwTypeNameMUIOffset*: DWORD
    abBuffer*: array[8, BYTE]
  PFILEMUIINFO* = ptr FILEMUIINFO
const
  HIGH_SURROGATE_START* = 0xd800
  HIGH_SURROGATE_END* = 0xdbff
  LOW_SURROGATE_START* = 0xdc00
  LOW_SURROGATE_END* = 0xdfff
  MB_PRECOMPOSED* = 0x00000001
  MB_COMPOSITE* = 0x00000002
  MB_USEGLYPHCHARS* = 0x00000004
  MB_ERR_INVALID_CHARS* = 0x00000008
  WC_DISCARDNS* = 0x00000010
  WC_SEPCHARS* = 0x00000020
  WC_DEFAULTCHAR* = 0x00000040
  WC_ERR_INVALID_CHARS* = 0x00000080
  WC_COMPOSITECHECK* = 0x00000200
  WC_NO_BEST_FIT_CHARS* = 0x00000400
  CT_CTYPE1* = 0x00000001
  CT_CTYPE2* = 0x00000002
  CT_CTYPE3* = 0x00000004
  C1_UPPER* = 0x0001
  C1_LOWER* = 0x0002
  C1_DIGIT* = 0x0004
  C1_SPACE* = 0x0008
  C1_PUNCT* = 0x0010
  C1_CNTRL* = 0x0020
  C1_BLANK* = 0x0040
  C1_XDIGIT* = 0x0080
  C1_ALPHA* = 0x0100
  C1_DEFINED* = 0x0200
  C2_LEFTTORIGHT* = 0x0001
  C2_RIGHTTOLEFT* = 0x0002
  C2_EUROPENUMBER* = 0x0003
  C2_EUROPESEPARATOR* = 0x0004
  C2_EUROPETERMINATOR* = 0x0005
  C2_ARABICNUMBER* = 0x0006
  C2_COMMONSEPARATOR* = 0x0007
  C2_BLOCKSEPARATOR* = 0x0008
  C2_SEGMENTSEPARATOR* = 0x0009
  C2_WHITESPACE* = 0x000a
  C2_OTHERNEUTRAL* = 0x000b
  C2_NOTAPPLICABLE* = 0x0000
  C3_NONSPACING* = 0x0001
  C3_DIACRITIC* = 0x0002
  C3_VOWELMARK* = 0x0004
  C3_SYMBOL* = 0x0008
  C3_KATAKANA* = 0x0010
  C3_HIRAGANA* = 0x0020
  C3_HALFWIDTH* = 0x0040
  C3_FULLWIDTH* = 0x0080
  C3_IDEOGRAPH* = 0x0100
  C3_KASHIDA* = 0x0200
  C3_LEXICAL* = 0x0400
  C3_HIGHSURROGATE* = 0x0800
  C3_LOWSURROGATE* = 0x1000
  C3_ALPHA* = 0x8000
  C3_NOTAPPLICABLE* = 0x0000
  NORM_IGNORECASE* = 0x00000001
  NORM_IGNORENONSPACE* = 0x00000002
  NORM_IGNORESYMBOLS* = 0x00000004
  LINGUISTIC_IGNORECASE* = 0x00000010
  LINGUISTIC_IGNOREDIACRITIC* = 0x00000020
  NORM_IGNOREKANATYPE* = 0x00010000
  NORM_IGNOREWIDTH* = 0x00020000
  NORM_LINGUISTIC_CASING* = 0x08000000
  MAP_FOLDCZONE* = 0x00000010
  MAP_PRECOMPOSED* = 0x00000020
  MAP_COMPOSITE* = 0x00000040
  MAP_FOLDDIGITS* = 0x00000080
  MAP_EXPAND_LIGATURES* = 0x00002000
  LCMAP_LOWERCASE* = 0x00000100
  LCMAP_UPPERCASE* = 0x00000200
  LCMAP_TITLECASE* = 0x00000300
  LCMAP_SORTKEY* = 0x00000400
  LCMAP_BYTEREV* = 0x00000800
  LCMAP_HIRAGANA* = 0x00100000
  LCMAP_KATAKANA* = 0x00200000
  LCMAP_HALFWIDTH* = 0x00400000
  LCMAP_FULLWIDTH* = 0x00800000
  LCMAP_LINGUISTIC_CASING* = 0x01000000
  LCMAP_SIMPLIFIED_CHINESE* = 0x02000000
  LCMAP_TRADITIONAL_CHINESE* = 0x04000000
  LCMAP_SORTHANDLE* = 0x20000000
  LCMAP_HASH* = 0x00040000
  FIND_STARTSWITH* = 0x00100000
  FIND_ENDSWITH* = 0x00200000
  FIND_FROMSTART* = 0x00400000
  FIND_FROMEND* = 0x00800000
  LGRPID_INSTALLED* = 0x00000001
  LGRPID_SUPPORTED* = 0x00000002
  LCID_INSTALLED* = 0x00000001
  LCID_SUPPORTED* = 0x00000002
  LCID_ALTERNATE_SORTS* = 0x00000004
  LOCALE_ALL* = 0
  LOCALE_WINDOWS* = 0x00000001
  LOCALE_SUPPLEMENTAL* = 0x00000002
  LOCALE_ALTERNATE_SORTS* = 0x00000004
  LOCALE_REPLACEMENT* = 0x00000008
  LOCALE_NEUTRALDATA* = 0x00000010
  LOCALE_SPECIFICDATA* = 0x00000020
  CP_INSTALLED* = 0x00000001
  CP_SUPPORTED* = 0x00000002
  SORT_STRINGSORT* = 0x00001000
  SORT_DIGITSASNUMBERS* = 0x00000008
  CSTR_LESS_THAN* = 1
  CSTR_EQUAL* = 2
  CSTR_GREATER_THAN* = 3
  CP_ACP* = 0
  CP_OEMCP* = 1
  CP_MACCP* = 2
  CP_THREAD_ACP* = 3
  CP_SYMBOL* = 42
  CP_UTF7* = 65000
  CP_UTF8* = 65001
  CTRY_DEFAULT* = 0
  CTRY_ALBANIA* = 355
  CTRY_ALGERIA* = 213
  CTRY_ARGENTINA* = 54
  CTRY_ARMENIA* = 374
  CTRY_AUSTRALIA* = 61
  CTRY_AUSTRIA* = 43
  CTRY_AZERBAIJAN* = 994
  CTRY_BAHRAIN* = 973
  CTRY_BELARUS* = 375
  CTRY_BELGIUM* = 32
  CTRY_BELIZE* = 501
  CTRY_BOLIVIA* = 591
  CTRY_BRAZIL* = 55
  CTRY_BRUNEI_DARUSSALAM* = 673
  CTRY_BULGARIA* = 359
  CTRY_CANADA* = 2
  CTRY_CARIBBEAN* = 1
  CTRY_CHILE* = 56
  CTRY_COLOMBIA* = 57
  CTRY_COSTA_RICA* = 506
  CTRY_CROATIA* = 385
  CTRY_CZECH* = 420
  CTRY_DENMARK* = 45
  CTRY_DOMINICAN_REPUBLIC* = 1
  CTRY_ECUADOR* = 593
  CTRY_EGYPT* = 20
  CTRY_EL_SALVADOR* = 503
  CTRY_ESTONIA* = 372
  CTRY_FAEROE_ISLANDS* = 298
  CTRY_FINLAND* = 358
  CTRY_FRANCE* = 33
  CTRY_GEORGIA* = 995
  CTRY_GERMANY* = 49
  CTRY_GREECE* = 30
  CTRY_GUATEMALA* = 502
  CTRY_HONDURAS* = 504
  CTRY_HONG_KONG* = 852
  CTRY_HUNGARY* = 36
  CTRY_ICELAND* = 354
  CTRY_INDIA* = 91
  CTRY_INDONESIA* = 62
  CTRY_IRAN* = 981
  CTRY_IRAQ* = 964
  CTRY_IRELAND* = 353
  CTRY_ISRAEL* = 972
  CTRY_ITALY* = 39
  CTRY_JAMAICA* = 1
  CTRY_JAPAN* = 81
  CTRY_JORDAN* = 962
  CTRY_KAZAKSTAN* = 7
  CTRY_KENYA* = 254
  CTRY_KUWAIT* = 965
  CTRY_KYRGYZSTAN* = 996
  CTRY_LATVIA* = 371
  CTRY_LEBANON* = 961
  CTRY_LIBYA* = 218
  CTRY_LIECHTENSTEIN* = 41
  CTRY_LITHUANIA* = 370
  CTRY_LUXEMBOURG* = 352
  CTRY_MACAU* = 853
  CTRY_MACEDONIA* = 389
  CTRY_MALAYSIA* = 60
  CTRY_MALDIVES* = 960
  CTRY_MEXICO* = 52
  CTRY_MONACO* = 33
  CTRY_MONGOLIA* = 976
  CTRY_MOROCCO* = 212
  CTRY_NETHERLANDS* = 31
  CTRY_NEW_ZEALAND* = 64
  CTRY_NICARAGUA* = 505
  CTRY_NORWAY* = 47
  CTRY_OMAN* = 968
  CTRY_PAKISTAN* = 92
  CTRY_PANAMA* = 507
  CTRY_PARAGUAY* = 595
  CTRY_PERU* = 51
  CTRY_PHILIPPINES* = 63
  CTRY_POLAND* = 48
  CTRY_PORTUGAL* = 351
  CTRY_PRCHINA* = 86
  CTRY_PUERTO_RICO* = 1
  CTRY_QATAR* = 974
  CTRY_ROMANIA* = 40
  CTRY_RUSSIA* = 7
  CTRY_SAUDI_ARABIA* = 966
  CTRY_SERBIA* = 381
  CTRY_SINGAPORE* = 65
  CTRY_SLOVAK* = 421
  CTRY_SLOVENIA* = 386
  CTRY_SOUTH_AFRICA* = 27
  CTRY_SOUTH_KOREA* = 82
  CTRY_SPAIN* = 34
  CTRY_SWEDEN* = 46
  CTRY_SWITZERLAND* = 41
  CTRY_SYRIA* = 963
  CTRY_TAIWAN* = 886
  CTRY_TATARSTAN* = 7
  CTRY_THAILAND* = 66
  CTRY_TRINIDAD_Y_TOBAGO* = 1
  CTRY_TUNISIA* = 216
  CTRY_TURKEY* = 90
  CTRY_UAE* = 971
  CTRY_UKRAINE* = 380
  CTRY_UNITED_KINGDOM* = 44
  CTRY_UNITED_STATES* = 1
  CTRY_URUGUAY* = 598
  CTRY_UZBEKISTAN* = 7
  CTRY_VENEZUELA* = 58
  CTRY_VIET_NAM* = 84
  CTRY_YEMEN* = 967
  CTRY_ZIMBABWE* = 263
  LOCALE_SLOCALIZEDDISPLAYNAME* = 0x00000002
  LOCALE_ALLOW_NEUTRAL_NAMES* = 0x08000000
  LOCALE_RETURN_GENITIVE_NAMES* = 0x10000000
  LOCALE_RETURN_NUMBER* = 0x20000000
  LOCALE_USE_CP_ACP* = 0x40000000
  LOCALE_NOUSEROVERRIDE* = 0x80000000'i32
  LOCALE_SENGLISHDISPLAYNAME* = 0x00000072
  LOCALE_SNATIVEDISPLAYNAME* = 0x00000073
  LOCALE_SLOCALIZEDLANGUAGENAME* = 0x0000006f
  LOCALE_SENGLISHLANGUAGENAME* = 0x00001001
  LOCALE_SNATIVELANGUAGENAME* = 0x00000004
  LOCALE_SLOCALIZEDCOUNTRYNAME* = 0x00000006
  LOCALE_SENGLISHCOUNTRYNAME* = 0x00001002
  LOCALE_SNATIVECOUNTRYNAME* = 0x00000008
  LOCALE_SLANGUAGE* = 0x00000002
  LOCALE_SLANGDISPLAYNAME* = 0x0000006f
  LOCALE_SENGLANGUAGE* = 0x00001001
  LOCALE_SNATIVELANGNAME* = 0x00000004
  LOCALE_SCOUNTRY* = 0x00000006
  LOCALE_SENGCOUNTRY* = 0x00001002
  LOCALE_SNATIVECTRYNAME* = 0x00000008
  LOCALE_ILANGUAGE* = 0x00000001
  LOCALE_SABBREVLANGNAME* = 0x00000003
  LOCALE_ICOUNTRY* = 0x00000005
  LOCALE_SABBREVCTRYNAME* = 0x00000007
  LOCALE_IGEOID* = 0x0000005b
  LOCALE_IDEFAULTLANGUAGE* = 0x00000009
  LOCALE_IDEFAULTCOUNTRY* = 0x0000000a
  LOCALE_IDEFAULTCODEPAGE* = 0x0000000b
  LOCALE_IDEFAULTANSICODEPAGE* = 0x00001004
  LOCALE_IDEFAULTMACCODEPAGE* = 0x00001011
  LOCALE_SLIST* = 0x0000000c
  LOCALE_IMEASURE* = 0x0000000d
  LOCALE_SDECIMAL* = 0x0000000e
  LOCALE_STHOUSAND* = 0x0000000f
  LOCALE_SGROUPING* = 0x00000010
  LOCALE_IDIGITS* = 0x00000011
  LOCALE_ILZERO* = 0x00000012
  LOCALE_INEGNUMBER* = 0x00001010
  LOCALE_SNATIVEDIGITS* = 0x00000013
  LOCALE_SCURRENCY* = 0x00000014
  LOCALE_SINTLSYMBOL* = 0x00000015
  LOCALE_SMONDECIMALSEP* = 0x00000016
  LOCALE_SMONTHOUSANDSEP* = 0x00000017
  LOCALE_SMONGROUPING* = 0x00000018
  LOCALE_ICURRDIGITS* = 0x00000019
  LOCALE_IINTLCURRDIGITS* = 0x0000001a
  LOCALE_ICURRENCY* = 0x0000001b
  LOCALE_INEGCURR* = 0x0000001c
  LOCALE_SDATE* = 0x0000001d
  LOCALE_STIME* = 0x0000001e
  LOCALE_SSHORTDATE* = 0x0000001f
  LOCALE_SLONGDATE* = 0x00000020
  LOCALE_STIMEFORMAT* = 0x00001003
  LOCALE_IDATE* = 0x00000021
  LOCALE_ILDATE* = 0x00000022
  LOCALE_ITIME* = 0x00000023
  LOCALE_ITIMEMARKPOSN* = 0x00001005
  LOCALE_ICENTURY* = 0x00000024
  LOCALE_ITLZERO* = 0x00000025
  LOCALE_IDAYLZERO* = 0x00000026
  LOCALE_IMONLZERO* = 0x00000027
  LOCALE_S1159* = 0x00000028
  LOCALE_S2359* = 0x00000029
  LOCALE_ICALENDARTYPE* = 0x00001009
  LOCALE_IOPTIONALCALENDAR* = 0x0000100b
  LOCALE_IFIRSTDAYOFWEEK* = 0x0000100c
  LOCALE_IFIRSTWEEKOFYEAR* = 0x0000100d
  LOCALE_SDAYNAME1* = 0x0000002a
  LOCALE_SDAYNAME2* = 0x0000002b
  LOCALE_SDAYNAME3* = 0x0000002c
  LOCALE_SDAYNAME4* = 0x0000002d
  LOCALE_SDAYNAME5* = 0x0000002e
  LOCALE_SDAYNAME6* = 0x0000002f
  LOCALE_SDAYNAME7* = 0x00000030
  LOCALE_SABBREVDAYNAME1* = 0x00000031
  LOCALE_SABBREVDAYNAME2* = 0x00000032
  LOCALE_SABBREVDAYNAME3* = 0x00000033
  LOCALE_SABBREVDAYNAME4* = 0x00000034
  LOCALE_SABBREVDAYNAME5* = 0x00000035
  LOCALE_SABBREVDAYNAME6* = 0x00000036
  LOCALE_SABBREVDAYNAME7* = 0x00000037
  LOCALE_SMONTHNAME1* = 0x00000038
  LOCALE_SMONTHNAME2* = 0x00000039
  LOCALE_SMONTHNAME3* = 0x0000003a
  LOCALE_SMONTHNAME4* = 0x0000003b
  LOCALE_SMONTHNAME5* = 0x0000003c
  LOCALE_SMONTHNAME6* = 0x0000003d
  LOCALE_SMONTHNAME7* = 0x0000003e
  LOCALE_SMONTHNAME8* = 0x0000003f
  LOCALE_SMONTHNAME9* = 0x00000040
  LOCALE_SMONTHNAME10* = 0x00000041
  LOCALE_SMONTHNAME11* = 0x00000042
  LOCALE_SMONTHNAME12* = 0x00000043
  LOCALE_SMONTHNAME13* = 0x0000100e
  LOCALE_SABBREVMONTHNAME1* = 0x00000044
  LOCALE_SABBREVMONTHNAME2* = 0x00000045
  LOCALE_SABBREVMONTHNAME3* = 0x00000046
  LOCALE_SABBREVMONTHNAME4* = 0x00000047
  LOCALE_SABBREVMONTHNAME5* = 0x00000048
  LOCALE_SABBREVMONTHNAME6* = 0x00000049
  LOCALE_SABBREVMONTHNAME7* = 0x0000004a
  LOCALE_SABBREVMONTHNAME8* = 0x0000004b
  LOCALE_SABBREVMONTHNAME9* = 0x0000004c
  LOCALE_SABBREVMONTHNAME10* = 0x0000004d
  LOCALE_SABBREVMONTHNAME11* = 0x0000004e
  LOCALE_SABBREVMONTHNAME12* = 0x0000004f
  LOCALE_SABBREVMONTHNAME13* = 0x0000100f
  LOCALE_SPOSITIVESIGN* = 0x00000050
  LOCALE_SNEGATIVESIGN* = 0x00000051
  LOCALE_IPOSSIGNPOSN* = 0x00000052
  LOCALE_INEGSIGNPOSN* = 0x00000053
  LOCALE_IPOSSYMPRECEDES* = 0x00000054
  LOCALE_IPOSSEPBYSPACE* = 0x00000055
  LOCALE_INEGSYMPRECEDES* = 0x00000056
  LOCALE_INEGSEPBYSPACE* = 0x00000057
  LOCALE_FONTSIGNATURE* = 0x00000058
  LOCALE_SISO639LANGNAME* = 0x00000059
  LOCALE_SISO3166CTRYNAME* = 0x0000005a
  LOCALE_IDEFAULTEBCDICCODEPAGE* = 0x00001012
  LOCALE_IPAPERSIZE* = 0x0000100a
  LOCALE_SENGCURRNAME* = 0x00001007
  LOCALE_SNATIVECURRNAME* = 0x00001008
  LOCALE_SYEARMONTH* = 0x00001006
  LOCALE_SSORTNAME* = 0x00001013
  LOCALE_IDIGITSUBSTITUTION* = 0x00001014
  LOCALE_SNAME* = 0x0000005c
  LOCALE_SDURATION* = 0x0000005d
  LOCALE_SKEYBOARDSTOINSTALL* = 0x0000005e
  LOCALE_SSHORTESTDAYNAME1* = 0x00000060
  LOCALE_SSHORTESTDAYNAME2* = 0x00000061
  LOCALE_SSHORTESTDAYNAME3* = 0x00000062
  LOCALE_SSHORTESTDAYNAME4* = 0x00000063
  LOCALE_SSHORTESTDAYNAME5* = 0x00000064
  LOCALE_SSHORTESTDAYNAME6* = 0x00000065
  LOCALE_SSHORTESTDAYNAME7* = 0x00000066
  LOCALE_SISO639LANGNAME2* = 0x00000067
  LOCALE_SISO3166CTRYNAME2* = 0x00000068
  LOCALE_SNAN* = 0x00000069
  LOCALE_SPOSINFINITY* = 0x0000006a
  LOCALE_SNEGINFINITY* = 0x0000006b
  LOCALE_SSCRIPTS* = 0x0000006c
  LOCALE_SPARENT* = 0x0000006d
  LOCALE_SCONSOLEFALLBACKNAME* = 0x0000006e
  LOCALE_IREADINGLAYOUT* = 0x00000070
  LOCALE_INEUTRAL* = 0x00000071
  LOCALE_INEGATIVEPERCENT* = 0x00000074
  LOCALE_IPOSITIVEPERCENT* = 0x00000075
  LOCALE_SPERCENT* = 0x00000076
  LOCALE_SPERMILLE* = 0x00000077
  LOCALE_SMONTHDAY* = 0x00000078
  LOCALE_SSHORTTIME* = 0x00000079
  LOCALE_SOPENTYPELANGUAGETAG* = 0x0000007a
  LOCALE_SSORTLOCALE* = 0x0000007b
  TIME_NOMINUTESORSECONDS* = 0x00000001
  TIME_NOSECONDS* = 0x00000002
  TIME_NOTIMEMARKER* = 0x00000004
  TIME_FORCE24HOURFORMAT* = 0x00000008
  DATE_SHORTDATE* = 0x00000001
  DATE_LONGDATE* = 0x00000002
  DATE_USE_ALT_CALENDAR* = 0x00000004
  DATE_YEARMONTH* = 0x00000008
  DATE_LTRREADING* = 0x00000010
  DATE_RTLREADING* = 0x00000020
  DATE_AUTOLAYOUT* = 0x00000040
  CAL_NOUSEROVERRIDE* = LOCALE_NOUSEROVERRIDE
  CAL_USE_CP_ACP* = LOCALE_USE_CP_ACP
  CAL_RETURN_NUMBER* = LOCALE_RETURN_NUMBER
  CAL_RETURN_GENITIVE_NAMES* = LOCALE_RETURN_GENITIVE_NAMES
  CAL_ICALINTVALUE* = 0x00000001
  CAL_SCALNAME* = 0x00000002
  CAL_IYEAROFFSETRANGE* = 0x00000003
  CAL_SERASTRING* = 0x00000004
  CAL_SSHORTDATE* = 0x00000005
  CAL_SLONGDATE* = 0x00000006
  CAL_SDAYNAME1* = 0x00000007
  CAL_SDAYNAME2* = 0x00000008
  CAL_SDAYNAME3* = 0x00000009
  CAL_SDAYNAME4* = 0x0000000a
  CAL_SDAYNAME5* = 0x0000000b
  CAL_SDAYNAME6* = 0x0000000c
  CAL_SDAYNAME7* = 0x0000000d
  CAL_SABBREVDAYNAME1* = 0x0000000e
  CAL_SABBREVDAYNAME2* = 0x0000000f
  CAL_SABBREVDAYNAME3* = 0x00000010
  CAL_SABBREVDAYNAME4* = 0x00000011
  CAL_SABBREVDAYNAME5* = 0x00000012
  CAL_SABBREVDAYNAME6* = 0x00000013
  CAL_SABBREVDAYNAME7* = 0x00000014
  CAL_SMONTHNAME1* = 0x00000015
  CAL_SMONTHNAME2* = 0x00000016
  CAL_SMONTHNAME3* = 0x00000017
  CAL_SMONTHNAME4* = 0x00000018
  CAL_SMONTHNAME5* = 0x00000019
  CAL_SMONTHNAME6* = 0x0000001a
  CAL_SMONTHNAME7* = 0x0000001b
  CAL_SMONTHNAME8* = 0x0000001c
  CAL_SMONTHNAME9* = 0x0000001d
  CAL_SMONTHNAME10* = 0x0000001e
  CAL_SMONTHNAME11* = 0x0000001f
  CAL_SMONTHNAME12* = 0x00000020
  CAL_SMONTHNAME13* = 0x00000021
  CAL_SABBREVMONTHNAME1* = 0x00000022
  CAL_SABBREVMONTHNAME2* = 0x00000023
  CAL_SABBREVMONTHNAME3* = 0x00000024
  CAL_SABBREVMONTHNAME4* = 0x00000025
  CAL_SABBREVMONTHNAME5* = 0x00000026
  CAL_SABBREVMONTHNAME6* = 0x00000027
  CAL_SABBREVMONTHNAME7* = 0x00000028
  CAL_SABBREVMONTHNAME8* = 0x00000029
  CAL_SABBREVMONTHNAME9* = 0x0000002a
  CAL_SABBREVMONTHNAME10* = 0x0000002b
  CAL_SABBREVMONTHNAME11* = 0x0000002c
  CAL_SABBREVMONTHNAME12* = 0x0000002d
  CAL_SABBREVMONTHNAME13* = 0x0000002e
  CAL_SYEARMONTH* = 0x0000002f
  CAL_ITWODIGITYEARMAX* = 0x00000030
  CAL_SSHORTESTDAYNAME1* = 0x00000031
  CAL_SSHORTESTDAYNAME2* = 0x00000032
  CAL_SSHORTESTDAYNAME3* = 0x00000033
  CAL_SSHORTESTDAYNAME4* = 0x00000034
  CAL_SSHORTESTDAYNAME5* = 0x00000035
  CAL_SSHORTESTDAYNAME6* = 0x00000036
  CAL_SSHORTESTDAYNAME7* = 0x00000037
  CAL_SMONTHDAY* = 0x00000038
  CAL_SABBREVERASTRING* = 0x00000039
  ENUM_ALL_CALENDARS* = 0xffffffff'i32
  CAL_GREGORIAN* = 1
  CAL_GREGORIAN_US* = 2
  CAL_JAPAN* = 3
  CAL_TAIWAN* = 4
  CAL_KOREA* = 5
  CAL_HIJRI* = 6
  CAL_THAI* = 7
  CAL_HEBREW* = 8
  CAL_GREGORIAN_ME_FRENCH* = 9
  CAL_GREGORIAN_ARABIC* = 10
  CAL_GREGORIAN_XLIT_ENGLISH* = 11
  CAL_GREGORIAN_XLIT_FRENCH* = 12
  CAL_UMALQURA* = 23
  LGRPID_WESTERN_EUROPE* = 0x0001
  LGRPID_CENTRAL_EUROPE* = 0x0002
  LGRPID_BALTIC* = 0x0003
  LGRPID_GREEK* = 0x0004
  LGRPID_CYRILLIC* = 0x0005
  LGRPID_TURKIC* = 0x0006
  LGRPID_TURKISH* = 0x0006
  LGRPID_JAPANESE* = 0x0007
  LGRPID_KOREAN* = 0x0008
  LGRPID_TRADITIONAL_CHINESE* = 0x0009
  LGRPID_SIMPLIFIED_CHINESE* = 0x000a
  LGRPID_THAI* = 0x000b
  LGRPID_HEBREW* = 0x000c
  LGRPID_ARABIC* = 0x000d
  LGRPID_VIETNAMESE* = 0x000e
  LGRPID_INDIC* = 0x000f
  LGRPID_GEORGIAN* = 0x0010
  LGRPID_ARMENIAN* = 0x0011
  MUI_LANGUAGE_ID* = 0x4
  MUI_LANGUAGE_NAME* = 0x8
  MUI_MERGE_SYSTEM_FALLBACK* = 0x10
  MUI_MERGE_USER_FALLBACK* = 0x20
  MUI_UI_FALLBACK* = MUI_MERGE_SYSTEM_FALLBACK or MUI_MERGE_USER_FALLBACK
  MUI_THREAD_LANGUAGES* = 0x40
  MUI_CONSOLE_FILTER* = 0x100
  MUI_COMPLEX_SCRIPT_FILTER* = 0x200
  MUI_RESET_FILTERS* = 0x001
  MUI_USER_PREFERRED_UI_LANGUAGES* = 0x10
  MUI_USE_INSTALLED_LANGUAGES* = 0x20
  MUI_USE_SEARCH_ALL_LANGUAGES* = 0x40
  MUI_LANG_NEUTRAL_PE_FILE* = 0x100
  MUI_NON_LANG_NEUTRAL_FILE* = 0x200
  MUI_MACHINE_LANGUAGE_SETTINGS* = 0x400
  MUI_FILETYPE_NOT_LANGUAGE_NEUTRAL* = 0x001
  MUI_FILETYPE_LANGUAGE_NEUTRAL_MAIN* = 0x002
  MUI_FILETYPE_LANGUAGE_NEUTRAL_MUI* = 0x004
  MUI_QUERY_TYPE* = 0x001
  MUI_QUERY_CHECKSUM* = 0x002
  MUI_QUERY_LANGUAGE_NAME* = 0x004
  MUI_QUERY_RESOURCE_TYPES* = 0x008
  MUI_FILEINFO_VERSION* = 0x001
  MUI_FULL_LANGUAGE* = 0x01
  MUI_PARTIAL_LANGUAGE* = 0x02
  MUI_LIP_LANGUAGE* = 0x04
  MUI_LANGUAGE_INSTALLED* = 0x20
  MUI_LANGUAGE_LICENSED* = 0x40
  compareString* = 0x1
  GEOID_NOT_AVAILABLE* = -1
  GEO_NATION* = 0x0001
  GEO_LATITUDE* = 0x0002
  GEO_LONGITUDE* = 0x0003
  GEO_ISO2* = 0x0004
  GEO_ISO3* = 0x0005
  GEO_RFC1766* = 0x0006
  GEO_LCID* = 0x0007
  GEO_FRIENDLYNAME* = 0x0008
  GEO_OFFICIALNAME* = 0x0009
  GEO_TIMEZONES* = 0x000a
  GEO_OFFICIALLANGUAGES* = 0x000b
  GEO_ISO_UN_NUMBER* = 0x000c
  GEO_PARENT* = 0x000d
  GEOCLASS_NATION* = 16
  GEOCLASS_REGION* = 14
  GEOCLASS_ALL* = 0
  normalizationOther* = 0
  normalizationC* = 0x1
  normalizationD* = 0x2
  normalizationKC* = 0x5
  normalizationKD* = 0x6
  IDN_ALLOW_UNASSIGNED* = 0x01
  IDN_USE_STD3_ASCII_RULES* = 0x02
  IDN_EMAIL_ADDRESS* = 0x04
  IDN_RAW_PUNYCODE* = 0x08
  VS_ALLOW_LATIN* = 0x0001
  GSS_ALLOW_INHERITED_COMMON* = 0x0001
  MUI_FORMAT_REG_COMPAT* = 0x0001
  MUI_FORMAT_INF_COMPAT* = 0x0002
  MUI_VERIFY_FILE_EXISTS* = 0x0004
  MUI_SKIP_STRING_CACHE* = 0x0008
  MUI_IMMUTABLE_LOOKUP* = 0x0010
  LOCALE_NAME_USER_DEFAULT* = NULL
  LOCALE_NAME_INVARIANT* = ""
  LOCALE_NAME_SYSTEM_DEFAULT* = "!x-sys-default-locale"
type
  LANGUAGEGROUP_ENUMPROCA* = proc (P1: LGRPID, P2: LPSTR, P3: LPSTR, P4: DWORD, P5: LONG_PTR): WINBOOL {.stdcall.}
  LANGGROUPLOCALE_ENUMPROCA* = proc (P1: LGRPID, P2: LCID, P3: LPSTR, P4: LONG_PTR): WINBOOL {.stdcall.}
  UILANGUAGE_ENUMPROCA* = proc (P1: LPSTR, P2: LONG_PTR): WINBOOL {.stdcall.}
  CODEPAGE_ENUMPROCA* = proc (P1: LPSTR): WINBOOL {.stdcall.}
  DATEFMT_ENUMPROCA* = proc (P1: LPSTR): WINBOOL {.stdcall.}
  DATEFMT_ENUMPROCEXA* = proc (P1: LPSTR, P2: CALID): WINBOOL {.stdcall.}
  TIMEFMT_ENUMPROCA* = proc (P1: LPSTR): WINBOOL {.stdcall.}
  CALINFO_ENUMPROCA* = proc (P1: LPSTR): WINBOOL {.stdcall.}
  CALINFO_ENUMPROCEXA* = proc (P1: LPSTR, P2: CALID): WINBOOL {.stdcall.}
  LOCALE_ENUMPROCA* = proc (P1: LPSTR): WINBOOL {.stdcall.}
  LOCALE_ENUMPROCW* = proc (P1: LPWSTR): WINBOOL {.stdcall.}
  LANGUAGEGROUP_ENUMPROCW* = proc (P1: LGRPID, P2: LPWSTR, P3: LPWSTR, P4: DWORD, P5: LONG_PTR): WINBOOL {.stdcall.}
  LANGGROUPLOCALE_ENUMPROCW* = proc (P1: LGRPID, P2: LCID, P3: LPWSTR, P4: LONG_PTR): WINBOOL {.stdcall.}
  UILANGUAGE_ENUMPROCW* = proc (P1: LPWSTR, P2: LONG_PTR): WINBOOL {.stdcall.}
  CODEPAGE_ENUMPROCW* = proc (P1: LPWSTR): WINBOOL {.stdcall.}
  DATEFMT_ENUMPROCW* = proc (P1: LPWSTR): WINBOOL {.stdcall.}
  DATEFMT_ENUMPROCEXW* = proc (P1: LPWSTR, P2: CALID): WINBOOL {.stdcall.}
  TIMEFMT_ENUMPROCW* = proc (P1: LPWSTR): WINBOOL {.stdcall.}
  CALINFO_ENUMPROCW* = proc (P1: LPWSTR): WINBOOL {.stdcall.}
  CALINFO_ENUMPROCEXW* = proc (P1: LPWSTR, P2: CALID): WINBOOL {.stdcall.}
  GEO_ENUMPROC* = proc (P1: GEOID): WINBOOL {.stdcall.}
  CALINFO_ENUMPROCEXEX* = proc (P1: LPWSTR, P2: CALID, P3: LPWSTR, P4: LPARAM): WINBOOL {.stdcall.}
  DATEFMT_ENUMPROCEXEX* = proc (P1: LPWSTR, P2: CALID, P3: LPARAM): WINBOOL {.stdcall.}
  TIMEFMT_ENUMPROCEX* = proc (P1: LPWSTR, P2: LPARAM): WINBOOL {.stdcall.}
  LOCALE_ENUMPROCEX* = proc (P1: LPWSTR, P2: DWORD, P3: LPARAM): WINBOOL {.stdcall.}
proc GetTimeFormatEx*(lpLocaleName: LPCWSTR, dwFlags: DWORD, lpTime: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpTimeStr: LPWSTR, cchTime: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDateFormatEx*(lpLocaleName: LPCWSTR, dwFlags: DWORD, lpDate: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpDateStr: LPWSTR, cchDate: int32, lpCalendar: LPCWSTR): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDateFormatA*(Locale: LCID, dwFlags: DWORD, lpDate: ptr SYSTEMTIME, lpFormat: LPCSTR, lpDateStr: LPSTR, cchDate: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDateFormatW*(Locale: LCID, dwFlags: DWORD, lpDate: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpDateStr: LPWSTR, cchDate: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTimeFormatA*(Locale: LCID, dwFlags: DWORD, lpTime: ptr SYSTEMTIME, lpFormat: LPCSTR, lpTimeStr: LPSTR, cchTime: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetTimeFormatW*(Locale: LCID, dwFlags: DWORD, lpTime: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpTimeStr: LPWSTR, cchTime: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CompareStringW*(Locale: LCID, dwCmpFlags: DWORD, lpString1: PCNZWCH, cchCount1: int32, lpString2: PCNZWCH, cchCount2: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FoldStringW*(dwMapFlags: DWORD, lpSrcStr: LPCWCH, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStringTypeExW*(Locale: LCID, dwInfoType: DWORD, lpSrcStr: LPCWCH, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CompareStringEx*(lpLocaleName: LPCWSTR, dwCmpFlags: DWORD, lpString1: LPCWCH, cchCount1: int32, lpString2: LPCWCH, cchCount2: int32, lpVersionInformation: LPNLSVERSIONINFO, lpReserved: LPVOID, lParam: LPARAM): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CompareStringOrdinal*(lpString1: LPCWCH, cchCount1: int32, lpString2: LPCWCH, cchCount2: int32, bIgnoreCase: WINBOOL): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStringTypeW*(dwInfoType: DWORD, lpSrcStr: LPCWCH, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc MultiByteToWideChar*(CodePage: UINT, dwFlags: DWORD, lpMultiByteStr: LPCCH, cbMultiByte: int32, lpWideCharStr: LPWSTR, cchWideChar: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc WideCharToMultiByte*(CodePage: UINT, dwFlags: DWORD, lpWideCharStr: LPCWCH, cchWideChar: int32, lpMultiByteStr: LPSTR, cbMultiByte: int32, lpDefaultChar: LPCCH, lpUsedDefaultChar: LPBOOL): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsValidCodePage*(CodePage: UINT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetACP*(): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetOEMCP*(): UINT {.winapi, stdcall, dynlib: "kernel32", importc.}
proc CompareStringA*(Locale: LCID, dwCmpFlags: DWORD, lpString1: PCNZCH, cchCount1: int32, lpString2: PCNZCH, cchCount2: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LCMapStringW*(Locale: LCID, dwMapFlags: DWORD, lpSrcStr: LPCWSTR, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LCMapStringA*(Locale: LCID, dwMapFlags: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpDestStr: LPSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLocaleInfoW*(Locale: LCID, LCType: LCTYPE, lpLCData: LPWSTR, cchData: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLocaleInfoA*(Locale: LCID, LCType: LCTYPE, lpLCData: LPSTR, cchData: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsDBCSLeadByte*(TestChar: BYTE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsDBCSLeadByteEx*(CodePage: UINT, TestChar: BYTE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumberFormatA*(Locale: LCID, dwFlags: DWORD, lpValue: LPCSTR, lpFormat: ptr NUMBERFMTA, lpNumberStr: LPSTR, cchNumber: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumberFormatW*(Locale: LCID, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr NUMBERFMTW, lpNumberStr: LPWSTR, cchNumber: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrencyFormatA*(Locale: LCID, dwFlags: DWORD, lpValue: LPCSTR, lpFormat: ptr CURRENCYFMTA, lpCurrencyStr: LPSTR, cchCurrency: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrencyFormatW*(Locale: LCID, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr CURRENCYFMTW, lpCurrencyStr: LPWSTR, cchCurrency: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumCalendarInfoA*(lpCalInfoEnumProc: CALINFO_ENUMPROCA, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumCalendarInfoW*(lpCalInfoEnumProc: CALINFO_ENUMPROCW, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumCalendarInfoExA*(lpCalInfoEnumProcEx: CALINFO_ENUMPROCEXA, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumCalendarInfoExW*(lpCalInfoEnumProcEx: CALINFO_ENUMPROCEXW, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumTimeFormatsA*(lpTimeFmtEnumProc: TIMEFMT_ENUMPROCA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumTimeFormatsW*(lpTimeFmtEnumProc: TIMEFMT_ENUMPROCW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDateFormatsA*(lpDateFmtEnumProc: DATEFMT_ENUMPROCA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDateFormatsW*(lpDateFmtEnumProc: DATEFMT_ENUMPROCW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDateFormatsExA*(lpDateFmtEnumProcEx: DATEFMT_ENUMPROCEXA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDateFormatsExW*(lpDateFmtEnumProcEx: DATEFMT_ENUMPROCEXW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsValidLanguageGroup*(LanguageGroup: LGRPID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNLSVersion*(Function: NLS_FUNCTION, Locale: LCID, lpVersionInformation: LPNLSVERSIONINFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsNLSDefinedString*(Function: NLS_FUNCTION, dwFlags: DWORD, lpVersionInformation: LPNLSVERSIONINFO, lpString: LPCWSTR, cchStr: INT): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsValidLocale*(Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetLocaleInfoA*(Locale: LCID, LCType: LCTYPE, lpLCData: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetLocaleInfoW*(Locale: LCID, LCType: LCTYPE, lpLCData: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCalendarInfoA*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPSTR, cchData: int32, lpValue: LPDWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCalendarInfoW*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPWSTR, cchData: int32, lpValue: LPDWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCalendarInfoA*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetCalendarInfoW*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDurationFormat*(Locale: LCID, dwFlags: DWORD, lpDuration: ptr SYSTEMTIME, ullDuration: ULONGLONG, lpFormat: LPCWSTR, lpDurationStr: LPWSTR, cchDuration: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNLSString*(Locale: LCID, dwFindNLSStringFlags: DWORD, lpStringSource: LPCWSTR, cchSource: int32, lpStringValue: LPCWSTR, cchValue: int32, pcchFound: LPINT): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetGeoInfoA*(Location: GEOID, GeoType: GEOTYPE, lpGeoData: LPSTR, cchData: int32, LangId: LANGID): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetGeoInfoW*(Location: GEOID, GeoType: GEOTYPE, lpGeoData: LPWSTR, cchData: int32, LangId: LANGID): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemGeoID*(GeoClass: GEOCLASS, ParentGeoId: GEOID, lpGeoEnumProc: GEO_ENUMPROC): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserGeoID*(GeoClass: GEOCLASS): GEOID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCPInfo*(CodePage: UINT, lpCPInfo: LPCPINFO): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCPInfoExA*(CodePage: UINT, dwFlags: DWORD, lpCPInfoEx: LPCPINFOEXA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCPInfoExW*(CodePage: UINT, dwFlags: DWORD, lpCPInfoEx: LPCPINFOEXW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LCIDToLocaleName*(Locale: LCID, lpName: LPWSTR, cchName: int32, dwFlags: DWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LocaleNameToLCID*(lpName: LPCWSTR, dwFlags: DWORD): LCID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetUserGeoID*(GeoId: GEOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ConvertDefaultLocale*(Locale: LCID): LCID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadLocale*(): LCID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadLocale*(Locale: LCID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDefaultUILanguage*(): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserDefaultUILanguage*(): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDefaultLangID*(): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserDefaultLangID*(): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDefaultLCID*(): LCID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserDefaultLCID*(): LCID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadUILanguage*(LangId: LANGID): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStringTypeExA*(Locale: LCID, dwInfoType: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStringTypeA*(Locale: LCID, dwInfoType: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FoldStringA*(dwMapFlags: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpDestStr: LPSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemLocalesA*(lpLocaleEnumProc: LOCALE_ENUMPROCA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemLocalesW*(lpLocaleEnumProc: LOCALE_ENUMPROCW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemLanguageGroupsA*(lpLanguageGroupEnumProc: LANGUAGEGROUP_ENUMPROCA, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemLanguageGroupsW*(lpLanguageGroupEnumProc: LANGUAGEGROUP_ENUMPROCW, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumLanguageGroupLocalesA*(lpLangGroupLocaleEnumProc: LANGGROUPLOCALE_ENUMPROCA, LanguageGroup: LGRPID, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumLanguageGroupLocalesW*(lpLangGroupLocaleEnumProc: LANGGROUPLOCALE_ENUMPROCW, LanguageGroup: LGRPID, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumUILanguagesA*(lpUILanguageEnumProc: UILANGUAGE_ENUMPROCA, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumUILanguagesW*(lpUILanguageEnumProc: UILANGUAGE_ENUMPROCW, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadUILanguage*(): LANGID {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetProcessPreferredUILanguages*(dwFlags: DWORD, pulNumLanguages: PULONG, pwszLanguagesBuffer: PZZWSTR, pcchLanguagesBuffer: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetProcessPreferredUILanguages*(dwFlags: DWORD, pwszLanguagesBuffer: PCZZWSTR, pulNumLanguages: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserPreferredUILanguages*(dwFlags: DWORD, pulNumLanguages: PULONG, pwszLanguagesBuffer: PZZWSTR, pcchLanguagesBuffer: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemPreferredUILanguages*(dwFlags: DWORD, pulNumLanguages: PULONG, pwszLanguagesBuffer: PZZWSTR, pcchLanguagesBuffer: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetThreadPreferredUILanguages*(dwFlags: DWORD, pulNumLanguages: PULONG, pwszLanguagesBuffer: PZZWSTR, pcchLanguagesBuffer: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc SetThreadPreferredUILanguages*(dwFlags: DWORD, pwszLanguagesBuffer: PCZZWSTR, pulNumLanguages: PULONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileMUIInfo*(dwFlags: DWORD, pcwszFilePath: PCWSTR, pFileMUIInfo: PFILEMUIINFO, pcbFileMUIInfo: ptr DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetFileMUIPath*(dwFlags: DWORD, pcwszFilePath: PCWSTR, pwszLanguage: PWSTR, pcchLanguage: PULONG, pwszFileMUIPath: PWSTR, pcchFileMUIPath: PULONG, pululEnumerator: PULONGLONG): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUILanguageInfo*(dwFlags: DWORD, pwmszLanguage: PCZZWSTR, pwszFallbackLanguages: PZZWSTR, pcchFallbackLanguages: PDWORD, pAttributes: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc NotifyUILanguageChange*(dwFlags: DWORD, pcwstrNewLanguage: PCWSTR, pcwstrPreviousLanguage: PCWSTR, dwReserved: DWORD, pdwStatusRtrn: PDWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemCodePagesA*(lpCodePageEnumProc: CODEPAGE_ENUMPROCA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemCodePagesW*(lpCodePageEnumProc: CODEPAGE_ENUMPROCW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc NormalizeString*(NormForm: NORM_FORM, lpSrcString: LPCWSTR, cwSrcLength: int32, lpDstString: LPWSTR, cwDstLength: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsNormalizedString*(NormForm: NORM_FORM, lpString: LPCWSTR, cwLength: int32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IdnToAscii*(dwFlags: DWORD, lpUnicodeCharStr: LPCWSTR, cchUnicodeChar: int32, lpASCIICharStr: LPWSTR, cchASCIIChar: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IdnToNameprepUnicode*(dwFlags: DWORD, lpUnicodeCharStr: LPCWSTR, cchUnicodeChar: int32, lpNameprepCharStr: LPWSTR, cchNameprepChar: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IdnToUnicode*(dwFlags: DWORD, lpASCIICharStr: LPCWSTR, cchASCIIChar: int32, lpUnicodeCharStr: LPWSTR, cchUnicodeChar: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc VerifyScripts*(dwFlags: DWORD, lpLocaleScripts: LPCWSTR, cchLocaleScripts: int32, lpTestScripts: LPCWSTR, cchTestScripts: int32): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetStringScripts*(dwFlags: DWORD, lpString: LPCWSTR, cchString: int32, lpScripts: LPWSTR, cchScripts: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetLocaleInfoEx*(lpLocaleName: LPCWSTR, LCType: LCTYPE, lpLCData: LPWSTR, cchData: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCalendarInfoEx*(lpLocaleName: LPCWSTR, Calendar: CALID, lpReserved: LPCWSTR, CalType: CALTYPE, lpCalData: LPWSTR, cchData: int32, lpValue: LPDWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetDurationFormatEx*(lpLocaleName: LPCWSTR, dwFlags: DWORD, lpDuration: ptr SYSTEMTIME, ullDuration: ULONGLONG, lpFormat: LPCWSTR, lpDurationStr: LPWSTR, cchDuration: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNumberFormatEx*(lpLocaleName: LPCWSTR, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr NUMBERFMTW, lpNumberStr: LPWSTR, cchNumber: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetCurrencyFormatEx*(lpLocaleName: LPCWSTR, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr CURRENCYFMTW, lpCurrencyStr: LPWSTR, cchCurrency: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetUserDefaultLocaleName*(lpLocaleName: LPWSTR, cchLocaleName: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetSystemDefaultLocaleName*(lpLocaleName: LPWSTR, cchLocaleName: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc GetNLSVersionEx*(function: NLS_FUNCTION, lpLocaleName: LPCWSTR, lpVersionInformation: LPNLSVERSIONINFOEX): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc FindNLSStringEx*(lpLocaleName: LPCWSTR, dwFindNLSStringFlags: DWORD, lpStringSource: LPCWSTR, cchSource: int32, lpStringValue: LPCWSTR, cchValue: int32, pcchFound: LPINT, lpVersionInformation: LPNLSVERSIONINFO, lpReserved: LPVOID, sortHandle: LPARAM): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc LCMapStringEx*(lpLocaleName: LPCWSTR, dwMapFlags: DWORD, lpSrcStr: LPCWSTR, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32, lpVersionInformation: LPNLSVERSIONINFO, lpReserved: LPVOID, sortHandle: LPARAM): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsValidLocaleName*(lpLocaleName: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumCalendarInfoExEx*(pCalInfoEnumProcExEx: CALINFO_ENUMPROCEXEX, lpLocaleName: LPCWSTR, Calendar: CALID, lpReserved: LPCWSTR, CalType: CALTYPE, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumDateFormatsExEx*(lpDateFmtEnumProcExEx: DATEFMT_ENUMPROCEXEX, lpLocaleName: LPCWSTR, dwFlags: DWORD, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumTimeFormatsEx*(lpTimeFmtEnumProcEx: TIMEFMT_ENUMPROCEX, lpLocaleName: LPCWSTR, dwFlags: DWORD, lParam: LPARAM): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc EnumSystemLocalesEx*(lpLocaleEnumProcEx: LOCALE_ENUMPROCEX, dwFlags: DWORD, lParam: LPARAM, lpReserved: LPVOID): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc.}
proc ResolveLocaleName*(lpNameToResolve: LPCWSTR, lpLocaleName: LPWSTR, cchLocaleName: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc.}
proc IsValidNLSVersion*(function: NLS_FUNCTION, lpLocaleName: LPCWSTR, lpVersionInformation: LPNLSVERSIONINFOEX): DWORD {.winapi, stdcall, dynlib: "kernel32", importc.}
template IS_HIGH_SURROGATE*(wch: untyped): bool = (wch >= HIGH_SURROGATE_START) and (wch <= HIGH_SURROGATE_END)
template IS_LOW_SURROGATE*(wch: untyped): bool = (wch >= LOW_SURROGATE_START) and (wch <= LOW_SURROGATE_END)
template IS_SURROGATE_PAIR*(hs: untyped, ls: untyped): bool = IS_HIGH_SURROGATE(hs) and IS_LOW_SURROGATE(ls)
template FILEMUIINFO_GET_CULTURE*(pInfo: PFILEMUIINFO): LPWSTR = cast[LPWSTR](if pInfo.dwLanguageNameOffset > 0: cast[int](pInfo) + pInfo.dwLanguageNameOffset else: 0)
template FILEMUIINFO_GET_MAIN_TYPEIDS*(pInfo: PFILEMUIINFO): PDWORD = cast[PDWORD](if pInfo.dwTypeIDMainOffset > 0: cast[int](pInfo) + pInfo.dwTypeIDMainOffset else: 0)
template FILEMUIINFO_GET_MAIN_TYPEID*(pInfo: PFILEMUIINFO, iType: DWORD): DWORD = (if (iType < pInfo.dwTypeIDMainSize) and (pInfo.dwTypeIDMainOffset > 0): (cast[PDWORD](cast[int](pInfo) + pInfo.dwTypeIDMainOffset + iType * sizeof(DWORD)))[] else: 0)
template FILEMUIINFO_GET_MAIN_TYPENAMES*(pInfo: PFILEMUIINFO): LPWSTR = cast[LPWSTR](if pInfo.dwTypeNameMainOffset > 0: cast[int](pInfo) + pInfo.dwTypeNameMainOffset else: 0)
template FILEMUIINFO_GET_MUI_TYPEIDS*(pInfo: PFILEMUIINFO): PDWORD = cast[PDWORD](if pInfo.dwTypeIDMUIOffset > 0: cast[int](pInfo) + pInfo.dwTypeIDMUIOffset else: 0)
template FILEMUIINFO_GET_MUI_TYPEID*(pInfo: PFILEMUIINFO, iType): DWORD = (if (iType < pInfo.dwTypeIDMUISize) and (pInfo.dwTypeIDMUIOffset > 0): (cast[PDWORD](cast[int](pInfo) + pInfo.dwTypeIDMUIOffset + iType * sizeof(DWORD)))[] else: 0)
template FILEMUIINFO_GET_MUI_TYPENAMES*(pInfo: PFILEMUIINFO): LPWSTR = cast[LPWSTR](if pInfo.dwTypeNameMUIOffset > 0: cast[int](pInfo) + pInfo.dwTypeNameMUIOffset else: 0)
when winimUnicode:
  type
    LANGUAGEGROUP_ENUMPROC* = LANGUAGEGROUP_ENUMPROCW
    LANGGROUPLOCALE_ENUMPROC* = LANGGROUPLOCALE_ENUMPROCW
    UILANGUAGE_ENUMPROC* = UILANGUAGE_ENUMPROCW
    CODEPAGE_ENUMPROC* = CODEPAGE_ENUMPROCW
    DATEFMT_ENUMPROC* = DATEFMT_ENUMPROCW
    DATEFMT_ENUMPROCEX* = DATEFMT_ENUMPROCEXW
    TIMEFMT_ENUMPROC* = TIMEFMT_ENUMPROCW
    CALINFO_ENUMPROC* = CALINFO_ENUMPROCW
    CALINFO_ENUMPROCEX* = CALINFO_ENUMPROCEXW
    LOCALE_ENUMPROC* = LOCALE_ENUMPROCW
    CPINFOEX* = CPINFOEXW
    LPCPINFOEX* = LPCPINFOEXW
    NUMBERFMT* = NUMBERFMTW
    LPNUMBERFMT* = LPNUMBERFMTW
    CURRENCYFMT* = CURRENCYFMTW
    LPCURRENCYFMT* = LPCURRENCYFMTW
  proc CompareString*(Locale: LCID, dwCmpFlags: DWORD, lpString1: PCNZWCH, cchCount1: int32, lpString2: PCNZWCH, cchCount2: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "CompareStringW".}
  proc FoldString*(dwMapFlags: DWORD, lpSrcStr: LPCWCH, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "FoldStringW".}
  proc GetStringTypeEx*(Locale: LCID, dwInfoType: DWORD, lpSrcStr: LPCWCH, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetStringTypeExW".}
  proc LCMapString*(Locale: LCID, dwMapFlags: DWORD, lpSrcStr: LPCWSTR, cchSrc: int32, lpDestStr: LPWSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "LCMapStringW".}
  proc GetLocaleInfo*(Locale: LCID, LCType: LCTYPE, lpLCData: LPWSTR, cchData: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetLocaleInfoW".}
  proc GetDateFormat*(Locale: LCID, dwFlags: DWORD, lpDate: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpDateStr: LPWSTR, cchDate: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetDateFormatW".}
  proc GetTimeFormat*(Locale: LCID, dwFlags: DWORD, lpTime: ptr SYSTEMTIME, lpFormat: LPCWSTR, lpTimeStr: LPWSTR, cchTime: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetTimeFormatW".}
  proc SetLocaleInfo*(Locale: LCID, LCType: LCTYPE, lpLCData: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetLocaleInfoW".}
  proc GetCalendarInfo*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPWSTR, cchData: int32, lpValue: LPDWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetCalendarInfoW".}
  proc SetCalendarInfo*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPCWSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetCalendarInfoW".}
  proc GetNumberFormat*(Locale: LCID, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr NUMBERFMTW, lpNumberStr: LPWSTR, cchNumber: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetNumberFormatW".}
  proc GetCurrencyFormat*(Locale: LCID, dwFlags: DWORD, lpValue: LPCWSTR, lpFormat: ptr CURRENCYFMTW, lpCurrencyStr: LPWSTR, cchCurrency: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetCurrencyFormatW".}
  proc EnumCalendarInfo*(lpCalInfoEnumProc: CALINFO_ENUMPROCW, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumCalendarInfoW".}
  proc EnumCalendarInfoEx*(lpCalInfoEnumProcEx: CALINFO_ENUMPROCEXW, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumCalendarInfoExW".}
  proc EnumTimeFormats*(lpTimeFmtEnumProc: TIMEFMT_ENUMPROCW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumTimeFormatsW".}
  proc EnumDateFormats*(lpDateFmtEnumProc: DATEFMT_ENUMPROCW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumDateFormatsW".}
  proc EnumDateFormatsEx*(lpDateFmtEnumProcEx: DATEFMT_ENUMPROCEXW, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumDateFormatsExW".}
  proc GetGeoInfo*(Location: GEOID, GeoType: GEOTYPE, lpGeoData: LPWSTR, cchData: int32, LangId: LANGID): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetGeoInfoW".}
  proc GetCPInfoEx*(CodePage: UINT, dwFlags: DWORD, lpCPInfoEx: LPCPINFOEXW): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetCPInfoExW".}
  proc EnumSystemLocales*(lpLocaleEnumProc: LOCALE_ENUMPROCW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemLocalesW".}
  proc EnumSystemLanguageGroups*(lpLanguageGroupEnumProc: LANGUAGEGROUP_ENUMPROCW, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemLanguageGroupsW".}
  proc EnumLanguageGroupLocales*(lpLangGroupLocaleEnumProc: LANGGROUPLOCALE_ENUMPROCW, LanguageGroup: LGRPID, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumLanguageGroupLocalesW".}
  proc EnumUILanguages*(lpUILanguageEnumProc: UILANGUAGE_ENUMPROCW, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumUILanguagesW".}
  proc EnumSystemCodePages*(lpCodePageEnumProc: CODEPAGE_ENUMPROCW, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemCodePagesW".}
when winimAnsi:
  type
    LANGUAGEGROUP_ENUMPROC* = LANGUAGEGROUP_ENUMPROCA
    LANGGROUPLOCALE_ENUMPROC* = LANGGROUPLOCALE_ENUMPROCA
    UILANGUAGE_ENUMPROC* = UILANGUAGE_ENUMPROCA
    CODEPAGE_ENUMPROC* = CODEPAGE_ENUMPROCA
    DATEFMT_ENUMPROC* = DATEFMT_ENUMPROCA
    DATEFMT_ENUMPROCEX* = DATEFMT_ENUMPROCEXA
    TIMEFMT_ENUMPROC* = TIMEFMT_ENUMPROCA
    CALINFO_ENUMPROC* = CALINFO_ENUMPROCA
    CALINFO_ENUMPROCEX* = CALINFO_ENUMPROCEXA
    LOCALE_ENUMPROC* = LOCALE_ENUMPROCA
    CPINFOEX* = CPINFOEXA
    LPCPINFOEX* = LPCPINFOEXA
    NUMBERFMT* = NUMBERFMTA
    LPNUMBERFMT* = LPNUMBERFMTA
    CURRENCYFMT* = CURRENCYFMTA
    LPCURRENCYFMT* = LPCURRENCYFMTA
  proc CompareString*(Locale: LCID, dwCmpFlags: DWORD, lpString1: PCNZCH, cchCount1: int32, lpString2: PCNZCH, cchCount2: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "CompareStringA".}
  proc LCMapString*(Locale: LCID, dwMapFlags: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpDestStr: LPSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "LCMapStringA".}
  proc GetLocaleInfo*(Locale: LCID, LCType: LCTYPE, lpLCData: LPSTR, cchData: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetLocaleInfoA".}
  proc FoldString*(dwMapFlags: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpDestStr: LPSTR, cchDest: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "FoldStringA".}
  proc GetStringTypeEx*(Locale: LCID, dwInfoType: DWORD, lpSrcStr: LPCSTR, cchSrc: int32, lpCharType: LPWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetStringTypeExA".}
  proc GetDateFormat*(Locale: LCID, dwFlags: DWORD, lpDate: ptr SYSTEMTIME, lpFormat: LPCSTR, lpDateStr: LPSTR, cchDate: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetDateFormatA".}
  proc GetTimeFormat*(Locale: LCID, dwFlags: DWORD, lpTime: ptr SYSTEMTIME, lpFormat: LPCSTR, lpTimeStr: LPSTR, cchTime: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetTimeFormatA".}
  proc SetLocaleInfo*(Locale: LCID, LCType: LCTYPE, lpLCData: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetLocaleInfoA".}
  proc GetCalendarInfo*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPSTR, cchData: int32, lpValue: LPDWORD): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetCalendarInfoA".}
  proc SetCalendarInfo*(Locale: LCID, Calendar: CALID, CalType: CALTYPE, lpCalData: LPCSTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "SetCalendarInfoA".}
  proc GetNumberFormat*(Locale: LCID, dwFlags: DWORD, lpValue: LPCSTR, lpFormat: ptr NUMBERFMTA, lpNumberStr: LPSTR, cchNumber: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetNumberFormatA".}
  proc GetCurrencyFormat*(Locale: LCID, dwFlags: DWORD, lpValue: LPCSTR, lpFormat: ptr CURRENCYFMTA, lpCurrencyStr: LPSTR, cchCurrency: int32): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetCurrencyFormatA".}
  proc EnumCalendarInfo*(lpCalInfoEnumProc: CALINFO_ENUMPROCA, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumCalendarInfoA".}
  proc EnumCalendarInfoEx*(lpCalInfoEnumProcEx: CALINFO_ENUMPROCEXA, Locale: LCID, Calendar: CALID, CalType: CALTYPE): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumCalendarInfoExA".}
  proc EnumTimeFormats*(lpTimeFmtEnumProc: TIMEFMT_ENUMPROCA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumTimeFormatsA".}
  proc EnumDateFormats*(lpDateFmtEnumProc: DATEFMT_ENUMPROCA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumDateFormatsA".}
  proc EnumDateFormatsEx*(lpDateFmtEnumProcEx: DATEFMT_ENUMPROCEXA, Locale: LCID, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumDateFormatsExA".}
  proc GetGeoInfo*(Location: GEOID, GeoType: GEOTYPE, lpGeoData: LPSTR, cchData: int32, LangId: LANGID): int32 {.winapi, stdcall, dynlib: "kernel32", importc: "GetGeoInfoA".}
  proc GetCPInfoEx*(CodePage: UINT, dwFlags: DWORD, lpCPInfoEx: LPCPINFOEXA): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "GetCPInfoExA".}
  proc EnumSystemLocales*(lpLocaleEnumProc: LOCALE_ENUMPROCA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemLocalesA".}
  proc EnumSystemLanguageGroups*(lpLanguageGroupEnumProc: LANGUAGEGROUP_ENUMPROCA, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemLanguageGroupsA".}
  proc EnumLanguageGroupLocales*(lpLangGroupLocaleEnumProc: LANGGROUPLOCALE_ENUMPROCA, LanguageGroup: LGRPID, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumLanguageGroupLocalesA".}
  proc EnumUILanguages*(lpUILanguageEnumProc: UILANGUAGE_ENUMPROCA, dwFlags: DWORD, lParam: LONG_PTR): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumUILanguagesA".}
  proc EnumSystemCodePages*(lpCodePageEnumProc: CODEPAGE_ENUMPROCA, dwFlags: DWORD): WINBOOL {.winapi, stdcall, dynlib: "kernel32", importc: "EnumSystemCodePagesA".}
