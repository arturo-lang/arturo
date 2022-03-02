#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import wingdi
import objbase
#include <gdiplus.h>
#include <gdiplus/gdiplus.h>
#include <gdiplusenums.h>
#include <gdiplustypes.h>
#include <gdiplusgpstubs.h>
#include <gdiplusimaging.h>
#include <gdiplusinit.h>
#include <gdiplusmem.h>
#include <gdiplusmetaheader.h>
#include <gdipluspixelformats.h>
#include <gdipluscolor.h>
#include <gdipluscolormatrix.h>
#include <gdiplusflat.h>
#include <gdipluseffects.h>
#include <gdiplusimagecodec.h>
type
  GpBrushType* = int32
  CombineMode* = int32
  CompositingMode* = int32
  CompositingQuality* = int32
  GpCoordinateSpace* = int32
  CustomLineCapType* = int32
  GpDashCap* = int32
  GpDashStyle* = int32
  DitherType* = int32
  DriverStringOptions* = int32
  EmfPlusRecordType* = int32
  EmfToWmfBitsFlags* = int32
  EmfType* = int32
  EncoderParameterValueType* = int32
  EncoderValue* = int32
  GpFillMode* = int32
  GpFlushIntention* = int32
  FontStyle* = int32
  GpHatchStyle* = int32
  HotkeyPrefix* = int32
  ImageType* = int32
  InterpolationMode* = int32
  LinearGradientMode* = int32
  GpLineCap* = int32
  GpLineJoin* = int32
  GpMatrixOrder* = int32
  MetafileFrameUnit* = int32
  MetafileType* = int32
  ObjectType* = int32
  PathPointType* = int32
  GpPenAlignment* = int32
  GpPenType* = int32
  PixelOffsetMode* = int32
  QualityMode* = int32
  SmoothingMode* = int32
  StringAlignment* = int32
  StringDigitSubstitute* = int32
  StringFormatFlags* = int32
  StringTrimming* = int32
  TextRenderingHint* = int32
  GpUnit* = int32
  WarpMode* = int32
  GpWrapMode* = int32
  GpTestControlEnum* = int32
  GpStatus* = int32
  DebugEventProc* = pointer
  DrawImageAbort* = pointer
  GetThumbnailImageAbort* = pointer
  ImageCodecFlags* = int32
  ImageFlags* = int32
  ImageLockMode* = int32
  ItemDataPosition* = int32
  RotateFlipType* = int32
  PaletteFlags* = int32
  PaletteType* = int32
  ColorChannelFlags* = int32
  ColorAdjustType* = int32
  ColorMatrixFlags* = int32
  HistogramFormat* = int32
  CurveAdjustments* = int32
  CurveChannel* = int32
  GraphicsContainer* = DWORD
  GraphicsState* = DWORD
  ARGB* = DWORD
  REAL* = float32
  ENHMETAHEADER3* {.pure.} = object
    iType*: DWORD
    nSize*: DWORD
    rclBounds*: RECTL
    rclFrame*: RECTL
    dSignature*: DWORD
    nVersion*: DWORD
    nBytes*: DWORD
    nRecords*: DWORD
    nHandles*: WORD
    sReserved*: WORD
    nDescription*: DWORD
    offDescription*: DWORD
    nPalEntries*: DWORD
    szlDevice*: SIZEL
    szlMillimeters*: SIZEL
  LPENHMETAHEADER3* = ptr ENHMETAHEADER3
  PixelFormat* = INT
  ColorChannelLUT* = array[256, BYTE]
const
  brushTypeSolidColor* = 0
  brushTypeHatchFill* = 1
  brushTypeTextureFill* = 2
  brushTypePathGradient* = 3
  brushTypeLinearGradient* = 4
  combineModeReplace* = 0
  combineModeIntersect* = 1
  combineModeUnion* = 2
  combineModeXor* = 3
  combineModeExclude* = 4
  combineModeComplement* = 5
  compositingModeSourceOver* = 0
  compositingModeSourceCopy* = 1
  compositingQualityDefault* = 0
  compositingQualityHighSpeed* = 1
  compositingQualityHighQuality* = 2
  compositingQualityGammaCorrected* = 3
  compositingQualityAssumeLinear* = 4
  coordinateSpaceWorld* = 0
  coordinateSpacePage* = 1
  coordinateSpaceDevice* = 2
  customLineCapTypeDefault* = 0
  customLineCapTypeAdjustableArrow* = 1
  dashCapFlat* = 0
  dashCapRound* = 2
  dashCapTriangle* = 3
  dashStyleSolid* = 0
  dashStyleDash* = 1
  dashStyleDot* = 2
  dashStyleDashDot* = 3
  dashStyleDashDotDot* = 4
  dashStyleCustom* = 5
  ditherTypeNone* = 0
  ditherTypeSolid* = 1
  ditherTypeOrdered4x4* = 2
  ditherTypeOrdered8x8* = 3
  ditherTypeOrdered16x16* = 4
  ditherTypeOrdered91x91* = 5
  ditherTypeSpiral4x4* = 6
  ditherTypeSpiral8x8* = 7
  ditherTypeDualSpiral4x4* = 8
  ditherTypeDualSpiral8x8* = 9
  ditherTypeErrorDiffusion* = 10
  driverStringOptionsCmapLookup* = 1
  driverStringOptionsVertical* = 2
  driverStringOptionsRealizedAdvance* = 4
  driverStringOptionsLimitSubpixel* = 8
  GDIP_EMFPLUS_RECORD_BASE* = 0x4000
template GDIP_WMF_RECORD_TO_EMFPLUS*(meta: untyped): untyped = meta or 0x00010000
const
  wmfRecordTypeSetBkColor* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETBKCOLOR)
  wmfRecordTypeSetBkMode* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETBKMODE)
  wmfRecordTypeSetMapMode* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETMAPMODE)
  wmfRecordTypeSetROP2* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETROP2)
  wmfRecordTypeSetRelAbs* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETRELABS)
  wmfRecordTypeSetPolyFillMode* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETPOLYFILLMODE)
  wmfRecordTypeSetStretchBltMode* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETSTRETCHBLTMODE)
  wmfRecordTypeSetTextCharExtra* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETTEXTCHAREXTRA)
  wmfRecordTypeSetTextColor* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETTEXTCOLOR)
  wmfRecordTypeSetTextJustification* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETTEXTJUSTIFICATION)
  wmfRecordTypeSetWindowOrg* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETWINDOWORG)
  wmfRecordTypeSetWindowExt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETWINDOWEXT)
  wmfRecordTypeSetViewportOrg* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETVIEWPORTORG)
  wmfRecordTypeSetViewportExt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETVIEWPORTEXT)
  wmfRecordTypeOffsetWindowOrg* = GDIP_WMF_RECORD_TO_EMFPLUS(META_OFFSETWINDOWORG)
  wmfRecordTypeScaleWindowExt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SCALEWINDOWEXT)
  wmfRecordTypeOffsetViewportOrg* = GDIP_WMF_RECORD_TO_EMFPLUS(META_OFFSETVIEWPORTORG)
  wmfRecordTypeScaleViewportExt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SCALEVIEWPORTEXT)
  wmfRecordTypeLineTo* = GDIP_WMF_RECORD_TO_EMFPLUS(META_LINETO)
  wmfRecordTypeMoveTo* = GDIP_WMF_RECORD_TO_EMFPLUS(META_MOVETO)
  wmfRecordTypeExcludeClipRect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_EXCLUDECLIPRECT)
  wmfRecordTypeIntersectClipRect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_INTERSECTCLIPRECT)
  wmfRecordTypeArc* = GDIP_WMF_RECORD_TO_EMFPLUS(META_ARC)
  wmfRecordTypeEllipse* = GDIP_WMF_RECORD_TO_EMFPLUS(META_ELLIPSE)
  wmfRecordTypeFloodFill* = GDIP_WMF_RECORD_TO_EMFPLUS(META_FLOODFILL)
  wmfRecordTypePie* = GDIP_WMF_RECORD_TO_EMFPLUS(META_PIE)
  wmfRecordTypeRectangle* = GDIP_WMF_RECORD_TO_EMFPLUS(META_RECTANGLE)
  wmfRecordTypeRoundRect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_ROUNDRECT)
  wmfRecordTypePatBlt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_PATBLT)
  wmfRecordTypeSaveDC* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SAVEDC)
  wmfRecordTypeSetPixel* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETPIXEL)
  wmfRecordTypeOffsetClipRgn* = GDIP_WMF_RECORD_TO_EMFPLUS(META_OFFSETCLIPRGN)
  wmfRecordTypeTextOut* = GDIP_WMF_RECORD_TO_EMFPLUS(META_TEXTOUT)
  wmfRecordTypeBitBlt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_BITBLT)
  wmfRecordTypeStretchBlt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_STRETCHBLT)
  wmfRecordTypePolygon* = GDIP_WMF_RECORD_TO_EMFPLUS(META_POLYGON)
  wmfRecordTypePolyline* = GDIP_WMF_RECORD_TO_EMFPLUS(META_POLYLINE)
  wmfRecordTypeEscape* = GDIP_WMF_RECORD_TO_EMFPLUS(META_ESCAPE)
  wmfRecordTypeRestoreDC* = GDIP_WMF_RECORD_TO_EMFPLUS(META_RESTOREDC)
  wmfRecordTypeFillRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_FILLREGION)
  wmfRecordTypeFrameRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_FRAMEREGION)
  wmfRecordTypeInvertRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_INVERTREGION)
  wmfRecordTypePaintRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_PAINTREGION)
  wmfRecordTypeSelectClipRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SELECTCLIPREGION)
  wmfRecordTypeSelectObject* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SELECTOBJECT)
  wmfRecordTypeSetTextAlign* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETTEXTALIGN)
  wmfRecordTypeDrawText* = GDIP_WMF_RECORD_TO_EMFPLUS(0x062F)
  wmfRecordTypeChord* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CHORD)
  wmfRecordTypeSetMapperFlags* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETMAPPERFLAGS)
  wmfRecordTypeExtTextOut* = GDIP_WMF_RECORD_TO_EMFPLUS(META_EXTTEXTOUT)
  wmfRecordTypeSetDIBToDev* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETDIBTODEV)
  wmfRecordTypeSelectPalette* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SELECTPALETTE)
  wmfRecordTypeRealizePalette* = GDIP_WMF_RECORD_TO_EMFPLUS(META_REALIZEPALETTE)
  wmfRecordTypeAnimatePalette* = GDIP_WMF_RECORD_TO_EMFPLUS(META_ANIMATEPALETTE)
  wmfRecordTypeSetPalEntries* = GDIP_WMF_RECORD_TO_EMFPLUS(META_SETPALENTRIES)
  wmfRecordTypePolyPolygon* = GDIP_WMF_RECORD_TO_EMFPLUS(META_POLYPOLYGON)
  wmfRecordTypeResizePalette* = GDIP_WMF_RECORD_TO_EMFPLUS(META_RESIZEPALETTE)
  wmfRecordTypeDIBBitBlt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_DIBBITBLT)
  wmfRecordTypeDIBStretchBlt* = GDIP_WMF_RECORD_TO_EMFPLUS(META_DIBSTRETCHBLT)
  wmfRecordTypeDIBCreatePatternBrush* = GDIP_WMF_RECORD_TO_EMFPLUS(META_DIBCREATEPATTERNBRUSH)
  wmfRecordTypeStretchDIB* = GDIP_WMF_RECORD_TO_EMFPLUS(META_STRETCHDIB)
  wmfRecordTypeExtFloodFill* = GDIP_WMF_RECORD_TO_EMFPLUS(META_EXTFLOODFILL)
  wmfRecordTypeSetLayout* = GDIP_WMF_RECORD_TO_EMFPLUS(0x0149)
  wmfRecordTypeResetDC* = GDIP_WMF_RECORD_TO_EMFPLUS(0x014C)
  wmfRecordTypeStartDoc* = GDIP_WMF_RECORD_TO_EMFPLUS(0x014D)
  wmfRecordTypeStartPage* = GDIP_WMF_RECORD_TO_EMFPLUS(0x004F)
  wmfRecordTypeEndPage* = GDIP_WMF_RECORD_TO_EMFPLUS(0x0050)
  wmfRecordTypeAbortDoc* = GDIP_WMF_RECORD_TO_EMFPLUS(0x0052)
  wmfRecordTypeEndDoc* = GDIP_WMF_RECORD_TO_EMFPLUS(0x005E)
  wmfRecordTypeDeleteObject* = GDIP_WMF_RECORD_TO_EMFPLUS(META_DELETEOBJECT)
  wmfRecordTypeCreatePalette* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEPALETTE)
  wmfRecordTypeCreateBrush* = GDIP_WMF_RECORD_TO_EMFPLUS(0x00F8)
  wmfRecordTypeCreatePatternBrush* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEPATTERNBRUSH)
  wmfRecordTypeCreatePenIndirect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEPENINDIRECT)
  wmfRecordTypeCreateFontIndirect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEFONTINDIRECT)
  wmfRecordTypeCreateBrushIndirect* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEBRUSHINDIRECT)
  wmfRecordTypeCreateBitmapIndirect* = GDIP_WMF_RECORD_TO_EMFPLUS(0x02FD)
  wmfRecordTypeCreateBitmap* = GDIP_WMF_RECORD_TO_EMFPLUS(0x06FE)
  wmfRecordTypeCreateRegion* = GDIP_WMF_RECORD_TO_EMFPLUS(META_CREATEREGION)
  emfRecordTypeHeader* = emrHEADER
  emfRecordTypePolyBezier* = emrPOLYBEZIER
  emfRecordTypePolygon* = emrPOLYGON
  emfRecordTypePolyline* = emrPOLYLINE
  emfRecordTypePolyBezierTo* = emrPOLYBEZIERTO
  emfRecordTypePolyLineTo* = emrPOLYLINETO
  emfRecordTypePolyPolyline* = emrPOLYPOLYLINE
  emfRecordTypePolyPolygon* = emrPOLYPOLYGON
  emfRecordTypeSetWindowExtEx* = emrSETWINDOWEXTEX
  emfRecordTypeSetWindowOrgEx* = emrSETWINDOWORGEX
  emfRecordTypeSetViewportExtEx* = emrSETVIEWPORTEXTEX
  emfRecordTypeSetViewportOrgEx* = emrSETVIEWPORTORGEX
  emfRecordTypeSetBrushOrgEx* = emrSETBRUSHORGEX
  emfRecordTypeEOF* = emrEOF
  emfRecordTypeSetPixelV* = emrSETPIXELV
  emfRecordTypeSetMapperFlags* = emrSETMAPPERFLAGS
  emfRecordTypeSetMapMode* = emrSETMAPMODE
  emfRecordTypeSetBkMode* = emrSETBKMODE
  emfRecordTypeSetPolyFillMode* = emrSETPOLYFILLMODE
  emfRecordTypeSetROP2* = emrSETROP2
  emfRecordTypeSetStretchBltMode* = emrSETSTRETCHBLTMODE
  emfRecordTypeSetTextAlign* = emrSETTEXTALIGN
  emfRecordTypeSetColorAdjustment* = emrSETCOLORADJUSTMENT
  emfRecordTypeSetTextColor* = emrSETTEXTCOLOR
  emfRecordTypeSetBkColor* = emrSETBKCOLOR
  emfRecordTypeOffsetClipRgn* = emrOFFSETCLIPRGN
  emfRecordTypeMoveToEx* = emrMOVETOEX
  emfRecordTypeSetMetaRgn* = emrSETMETARGN
  emfRecordTypeExcludeClipRect* = emrEXCLUDECLIPRECT
  emfRecordTypeIntersectClipRect* = emrINTERSECTCLIPRECT
  emfRecordTypeScaleViewportExtEx* = emrSCALEVIEWPORTEXTEX
  emfRecordTypeScaleWindowExtEx* = emrSCALEWINDOWEXTEX
  emfRecordTypeSaveDC* = emrSAVEDC
  emfRecordTypeRestoreDC* = emrRESTOREDC
  emfRecordTypeSetWorldTransform* = emrSETWORLDTRANSFORM
  emfRecordTypeModifyWorldTransform* = emrMODIFYWORLDTRANSFORM
  emfRecordTypeSelectObject* = emrSELECTOBJECT
  emfRecordTypeCreatePen* = emrCREATEPEN
  emfRecordTypeCreateBrushIndirect* = emrCREATEBRUSHINDIRECT
  emfRecordTypeDeleteObject* = emrDELETEOBJECT
  emfRecordTypeAngleArc* = emrANGLEARC
  emfRecordTypeEllipse* = emrELLIPSE
  emfRecordTypeRectangle* = emrRECTANGLE
  emfRecordTypeRoundRect* = emrROUNDRECT
  emfRecordTypeArc* = emrARC
  emfRecordTypeChord* = emrCHORD
  emfRecordTypePie* = emrPIE
  emfRecordTypeSelectPalette* = emrSELECTPALETTE
  emfRecordTypeCreatePalette* = emrCREATEPALETTE
  emfRecordTypeSetPaletteEntries* = emrSETPALETTEENTRIES
  emfRecordTypeResizePalette* = emrRESIZEPALETTE
  emfRecordTypeRealizePalette* = emrREALIZEPALETTE
  emfRecordTypeExtFloodFill* = emrEXTFLOODFILL
  emfRecordTypeLineTo* = emrLINETO
  emfRecordTypeArcTo* = emrARCTO
  emfRecordTypePolyDraw* = emrPOLYDRAW
  emfRecordTypeSetArcDirection* = emrSETARCDIRECTION
  emfRecordTypeSetMiterLimit* = emrSETMITERLIMIT
  emfRecordTypeBeginPath* = emrBEGINPATH
  emfRecordTypeEndPath* = emrENDPATH
  emfRecordTypeCloseFigure* = emrCLOSEFIGURE
  emfRecordTypeFillPath* = emrFILLPATH
  emfRecordTypeStrokeAndFillPath* = emrSTROKEANDFILLPATH
  emfRecordTypeStrokePath* = emrSTROKEPATH
  emfRecordTypeFlattenPath* = emrFLATTENPATH
  emfRecordTypeWidenPath* = emrWIDENPATH
  emfRecordTypeSelectClipPath* = emrSELECTCLIPPATH
  emfRecordTypeAbortPath* = emrABORTPATH
  EmfRecordTypeReserved_069* = 69
  emfRecordTypeGdiComment* = emrGDICOMMENT
  emfRecordTypeFillRgn* = emrFILLRGN
  emfRecordTypeFrameRgn* = emrFRAMERGN
  emfRecordTypeInvertRgn* = emrINVERTRGN
  emfRecordTypePaintRgn* = emrPAINTRGN
  emfRecordTypeExtSelectClipRgn* = emrEXTSELECTCLIPRGN
  emfRecordTypeBitBlt* = emrBITBLT
  emfRecordTypeStretchBlt* = emrSTRETCHBLT
  emfRecordTypeMaskBlt* = emrMASKBLT
  emfRecordTypePlgBlt* = emrPLGBLT
  emfRecordTypeSetDIBitsToDevice* = emrSETDIBITSTODEVICE
  emfRecordTypeStretchDIBits* = emrSTRETCHDIBITS
  emfRecordTypeExtCreateFontIndirect* = emrEXTCREATEFONTINDIRECTW
  emfRecordTypeExtTextOutA* = emrEXTTEXTOUTA
  emfRecordTypeExtTextOutW* = emrEXTTEXTOUTW
  emfRecordTypePolyBezier16* = emrPOLYBEZIER16
  emfRecordTypePolygon16* = emrPOLYGON16
  emfRecordTypePolyline16* = emrPOLYLINE16
  emfRecordTypePolyBezierTo16* = emrPOLYBEZIERTO16
  emfRecordTypePolylineTo16* = emrPOLYLINETO16
  emfRecordTypePolyPolyline16* = emrPOLYPOLYLINE16
  emfRecordTypePolyPolygon16* = emrPOLYPOLYGON16
  emfRecordTypePolyDraw16* = emrPOLYDRAW16
  emfRecordTypeCreateMonoBrush* = emrCREATEMONOBRUSH
  emfRecordTypeCreateDIBPatternBrushPt* = emrCREATEDIBPATTERNBRUSHPT
  emfRecordTypeExtCreatePen* = emrEXTCREATEPEN
  emfRecordTypePolyTextOutA* = emrPOLYTEXTOUTA
  emfRecordTypePolyTextOutW* = emrPOLYTEXTOUTW
  emfRecordTypeSetICMMode* = 98
  emfRecordTypeCreateColorSpace* = 99
  emfRecordTypeSetColorSpace* = 100
  emfRecordTypeDeleteColorSpace* = 101
  emfRecordTypeGLSRecord* = 102
  emfRecordTypeGLSBoundedRecord* = 103
  emfRecordTypePixelFormat* = 104
  emfRecordTypeDrawEscape* = 105
  emfRecordTypeExtEscape* = 106
  emfRecordTypeStartDoc* = 107
  emfRecordTypeSmallTextOut* = 108
  emfRecordTypeForceUFIMapping* = 109
  emfRecordTypeNamedEscape* = 110
  emfRecordTypeColorCorrectPalette* = 111
  emfRecordTypeSetICMProfileA* = 112
  emfRecordTypeSetICMProfileW* = 113
  emfRecordTypeAlphaBlend* = 114
  emfRecordTypeSetLayout* = 115
  emfRecordTypeTransparentBlt* = 116
  EmfRecordTypeReserved_117* = 117
  emfRecordTypeGradientFill* = 118
  emfRecordTypeSetLinkedUFIs* = 119
  emfRecordTypeSetTextJustification* = 120
  emfRecordTypeColorMatchToTargetW* = 121
  emfRecordTypeCreateColorSpaceW* = 122
  emfRecordTypeMax* = 122
  emfRecordTypeMin* = 1
  emfPlusRecordTypeInvalid* = GDIP_EMFPLUS_RECORD_BASE
  emfPlusRecordTypeHeader* = GDIP_EMFPLUS_RECORD_BASE+1
  emfPlusRecordTypeEndOfFile* = GDIP_EMFPLUS_RECORD_BASE+2
  emfPlusRecordTypeComment* = GDIP_EMFPLUS_RECORD_BASE+3
  emfPlusRecordTypeGetDC* = GDIP_EMFPLUS_RECORD_BASE+4
  emfPlusRecordTypeMultiFormatStart* = GDIP_EMFPLUS_RECORD_BASE+5
  emfPlusRecordTypeMultiFormatSection* = GDIP_EMFPLUS_RECORD_BASE+6
  emfPlusRecordTypeMultiFormatEnd* = GDIP_EMFPLUS_RECORD_BASE+7
  emfPlusRecordTypeObject* = GDIP_EMFPLUS_RECORD_BASE+8
  emfPlusRecordTypeClear* = GDIP_EMFPLUS_RECORD_BASE+9
  emfPlusRecordTypeFillRects* = GDIP_EMFPLUS_RECORD_BASE+10
  emfPlusRecordTypeDrawRects* = GDIP_EMFPLUS_RECORD_BASE+11
  emfPlusRecordTypeFillPolygon* = GDIP_EMFPLUS_RECORD_BASE+12
  emfPlusRecordTypeDrawLines* = GDIP_EMFPLUS_RECORD_BASE+13
  emfPlusRecordTypeFillEllipse* = GDIP_EMFPLUS_RECORD_BASE+14
  emfPlusRecordTypeDrawEllipse* = GDIP_EMFPLUS_RECORD_BASE+15
  emfPlusRecordTypeFillPie* = GDIP_EMFPLUS_RECORD_BASE+16
  emfPlusRecordTypeDrawPie* = GDIP_EMFPLUS_RECORD_BASE+17
  emfPlusRecordTypeDrawArc* = GDIP_EMFPLUS_RECORD_BASE+18
  emfPlusRecordTypeFillRegion* = GDIP_EMFPLUS_RECORD_BASE+19
  emfPlusRecordTypeFillPath* = GDIP_EMFPLUS_RECORD_BASE+20
  emfPlusRecordTypeDrawPath* = GDIP_EMFPLUS_RECORD_BASE+21
  emfPlusRecordTypeFillClosedCurve* = GDIP_EMFPLUS_RECORD_BASE+22
  emfPlusRecordTypeDrawClosedCurve* = GDIP_EMFPLUS_RECORD_BASE+23
  emfPlusRecordTypeDrawCurve* = GDIP_EMFPLUS_RECORD_BASE+24
  emfPlusRecordTypeDrawBeziers* = GDIP_EMFPLUS_RECORD_BASE+25
  emfPlusRecordTypeDrawImage* = GDIP_EMFPLUS_RECORD_BASE+26
  emfPlusRecordTypeDrawImagePoints* = GDIP_EMFPLUS_RECORD_BASE+27
  emfPlusRecordTypeDrawString* = GDIP_EMFPLUS_RECORD_BASE+28
  emfPlusRecordTypeSetRenderingOrigin* = GDIP_EMFPLUS_RECORD_BASE+29
  emfPlusRecordTypeSetAntiAliasMode* = GDIP_EMFPLUS_RECORD_BASE+30
  emfPlusRecordTypeSetTextRenderingHint* = GDIP_EMFPLUS_RECORD_BASE+31
  emfPlusRecordTypeSetTextContrast* = GDIP_EMFPLUS_RECORD_BASE+32
  emfPlusRecordTypeSetGammaValue* = GDIP_EMFPLUS_RECORD_BASE+33
  emfPlusRecordTypeSetInterpolationMode* = GDIP_EMFPLUS_RECORD_BASE+34
  emfPlusRecordTypeSetPixelOffsetMode* = GDIP_EMFPLUS_RECORD_BASE+35
  emfPlusRecordTypeSetCompositingMode* = GDIP_EMFPLUS_RECORD_BASE+36
  emfPlusRecordTypeSetCompositingQuality* = GDIP_EMFPLUS_RECORD_BASE+37
  emfPlusRecordTypeSave* = GDIP_EMFPLUS_RECORD_BASE+38
  emfPlusRecordTypeRestore* = GDIP_EMFPLUS_RECORD_BASE+39
  emfPlusRecordTypeBeginContainer* = GDIP_EMFPLUS_RECORD_BASE+40
  emfPlusRecordTypeBeginContainerNoParams* = GDIP_EMFPLUS_RECORD_BASE+41
  emfPlusRecordTypeEndContainer* = GDIP_EMFPLUS_RECORD_BASE+42
  emfPlusRecordTypeSetWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+43
  emfPlusRecordTypeResetWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+44
  emfPlusRecordTypeMultiplyWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+45
  emfPlusRecordTypeTranslateWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+46
  emfPlusRecordTypeScaleWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+47
  emfPlusRecordTypeRotateWorldTransform* = GDIP_EMFPLUS_RECORD_BASE+48
  emfPlusRecordTypeSetPageTransform* = GDIP_EMFPLUS_RECORD_BASE+49
  emfPlusRecordTypeResetClip* = GDIP_EMFPLUS_RECORD_BASE+50
  emfPlusRecordTypeSetClipRect* = GDIP_EMFPLUS_RECORD_BASE+51
  emfPlusRecordTypeSetClipPath* = GDIP_EMFPLUS_RECORD_BASE+52
  emfPlusRecordTypeSetClipRegion* = GDIP_EMFPLUS_RECORD_BASE+53
  emfPlusRecordTypeOffsetClip* = GDIP_EMFPLUS_RECORD_BASE+54
  emfPlusRecordTypeDrawDriverString* = GDIP_EMFPLUS_RECORD_BASE+55
  emfPlusRecordTypeStrokeFillPath* = GDIP_EMFPLUS_RECORD_BASE+56
  emfPlusRecordTypeSerializableObject* = GDIP_EMFPLUS_RECORD_BASE+57
  emfPlusRecordTypeSetTSGraphics* = GDIP_EMFPLUS_RECORD_BASE+58
  emfPlusRecordTypeSetTSClip* = GDIP_EMFPLUS_RECORD_BASE+59
  emfPlusRecordTotal* = GDIP_EMFPLUS_RECORD_BASE+60
  emfPlusRecordTypeMax* = emfPlusRecordTotal-1
  emfPlusRecordTypeMin* = emfPlusRecordTypeHeader
  emfToWmfBitsFlagsDefault* = 0
  emfToWmfBitsFlagsEmbedEmf* = 1
  emfToWmfBitsFlagsIncludePlaceable* = 2
  emfToWmfBitsFlagsNoXORClip* = 4
  emfTypeEmfOnly* = 3
  emfTypeEmfPlusOnly* = 4
  emfTypeEmfPlusDual* = 5
  encoderParameterValueTypeByte* = 1
  encoderParameterValueTypeASCII* = 2
  encoderParameterValueTypeShort* = 3
  encoderParameterValueTypeLong* = 4
  encoderParameterValueTypeRational* = 5
  encoderParameterValueTypeLongRange* = 6
  encoderParameterValueTypeUndefined* = 7
  encoderParameterValueTypeRationalRange* = 8
  encoderParameterValueTypePointer* = 9
  encoderValueColorTypeCMYK* = 0
  encoderValueColorTypeYCCK* = 1
  encoderValueCompressionLZW* = 2
  encoderValueCompressionCCITT3* = 3
  encoderValueCompressionCCITT4* = 4
  encoderValueCompressionRle* = 5
  encoderValueCompressionNone* = 6
  encoderValueScanMethodInterlaced* = 7
  encoderValueScanMethodNonInterlaced* = 8
  encoderValueVersionGif87* = 9
  encoderValueVersionGif89* = 10
  encoderValueRenderProgressive* = 11
  encoderValueRenderNonProgressive* = 12
  encoderValueTransformRotate90* = 13
  encoderValueTransformRotate180* = 14
  encoderValueTransformRotate270* = 15
  encoderValueTransformFlipHorizontal* = 16
  encoderValueTransformFlipVertical* = 17
  encoderValueMultiFrame* = 18
  encoderValueLastFrame* = 19
  encoderValueFlush* = 20
  encoderValueFrameDimensionTime* = 21
  encoderValueFrameDimensionResolution* = 22
  encoderValueFrameDimensionPage* = 23
  fillModeAlternate* = 0
  fillModeWinding* = 1
  flushIntentionFlush* = 0
  flushIntentionSync* = 1
  fontStyleRegular* = 0
  fontStyleBold* = 1
  fontStyleItalic* = 2
  fontStyleBoldItalic* = 3
  fontStyleUnderline* = 4
  fontStyleStrikeout* = 8
  hatchStyleHorizontal* = 0
  hatchStyleVertical* = 1
  hatchStyleForwardDiagonal* = 2
  hatchStyleBackwardDiagonal* = 3
  hatchStyleCross* = 4
  hatchStyleLargeGrid* = 4
  hatchStyleDiagonalCross* = 5
  hatchStyle05Percent* = 6
  hatchStyle10Percent* = 7
  hatchStyle20Percent* = 8
  hatchStyle25Percent* = 9
  hatchStyle30Percent* = 10
  hatchStyle40Percent* = 11
  hatchStyle50Percent* = 12
  hatchStyle60Percent* = 13
  hatchStyle70Percent* = 14
  hatchStyle75Percent* = 15
  hatchStyle80Percent* = 16
  hatchStyle90Percent* = 17
  hatchStyleLightDownwardDiagonal* = 18
  hatchStyleLightUpwardDiagonal* = 19
  hatchStyleDarkDownwardDiagonal* = 20
  hatchStyleDarkUpwardDiagonal* = 21
  hatchStyleWideDownwardDiagonal* = 22
  hatchStyleWideUpwardDiagonal* = 23
  hatchStyleLightVertical* = 24
  hatchStyleLightHorizontal* = 25
  hatchStyleNarrowVertical* = 26
  hatchStyleNarrowHorizontal* = 27
  hatchStyleDarkVertical* = 28
  hatchStyleDarkHorizontal* = 29
  hatchStyleDashedDownwardDiagonal* = 30
  hatchStyleDashedUpwardDiagonal* = 31
  hatchStyleDashedHorizontal* = 32
  hatchStyleDashedVertical* = 33
  hatchStyleSmallConfetti* = 34
  hatchStyleLargeConfetti* = 35
  hatchStyleZigZag* = 36
  hatchStyleWave* = 37
  hatchStyleDiagonalBrick* = 38
  hatchStyleHorizontalBrick* = 39
  hatchStyleWeave* = 40
  hatchStylePlaid* = 41
  hatchStyleDivot* = 42
  hatchStyleDottedGrid* = 43
  hatchStyleDottedDiamond* = 44
  hatchStyleShingle* = 45
  hatchStyleTrellis* = 46
  hatchStyleSphere* = 47
  hatchStyleSmallGrid* = 48
  hatchStyleSmallCheckerBoard* = 49
  hatchStyleLargeCheckerBoard* = 50
  hatchStyleOutlinedDiamond* = 51
  hatchStyleSolidDiamond* = 52
  hatchStyleTotal* = 53
  hatchStyleMin* = hatchStyleHorizontal
  hatchStyleMax* = hatchStyleTotal-1
  hotkeyPrefixNone* = 0
  hotkeyPrefixShow* = 1
  hotkeyPrefixHide* = 2
  imageTypeUnknown* = 0
  imageTypeBitmap* = 1
  imageTypeMetafile* = 2
  interpolationModeInvalid* = -1
  interpolationModeDefault* = 0
  interpolationModeLowQuality* = 1
  interpolationModeHighQuality* = 2
  interpolationModeBilinear* = 3
  interpolationModeBicubic* = 4
  interpolationModeNearestNeighbor* = 5
  interpolationModeHighQualityBilinear* = 6
  interpolationModeHighQualityBicubic* = 7
  linearGradientModeHorizontal* = 0
  linearGradientModeVertical* = 1
  linearGradientModeForwardDiagonal* = 2
  linearGradientModeBackwardDiagonal* = 3
  lineCapFlat* = 0
  lineCapSquare* = 1
  lineCapRound* = 2
  lineCapTriangle* = 3
  lineCapNoAnchor* = 16
  lineCapSquareAnchor* = 17
  lineCapRoundAnchor* = 18
  lineCapDiamondAnchor* = 19
  lineCapArrowAnchor* = 20
  lineCapCustom* = 255
  lineJoinMiter* = 0
  lineJoinBevel* = 1
  lineJoinRound* = 2
  lineJoinMiterClipped* = 3
  matrixOrderPrepend* = 0
  matrixOrderAppend* = 1
  metafileFrameUnitPixel* = 2
  metafileFrameUnitPoint* = 3
  metafileFrameUnitInch* = 4
  metafileFrameUnitDocument* = 5
  metafileFrameUnitMillimeter* = 6
  metafileFrameUnitGdi* = 7
  metafileTypeInvalid* = 0
  metafileTypeWmf* = 1
  metafileTypeWmfPlaceable* = 2
  metafileTypeEmf* = 3
  metafileTypeEmfPlusOnly* = 4
  metafileTypeEmfPlusDual* = 5
  objectTypeInvalid* = 0
  objectTypeBrush* = 1
  objectTypePen* = 2
  objectTypePath* = 3
  objectTypeRegion* = 4
  objectTypeFont* = 5
  objectTypeStringFormat* = 6
  objectTypeImageAttributes* = 7
  objectTypeCustomLineCap* = 8
  objectTypeGraphics* = 9
  objectTypeMin* = objectTypeBrush
  objectTypeMax* = objectTypeGraphics
  pathPointTypeStart* = 0x00
  pathPointTypeLine* = 0x01
  pathPointTypeBezier* = 0x03
  pathPointTypeBezier3* = 0x03
  pathPointTypePathTypeMask* = 0x07
  pathPointTypePathDashMode* = 0x10
  pathPointTypePathMarker* = 0x20
  pathPointTypeCloseSubpath* = 0x80
  penAlignmentCenter* = 0
  penAlignmentInset* = 1
  penTypeUnknown* = -1
  penTypeSolidColor* = 0
  penTypeHatchFill* = 1
  penTypeTextureFill* = 2
  penTypePathGradient* = 3
  penTypeLinearGradient* = 4
  pixelOffsetModeInvalid* = -1
  pixelOffsetModeDefault* = 0
  pixelOffsetModeHighSpeed* = 1
  pixelOffsetModeHighQuality* = 2
  pixelOffsetModeNone* = 3
  pixelOffsetModeHalf* = 4
  qualityModeInvalid* = -1
  qualityModeDefault* = 0
  qualityModeLow* = 1
  qualityModeHigh* = 2
  smoothingModeInvalid* = qualityModeInvalid
  smoothingModeDefault* = 0
  smoothingModeHighSpeed* = 1
  smoothingModeHighQuality* = 2
  smoothingModeNone* = 3
  smoothingModeAntiAlias8x4* = 4
  smoothingModeAntiAlias* = 4
  smoothingModeAntiAlias8x8* = 5
  stringAlignmentNear* = 0
  stringAlignmentCenter* = 1
  stringAlignmentFar* = 2
  stringDigitSubstituteUser* = 0
  stringDigitSubstituteNone* = 1
  stringDigitSubstituteNational* = 2
  stringDigitSubstituteTraditional* = 3
  stringFormatFlagsDirectionRightToLeft* = 0x00000001
  stringFormatFlagsDirectionVertical* = 0x00000002
  stringFormatFlagsNoFitBlackBox* = 0x00000004
  stringFormatFlagsDisplayFormatControl* = 0x00000020
  stringFormatFlagsNoFontFallback* = 0x00000400
  stringFormatFlagsMeasureTrailingSpaces* = 0x00000800
  stringFormatFlagsNoWrap* = 0x00001000
  stringFormatFlagsLineLimit* = 0x00002000
  stringFormatFlagsNoClip* = 0x00004000
  stringTrimmingNone* = 0
  stringTrimmingCharacter* = 1
  stringTrimmingWord* = 2
  stringTrimmingEllipsisCharacter* = 3
  stringTrimmingEllipsisWord* = 4
  stringTrimmingEllipsisPath* = 5
  textRenderingHintSystemDefault* = 0
  textRenderingHintSingleBitPerPixelGridFit* = 1
  textRenderingHintSingleBitPerPixel* = 2
  textRenderingHintAntiAliasGridFit* = 3
  textRenderingHintAntiAlias* = 4
  textRenderingHintClearTypeGridFit* = 5
  unitWorld* = 0
  unitDisplay* = 1
  unitPixel* = 2
  unitPoint* = 3
  unitInch* = 4
  unitDocument* = 5
  unitMillimeter* = 6
  warpModePerspective* = 0
  warpModeBilinear* = 1
  wrapModeTile* = 0
  wrapModeTileFlipX* = 1
  wrapModeTileFlipY* = 2
  wrapModeTileFlipXY* = 3
  wrapModeClamp* = 4
  testControlForceBilinear* = 0
  testControlForceNoICM* = 1
  testControlGetBuildNumber* = 2
  flatnessDefault* = (REAL) 0.25f
  Ok* = 0
  genericError* = 1
  invalidParameter* = 2
  outOfMemory* = 3
  objectBusy* = 4
  insufficientBuffer* = 5
  notImplemented* = 6
  win32Error* = 7
  wrongState* = 8
  aborted* = 9
  fileNotFound* = 10
  valueOverflow* = 11
  accessDenied* = 12
  unknownImageFormat* = 13
  fontFamilyNotFound* = 14
  fontStyleNotFound* = 15
  notTrueTypeFont* = 16
  unsupportedGdiplusVersion* = 17
  gdiplusNotInitialized* = 18
  propertyNotFound* = 19
  propertyNotSupported* = 20
  profileNotFound* = 21
  imageCodecFlagsEncoder* = 0x00000001
  imageCodecFlagsDecoder* = 0x00000002
  imageCodecFlagsSupportBitmap* = 0x00000004
  imageCodecFlagsSupportVector* = 0x00000008
  imageCodecFlagsSeekableEncode* = 0x00000010
  imageCodecFlagsBlockingDecode* = 0x00000020
  imageCodecFlagsBuiltin* = 0x00010000
  imageCodecFlagsSystem* = 0x00020000
  imageCodecFlagsUser* = 0x00040000
  imageFlagsNone* = 0
  imageFlagsScalable* = 0x00000001
  imageFlagsHasAlpha* = 0x00000002
  imageFlagsHasTranslucent* = 0x00000004
  imageFlagsPartiallyScalable* = 0x00000008
  imageFlagsColorSpaceRGB* = 0x00000010
  imageFlagsColorSpaceCMYK* = 0x00000020
  imageFlagsColorSpaceGRAY* = 0x00000040
  imageFlagsColorSpaceYCBCR* = 0x00000080
  imageFlagsColorSpaceYCCK* = 0x00000100
  imageFlagsHasRealDPI* = 0x00001000
  imageFlagsHasRealPixelSize* = 0x00002000
  imageFlagsReadOnly* = 0x00010000
  imageFlagsCaching* = 0x00020000
  imageLockModeRead* = 1
  imageLockModeWrite* = 2
  imageLockModeUserInputBuf* = 4
  itemDataPositionAfterHeader* = 0
  itemDataPositionAfterPalette* = 1
  itemDataPositionAfterBits* = 2
  rotateNoneFlipNone* = 0
  rotate90FlipNone* = 1
  rotate180FlipNone* = 2
  rotate270FlipNone* = 3
  rotateNoneFlipX* = 4
  rotate90FlipX* = 5
  rotate180FlipX* = 6
  rotate270FlipX* = 7
  rotate180FlipXY* = 0
  rotate270FlipXY* = 1
  rotateNoneFlipXY* = 2
  rotate90FlipXY* = 3
  rotate180FlipY* = 4
  rotate270FlipY* = 5
  rotateNoneFlipY* = 6
  rotate90FlipY* = 7
  propertyTagGpsVer* = PROPID 0x0000
  propertyTagGpsLatitudeRef* = PROPID 0x0001
  propertyTagGpsLatitude* = PROPID 0x0002
  propertyTagGpsLongitudeRef* = PROPID 0x0003
  propertyTagGpsLongitude* = PROPID 0x0004
  propertyTagGpsAltitudeRef* = PROPID 0x0005
  propertyTagGpsAltitude* = PROPID 0x0006
  propertyTagGpsGpsTime* = PROPID 0x0007
  propertyTagGpsGpsSatellites* = PROPID 0x0008
  propertyTagGpsGpsStatus* = PROPID 0x0009
  propertyTagGpsGpsMeasureMode* = PROPID 0x000A
  propertyTagGpsGpsDop* = PROPID 0x000B
  propertyTagGpsSpeedRef* = PROPID 0x000C
  propertyTagGpsSpeed* = PROPID 0x000D
  propertyTagGpsTrackRef* = PROPID 0x000E
  propertyTagGpsTrack* = PROPID 0x000F
  propertyTagGpsImgDirRef* = PROPID 0x0010
  propertyTagGpsImgDir* = PROPID 0x0011
  propertyTagGpsMapDatum* = PROPID 0x0012
  propertyTagGpsDestLatRef* = PROPID 0x0013
  propertyTagGpsDestLat* = PROPID 0x0014
  propertyTagGpsDestLongRef* = PROPID 0x0015
  propertyTagGpsDestLong* = PROPID 0x0016
  propertyTagGpsDestBearRef* = PROPID 0x0017
  propertyTagGpsDestBear* = PROPID 0x0018
  propertyTagGpsDestDistRef* = PROPID 0x0019
  propertyTagGpsDestDist* = PROPID 0x001A
  propertyTagNewSubfileType* = PROPID 0x00FE
  propertyTagSubfileType* = PROPID 0x00FF
  propertyTagImageWidth* = PROPID 0x0100
  propertyTagImageHeight* = PROPID 0x0101
  propertyTagBitsPerSample* = PROPID 0x0102
  propertyTagCompression* = PROPID 0x0103
  propertyTagPhotometricInterp* = PROPID 0x0106
  propertyTagThreshHolding* = PROPID 0x0107
  propertyTagCellWidth* = PROPID 0x0108
  propertyTagCellHeight* = PROPID 0x0109
  propertyTagFillOrder* = PROPID 0x010A
  propertyTagDocumentName* = PROPID 0x010D
  propertyTagImageDescription* = PROPID 0x010E
  propertyTagEquipMake* = PROPID 0x010F
  propertyTagEquipModel* = PROPID 0x0110
  propertyTagStripOffsets* = PROPID 0x0111
  propertyTagOrientation* = PROPID 0x0112
  propertyTagSamplesPerPixel* = PROPID 0x0115
  propertyTagRowsPerStrip* = PROPID 0x0116
  propertyTagStripBytesCount* = PROPID 0x0117
  propertyTagMinSampleValue* = PROPID 0x0118
  propertyTagMaxSampleValue* = PROPID 0x0119
  propertyTagXResolution* = PROPID 0x011A
  propertyTagYResolution* = PROPID 0x011B
  propertyTagPlanarConfig* = PROPID 0x011C
  propertyTagPageName* = PROPID 0x011D
  propertyTagXPosition* = PROPID 0x011E
  propertyTagYPosition* = PROPID 0x011F
  propertyTagFreeOffset* = PROPID 0x0120
  propertyTagFreeByteCounts* = PROPID 0x0121
  propertyTagGrayResponseUnit* = PROPID 0x0122
  propertyTagGrayResponseCurve* = PROPID 0x0123
  propertyTagT4Option* = PROPID 0x0124
  propertyTagT6Option* = PROPID 0x0125
  propertyTagResolutionUnit* = PROPID 0x0128
  propertyTagPageNumber* = PROPID 0x0129
  propertyTagTransferFunction* = PROPID 0x012D
  propertyTagSoftwareUsed* = PROPID 0x0131
  propertyTagDateTime* = PROPID 0x0132
  propertyTagArtist* = PROPID 0x013B
  propertyTagHostComputer* = PROPID 0x013C
  propertyTagPredictor* = PROPID 0x013D
  propertyTagWhitePoint* = PROPID 0x013E
  propertyTagPrimaryChromaticities* = PROPID 0x013F
  propertyTagColorMap* = PROPID 0x0140
  propertyTagHalftoneHints* = PROPID 0x0141
  propertyTagTileWidth* = PROPID 0x0142
  propertyTagTileLength* = PROPID 0x0143
  propertyTagTileOffset* = PROPID 0x0144
  propertyTagTileByteCounts* = PROPID 0x0145
  propertyTagInkSet* = PROPID 0x014C
  propertyTagInkNames* = PROPID 0x014D
  propertyTagNumberOfInks* = PROPID 0x014E
  propertyTagDotRange* = PROPID 0x0150
  propertyTagTargetPrinter* = PROPID 0x0151
  propertyTagExtraSamples* = PROPID 0x0152
  propertyTagSampleFormat* = PROPID 0x0153
  propertyTagSMinSampleValue* = PROPID 0x0154
  propertyTagSMaxSampleValue* = PROPID 0x0155
  propertyTagTransferRange* = PROPID 0x0156
  propertyTagJPEGProc* = PROPID 0x0200
  propertyTagJPEGInterFormat* = PROPID 0x0201
  propertyTagJPEGInterLength* = PROPID 0x0202
  propertyTagJPEGRestartInterval* = PROPID 0x0203
  propertyTagJPEGLosslessPredictors* = PROPID 0x0205
  propertyTagJPEGPointTransforms* = PROPID 0x0206
  propertyTagJPEGQTables* = PROPID 0x0207
  propertyTagJPEGDCTables* = PROPID 0x0208
  propertyTagJPEGACTables* = PROPID 0x0209
  propertyTagYCbCrCoefficients* = PROPID 0x0211
  propertyTagYCbCrSubsampling* = PROPID 0x0212
  propertyTagYCbCrPositioning* = PROPID 0x0213
  propertyTagREFBlackWhite* = PROPID 0x0214
  propertyTagGamma* = PROPID 0x0301
  propertyTagICCProfileDescriptor* = PROPID 0x0302
  propertyTagSRGBRenderingIntent* = PROPID 0x0303
  propertyTagImageTitle* = PROPID 0x0320
  propertyTagResolutionXUnit* = PROPID 0x5001
  propertyTagResolutionYUnit* = PROPID 0x5002
  propertyTagResolutionXLengthUnit* = PROPID 0x5003
  propertyTagResolutionYLengthUnit* = PROPID 0x5004
  propertyTagPrintFlags* = PROPID 0x5005
  propertyTagPrintFlagsVersion* = PROPID 0x5006
  propertyTagPrintFlagsCrop* = PROPID 0x5007
  propertyTagPrintFlagsBleedWidth* = PROPID 0x5008
  propertyTagPrintFlagsBleedWidthScale* = PROPID 0x5009
  propertyTagHalftoneLPI* = PROPID 0x500A
  propertyTagHalftoneLPIUnit* = PROPID 0x500B
  propertyTagHalftoneDegree* = PROPID 0x500C
  propertyTagHalftoneShape* = PROPID 0x500D
  propertyTagHalftoneMisc* = PROPID 0x500E
  propertyTagHalftoneScreen* = PROPID 0x500F
  propertyTagJPEGQuality* = PROPID 0x5010
  propertyTagGridSize* = PROPID 0x5011
  propertyTagThumbnailFormat* = PROPID 0x5012
  propertyTagThumbnailWidth* = PROPID 0x5013
  propertyTagThumbnailHeight* = PROPID 0x5014
  propertyTagThumbnailColorDepth* = PROPID 0x5015
  propertyTagThumbnailPlanes* = PROPID 0x5016
  propertyTagThumbnailRawBytes* = PROPID 0x5017
  propertyTagThumbnailSize* = PROPID 0x5018
  propertyTagThumbnailCompressedSize* = PROPID 0x5019
  propertyTagColorTransferFunction* = PROPID 0x501A
  propertyTagThumbnailData* = PROPID 0x501B
  propertyTagThumbnailImageWidth* = PROPID 0x5020
  propertyTagThumbnailImageHeight* = PROPID 0x5021
  propertyTagThumbnailBitsPerSample* = PROPID 0x5022
  propertyTagThumbnailCompression* = PROPID 0x5023
  propertyTagThumbnailPhotometricInterp* = PROPID 0x5024
  propertyTagThumbnailImageDescription* = PROPID 0x5025
  propertyTagThumbnailEquipMake* = PROPID 0x5026
  propertyTagThumbnailEquipModel* = PROPID 0x5027
  propertyTagThumbnailStripOffsets* = PROPID 0x5028
  propertyTagThumbnailOrientation* = PROPID 0x5029
  propertyTagThumbnailSamplesPerPixel* = PROPID 0x502A
  propertyTagThumbnailRowsPerStrip* = PROPID 0x502B
  propertyTagThumbnailStripBytesCount* = PROPID 0x502C
  propertyTagThumbnailResolutionX* = PROPID 0x502D
  propertyTagThumbnailResolutionY* = PROPID 0x502E
  propertyTagThumbnailPlanarConfig* = PROPID 0x502F
  propertyTagThumbnailResolutionUnit* = PROPID 0x5030
  propertyTagThumbnailTransferFunction* = PROPID 0x5031
  propertyTagThumbnailSoftwareUsed* = PROPID 0x5032
  propertyTagThumbnailDateTime* = PROPID 0x5033
  propertyTagThumbnailArtist* = PROPID 0x5034
  propertyTagThumbnailWhitePoint* = PROPID 0x5035
  propertyTagThumbnailPrimaryChromaticities* = PROPID 0x5036
  propertyTagThumbnailYCbCrCoefficients* = PROPID 0x5037
  propertyTagThumbnailYCbCrSubsampling* = PROPID 0x5038
  propertyTagThumbnailYCbCrPositioning* = PROPID 0x5039
  propertyTagThumbnailRefBlackWhite* = PROPID 0x503A
  propertyTagThumbnailCopyRight* = PROPID 0x503B
  propertyTagLuminanceTable* = PROPID 0x5090
  propertyTagChrominanceTable* = PROPID 0x5091
  propertyTagFrameDelay* = PROPID 0x5100
  propertyTagLoopCount* = PROPID 0x5101
  propertyTagGlobalPalette* = PROPID 0x5102
  propertyTagIndexBackground* = PROPID 0x5103
  propertyTagIndexTransparent* = PROPID 0x5104
  propertyTagPixelUnit* = PROPID 0x5110
  propertyTagPixelPerUnitX* = PROPID 0x5111
  propertyTagPixelPerUnitY* = PROPID 0x5112
  propertyTagPaletteHistogram* = PROPID 0x5113
  propertyTagCopyright* = PROPID 0x8298
  propertyTagExifExposureTime* = PROPID 0x829A
  propertyTagExifFNumber* = PROPID 0x829D
  propertyTagExifIFD* = PROPID 0x8769
  propertyTagICCProfile* = PROPID 0x8773
  propertyTagExifExposureProg* = PROPID 0x8822
  propertyTagExifSpectralSense* = PROPID 0x8824
  propertyTagGpsIFD* = PROPID 0x8825
  propertyTagExifISOSpeed* = PROPID 0x8827
  propertyTagExifOECF* = PROPID 0x8828
  propertyTagExifVer* = PROPID 0x9000
  propertyTagExifDTOrig* = PROPID 0x9003
  propertyTagExifDTDigitized* = PROPID 0x9004
  propertyTagExifCompConfig* = PROPID 0x9101
  propertyTagExifCompBPP* = PROPID 0x9102
  propertyTagExifShutterSpeed* = PROPID 0x9201
  propertyTagExifAperture* = PROPID 0x9202
  propertyTagExifBrightness* = PROPID 0x9203
  propertyTagExifExposureBias* = PROPID 0x9204
  propertyTagExifMaxAperture* = PROPID 0x9205
  propertyTagExifSubjectDist* = PROPID 0x9206
  propertyTagExifMeteringMode* = PROPID 0x9207
  propertyTagExifLightSource* = PROPID 0x9208
  propertyTagExifFlash* = PROPID 0x9209
  propertyTagExifFocalLength* = PROPID 0x920A
  propertyTagExifMakerNote* = PROPID 0x927C
  propertyTagExifUserComment* = PROPID 0x9286
  propertyTagExifDTSubsec* = PROPID 0x9290
  propertyTagExifDTOrigSS* = PROPID 0x9291
  propertyTagExifDTDigSS* = PROPID 0x9292
  propertyTagExifFPXVer* = PROPID 0xA000
  propertyTagExifColorSpace* = PROPID 0xA001
  propertyTagExifPixXDim* = PROPID 0xA002
  propertyTagExifPixYDim* = PROPID 0xA003
  propertyTagExifRelatedWav* = PROPID 0xA004
  propertyTagExifInterop* = PROPID 0xA005
  propertyTagExifFlashEnergy* = PROPID 0xA20B
  propertyTagExifSpatialFR* = PROPID 0xA20C
  propertyTagExifFocalXRes* = PROPID 0xA20E
  propertyTagExifFocalYRes* = PROPID 0xA20F
  propertyTagExifFocalResUnit* = PROPID 0xA210
  propertyTagExifSubjectLoc* = PROPID 0xA214
  propertyTagExifExposureIndex* = PROPID 0xA215
  propertyTagExifSensingMethod* = PROPID 0xA217
  propertyTagExifFileSource* = PROPID 0xA300
  propertyTagExifSceneType* = PROPID 0xA301
  propertyTagExifCfaPattern* = PROPID 0xA302
  propertyTagTypeByte* = WORD 1
  propertyTagTypeASCII* = WORD 2
  propertyTagTypeShort* = WORD 3
  propertyTagTypeLong* = WORD 4
  propertyTagTypeRational* = WORD 5
  propertyTagTypeUndefined* = WORD 7
  propertyTagTypeSLONG* = WORD 9
  propertyTagTypeSRational* = WORD 10
  GDIP_EMFPLUSFLAGS_DISPLAY* = UINT 1
  pixelFormatIndexed* = INT 0x00010000
  pixelFormatGDI* = INT 0x00020000
  pixelFormatAlpha* = INT 0x00040000
  pixelFormatPAlpha* = INT 0x00080000
  pixelFormatExtended* = INT 0x00100000
  pixelFormatCanonical* = INT 0x00200000
  pixelFormatUndefined* = INT 0
  pixelFormatDontCare* = INT 0
  pixelFormat1bppIndexed* = INT(1 or (1 shl 8) or pixelFormatIndexed or pixelFormatGDI)
  pixelFormat4bppIndexed* = INT(2 or (4 shl 8) or pixelFormatIndexed or pixelFormatGDI)
  pixelFormat8bppIndexed* = INT(3 or (8 shl 8) or pixelFormatIndexed or pixelFormatGDI)
  pixelFormat16bppGrayScale* = INT(4 or (16 shl 8) or pixelFormatExtended)
  pixelFormat16bppRGB555* = INT(5 or (16 shl 8) or pixelFormatGDI)
  pixelFormat16bppRGB565* = INT(6 or (16 shl 8) or pixelFormatGDI)
  pixelFormat16bppARGB1555* = INT(7 or (16 shl 8) or pixelFormatAlpha or pixelFormatGDI)
  pixelFormat24bppRGB* = INT(8 or (24 shl 8) or pixelFormatGDI)
  pixelFormat32bppRGB* = INT(9 or (32 shl 8) or pixelFormatGDI)
  pixelFormat32bppARGB* = INT(10 or (32 shl 8) or pixelFormatAlpha or pixelFormatGDI or pixelFormatCanonical)
  pixelFormat32bppPARGB* = INT(11 or (32 shl 8) or pixelFormatAlpha or pixelFormatPAlpha or pixelFormatGDI)
  pixelFormat48bppRGB* = INT(12 or (48 shl 8) or pixelFormatExtended)
  pixelFormat64bppARGB* = INT(13 or (64 shl 8) or pixelFormatAlpha or pixelFormatCanonical or pixelFormatExtended)
  pixelFormat64bppPARGB* = INT(14 or (64 shl 8) or pixelFormatAlpha or pixelFormatPAlpha or pixelFormatExtended)
  pixelFormatMax* = INT 15
  paletteFlagsHasAlpha* = 1
  paletteFlagsGrayScale* = 2
  paletteFlagsHalftone* = 4
  paletteTypeCustom* = 0
  paletteTypeOptimal* = 1
  paletteTypeFixedBW* = 2
  paletteTypeFixedHalftone8* = 3
  paletteTypeFixedHalftone27* = 4
  paletteTypeFixedHalftone64* = 5
  paletteTypeFixedHalftone125* = 6
  paletteTypeFixedHalftone216* = 7
  paletteTypeFixedHalftone252* = 8
  paletteTypeFixedHalftone256* = 9
  colorChannelFlagsC* = 0
  colorChannelFlagsM* = 1
  colorChannelFlagsY* = 2
  colorChannelFlagsK* = 3
  colorChannelFlagsLast* = 4
  colorAdjustTypeDefault* = 0
  colorAdjustTypeBitmap* = 1
  colorAdjustTypeBrush* = 2
  colorAdjustTypePen* = 3
  colorAdjustTypeText* = 4
  colorAdjustTypeCount* = 5
  colorAdjustTypeAny* = 6
  colorMatrixFlagsDefault* = 0
  colorMatrixFlagsSkipGrays* = 1
  colorMatrixFlagsAltGray* = 2
  histogramFormatARGB* = 0
  histogramFormatPARGB* = 1
  histogramFormatRGB* = 2
  histogramFormatGray* = 3
  histogramFormatB* = 4
  histogramFormatG* = 5
  histogramFormatR* = 6
  histogramFormatA* = 7
  adjustExposure* = 0
  adjustDensity* = 1
  adjustContrast* = 2
  adjustHighlight* = 3
  adjustShadow* = 4
  adjustMidtone* = 5
  adjustWhiteSaturation* = 6
  adjustBlackSaturation* = 7
  curveChannelAll* = 0
  curveChannelRed* = 1
  curveChannelGreen* = 2
  curveChannelBlue* = 3
  EncoderChrominanceTable* = DEFINE_GUID(0xF2E455DC'i32, 0x09B3, 0x4316, [0x82'u8,0x60,0x67,0x6A,0xDA,0x32,0x48,0x1C])
  EncoderColorDepth* = DEFINE_GUID(0x66087055'i32, 0xAD66, 0x4C7C, [0x9A'u8,0x18,0x38,0xA2,0x31,0x0B,0x83,0x37])
  EncoderCompression* = DEFINE_GUID(0xE09D739D'i32, 0xCCD4, 0x44EE, [0x8E'u8,0xBA,0x3F,0xBF,0x8B,0xE4,0xFC,0x58])
  EncoderLuminanceTable* = DEFINE_GUID(0xEDB33BCE'i32, 0x0266, 0x4A77, [0xB9'u8,0x04,0x27,0x21,0x60,0x99,0xE7,0x17])
  EncoderQuality* = DEFINE_GUID(0x1D5BE4B5'i32, 0xFA4A, 0x452D, [0x9C'u8,0xDD,0x5D,0xB3,0x51,0x05,0xE7,0xEB])
  EncoderRenderMethod* = DEFINE_GUID(0x6D42C53A'i32, 0x229A, 0x4825, [0x8B'u8,0xB7,0x5C,0x99,0xE2,0xB9,0xA8,0xB8])
  EncoderSaveFlag* = DEFINE_GUID(0x292266FC'i32, 0xAC40, 0x47BF, [0x8C'u8,0xFC,0xA8,0x5B,0x89,0xA6,0x55,0xDE])
  EncoderScanMethod* = DEFINE_GUID(0x3A4E2661'i32, 0x3109, 0x4E56, [0x85'u8,0x36,0x42,0xC1,0x56,0xE7,0xDC,0xFA])
  EncoderTransformation* = DEFINE_GUID(0x8D0EB2D1'i32, 0xA58E, 0x4EA8, [0xAA'u8,0x14,0x10,0x80,0x74,0xB7,0xB6,0xF9])
  EncoderVersion* = DEFINE_GUID(0x24D18C76'i32, 0x814A, 0x41A4, [0xBF'u8,0x53,0x1C,0x21,0x9C,0xCC,0xF7,0x97])
  ImageFormatBMP* = DEFINE_GUID(0xB96B3CAB'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatEMF* = DEFINE_GUID(0xB96B3CAC'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatGIF* = DEFINE_GUID(0xB96B3CB0'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatIcon* = DEFINE_GUID(0xB96B3CB5'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatJPEG* = DEFINE_GUID(0xB96B3CAE'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatMemoryBMP* = DEFINE_GUID(0xB96B3CAA'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatPNG* = DEFINE_GUID(0xB96B3CAF'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatTIFF* = DEFINE_GUID(0xB96B3CB1'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  ImageFormatWMF* = DEFINE_GUID(0xB96B3CAD'i32, 0x0728, 0x11D3, [0x9D'u8,0x7B,0x00,0x00,0xF8,0x1E,0xF3,0x2E])
  FrameDimensionPage* = DEFINE_GUID(0x7462DC86'i32, 0x6180, 0x4C7E, [0x8E'u8,0x3F,0xEE,0x73,0x33,0xA7,0xA4,0x83])
  FrameDimensionTime* = DEFINE_GUID(0x6AEDBD6D'i32, 0x3FB5, 0x418A, [0x83'u8,0xA6,0x7F,0x45,0x22,0x9D,0xC8,0x72])
  BlurEffectGuid* = DEFINE_GUID(0x633C80A4'i32, 0x1843, 0x482B, [0x9E'u8,0xF2,0xBE,0x28,0x34,0xC5,0xFD,0xD4])
  BrightnessContrastEffectGuid* = DEFINE_GUID(0xD3A1DBE1'i32, 0x8EC4, 0x4C17, [0x9F'u8,0x4C,0xEA,0x97,0xAD,0x1C,0x34,0x3D])
  ColorBalanceEffectGuid* = DEFINE_GUID(0x537E597D'i32, 0x251E, 0x48DA, [0x96'u8,0x64,0x29,0xCA,0x49,0x6B,0x70,0xF8])
  ColorCurveEffectGuid* = DEFINE_GUID(0xDD6A0022'i32, 0x58E4, 0x4A67, [0x9D'u8,0x9B,0xD4,0x8E,0xB8,0x81,0xA5,0x3D])
  ColorLookupTableEffectGuid* = DEFINE_GUID(0xA7CE72A9'i32, 0x0F7F, 0x40D7, [0xB3'u8,0xCC,0xD0,0xC0,0x2D,0x5C,0x32,0x12])
  ColorMatrixEffectGuid* = DEFINE_GUID(0x718F2615'i32, 0x7933, 0x40E3, [0xA5'u8,0x11,0x5F,0x68,0xFE,0x14,0xDD,0x74])
  HueSaturationLightnessEffectGuid* = DEFINE_GUID(0x8B2DD6C3'i32, 0xEB07, 0x4D87, [0xA5'u8,0xF0,0x71,0x08,0xE2,0x6A,0x9C,0x5F])
  LevelsEffectGuid* = DEFINE_GUID(0x99C354EC'i32, 0x2A31, 0x4F3A, [0x8C'u8,0x34,0x17,0xA8,0x03,0xB3,0x3A,0x25])
  RedEyeCorrectionEffectGuid* = DEFINE_GUID(0x74D29D05'i32, 0x69A4, 0x4266, [0x95'u8,0x49,0x3C,0xC5,0x28,0x36,0xB6,0x32])
  SharpenEffectGuid* = DEFINE_GUID(0x63CBF3EE'i32, 0xC526, 0x402C, [0x8F'u8,0x71,0x62,0xC5,0x40,0xBF,0x51,0x42])
  TintEffectGuid* = DEFINE_GUID(0x1077AF00'i32, 0x2848, 0x4441, [0x94'u8,0x89,0x44,0xAD,0x4C,0x2D,0x7A,0x2C])
type
  EnumerateMetafileProc* = proc (P1: EmfPlusRecordType, P2: UINT, P3: UINT, P4: ptr BYTE, P5: pointer): BOOL {.stdcall.}
  NotificationHookProc* = proc (token: ptr ULONG_PTR): GpStatus {.stdcall.}
  NotificationUnhookProc* = proc (token: ULONG_PTR): VOID {.stdcall.}
  GpSize* {.pure.} = object
    Width*: INT
    Height*: INT
  GpSizeF* {.pure.} = object
    Width*: REAL
    Height*: REAL
  GpPoint* {.pure.} = object
    X*: INT
    Y*: INT
  GpPointF* {.pure.} = object
    X*: REAL
    Y*: REAL
  GpRect* {.pure.} = object
    X*: INT
    Y*: INT
    Width*: INT
    Height*: INT
  GpRectF* {.pure.} = object
    X*: REAL
    Y*: REAL
    Width*: REAL
    Height*: REAL
  GdiplusAbort* {.pure.} = object
  CharacterRange* {.pure.} = object
    First*: INT
    Length*: INT
  PathData* {.pure.} = object
    Count*: INT
    Points*: ptr GpPointF
    Types*: ptr BYTE
  BitmapData* {.pure.} = object
    Width*: UINT
    Height*: UINT
    Stride*: INT
    PixelFormat*: INT
    Scan0*: pointer
    Reserved*: UINT_PTR
  EncoderParameter* {.pure.} = object
    Guid*: GUID
    NumberOfValues*: ULONG
    Type*: ULONG
    Value*: pointer
  EncoderParameters* {.pure.} = object
    Count*: UINT
    Parameter*: array[1, EncoderParameter]
  ImageCodecInfo* {.pure.} = object
    Clsid*: CLSID
    FormatID*: GUID
    CodecName*: ptr WCHAR
    DllName*: ptr WCHAR
    FormatDescription*: ptr WCHAR
    FilenameExtension*: ptr WCHAR
    MimeType*: ptr WCHAR
    Flags*: DWORD
    Version*: DWORD
    SigCount*: DWORD
    SigSize*: DWORD
    SigPattern*: ptr BYTE
    SigMask*: ptr BYTE
  ImageItemData* {.pure.} = object
    Size*: UINT
    Position*: UINT
    Desc*: pointer
    DescSize*: UINT
    Data*: ptr UINT
    DataSize*: UINT
    Cookie*: UINT
  PropertyItem* {.pure.} = object
    id*: PROPID
    length*: ULONG
    `type`*: WORD
    value*: pointer
  GdiplusStartupInput* {.pure.} = object
    GdiplusVersion*: UINT32
    DebugEventCallback*: DebugEventProc
    SuppressBackgroundThread*: BOOL
    SuppressExternalCodecs*: BOOL
  GdiplusStartupOutput* {.pure.} = object
    NotificationHook*: NotificationHookProc
    NotificationUnhook*: NotificationUnhookProc
  PWMFRect16* {.pure.} = object
    Left*: INT16
    Top*: INT16
    Right*: INT16
    Bottom*: INT16
  WmfPlaceableFileHeader* {.pure.} = object
    Key*: UINT32
    Hmf*: INT16
    BoundingBox*: PWMFRect16
    Inch*: INT16
    Reserved*: UINT32
    Checksum*: INT16
  MetafileHeader_UNION1* {.pure, union.} = object
    WmfHeader*: METAHEADER
    EmfHeader*: ENHMETAHEADER3
  MetafileHeader* {.pure.} = object
    Type*: MetafileType
    Size*: UINT
    Version*: UINT
    EmfPlusFlags*: UINT
    DpiX*: REAL
    DpiY*: REAL
    X*: INT
    Y*: INT
    Width*: INT
    Height*: INT
    union1*: MetafileHeader_UNION1
    EmfPlusHeaderSize*: INT
    LogicalDpiX*: INT
    LogicalDpiY*: INT
  ColorPalette* {.pure.} = object
    Flags*: UINT
    Count*: UINT
    Entries*: array[1, ARGB]
  Color* {.pure.} = object
    Value*: ARGB
  GpColorMap* {.pure.} = object
    oldColor*: Color
    newColor*: Color
  ColorMatrix* {.pure.} = object
    m*: array[5, array[5, REAL]]
  BlurParams* {.pure.} = object
    radius*: REAL
    expandEdge*: BOOL
  BrightnessContrastParams* {.pure.} = object
    brightnessLevel*: INT
    contrastLevel*: INT
  ColorBalanceParams* {.pure.} = object
    cyanRed*: INT
    magentaGreen*: INT
    yellowBlue*: INT
  ColorCurveParams* {.pure.} = object
    adjustment*: CurveAdjustments
    channel*: CurveChannel
    adjustValue*: INT
  ColorLUTParams* {.pure.} = object
    lutB*: ColorChannelLUT
    lutG*: ColorChannelLUT
    lutR*: ColorChannelLUT
    lutA*: ColorChannelLUT
  HueSaturationLightnessParams* {.pure.} = object
    hueLevel*: INT
    saturationLevel*: INT
    lightnessLevel*: INT
  LevelsParams* {.pure.} = object
    highlight*: INT
    midtone*: INT
    shadow*: INT
  RedEyeCorrectionParams* {.pure.} = object
    numberOfAreas*: UINT
    areas*: ptr RECT
  SharpenParams* {.pure.} = object
    radius*: REAL
    amount*: REAL
  TintParams* {.pure.} = object
    hue*: INT
    amount*: INT
  CGpEffect* {.pure.} = object
  GpAdjustableArrowCap* {.pure.} = object
  GpBitmap* {.pure.} = object
  GpBrush* {.pure.} = object
  GpCachedBitmap* {.pure.} = object
  GpCustomLineCap* {.pure.} = object
  GpFont* {.pure.} = object
  GpFontFamily* {.pure.} = object
  GpFontCollection* {.pure.} = object
  GpGraphics* {.pure.} = object
  GpHatch* {.pure.} = object
  GpImage* {.pure.} = object
  GpImageAttributes* {.pure.} = object
  GpLineGradient* {.pure.} = object
  GpMatrix* {.pure.} = object
  GpMetafile* {.pure.} = object
  GpPath* {.pure.} = object
  GpPathData* {.pure.} = object
  GpPathGradient* {.pure.} = object
  GpPathIterator* {.pure.} = object
  GpPen* {.pure.} = object
  GpRegion* {.pure.} = object
  GpSolidFill* {.pure.} = object
  GpStringFormat* {.pure.} = object
  GpTexture* {.pure.} = object
proc GdiplusStartup*(token: ptr ULONG_PTR, input: ptr GdiplusStartupInput, output: ptr GdiplusStartupOutput): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdiplusShutdown*(token: ULONG_PTR): VOID {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdiplusNotificationHook*(token: ptr ULONG_PTR): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdiplusNotificationUnhook*(token: ULONG_PTR): VOID {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFree*(`ptr`: pointer): VOID {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateAdjustableArrowCap*(height: REAL, width: REAL, isFilled: BOOL, cap: ptr ptr GpAdjustableArrowCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetAdjustableArrowCapHeight*(cap: ptr GpAdjustableArrowCap, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetAdjustableArrowCapHeight*(cap: ptr GpAdjustableArrowCap, height: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetAdjustableArrowCapWidth*(cap: ptr GpAdjustableArrowCap, width: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetAdjustableArrowCapWidth*(cap: ptr GpAdjustableArrowCap, width: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetAdjustableArrowCapMiddleInset*(cap: ptr GpAdjustableArrowCap, middleInset: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetAdjustableArrowCapMiddleInset*(cap: ptr GpAdjustableArrowCap, middleInset: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetAdjustableArrowCapFillState*(cap: ptr GpAdjustableArrowCap, fillState: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetAdjustableArrowCapFillState*(cap: ptr GpAdjustableArrowCap, fillState: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromStream*(stream: ptr IStream, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromFile*(filename: ptr WCHAR, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromStreamICM*(stream: ptr IStream, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromFileICM*(filename: ptr WCHAR, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromScan0*(width: INT, height: INT, stride: INT, format: PixelFormat, scan0: ptr BYTE, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromGraphics*(width: INT, height: INT, target: ptr GpGraphics, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromGdiDib*(gdiBitmapInfo: ptr BITMAPINFO, gdiBitmapData: pointer, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromHBITMAP*(hbm: HBITMAP, hpal: HPALETTE, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateHBITMAPFromBitmap*(bitmap: ptr GpBitmap, hbmReturn: ptr HBITMAP, background: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromHICON*(hicon: HICON, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateHICONFromBitmap*(bitmap: ptr GpBitmap, hbmReturn: ptr HICON): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateBitmapFromResource*(hInstance: HINSTANCE, lpBitmapName: ptr WCHAR, bitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneBitmapArea*(x: REAL, y: REAL, width: REAL, height: REAL, format: PixelFormat, srcBitmap: ptr GpBitmap, dstBitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneBitmapAreaI*(x: INT, y: INT, width: INT, height: INT, format: PixelFormat, srcBitmap: ptr GpBitmap, dstBitmap: ptr ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapLockBits*(bitmap: ptr GpBitmap, rect: ptr GpRect, flags: UINT, format: PixelFormat, lockedBitmapData: ptr BitmapData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapUnlockBits*(bitmap: ptr GpBitmap, lockedBitmapData: ptr BitmapData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapGetPixel*(bitmap: ptr GpBitmap, x: INT, y: INT, color: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapSetPixel*(bitmap: ptr GpBitmap, x: INT, y: INT, color: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapSetResolution*(bitmap: ptr GpBitmap, xdpi: REAL, ydpi: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapConvertFormat*(pInputBitmap: ptr GpBitmap, format: PixelFormat, dithertype: DitherType, palettetype: PaletteType, palette: ptr ColorPalette, alphaThresholdPercent: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipInitializePalette*(palette: ptr ColorPalette, palettetype: PaletteType, optimalColors: INT, useTransparentColor: BOOL, bitmap: ptr GpBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapApplyEffect*(bitmap: ptr GpBitmap, effect: ptr CGpEffect, roi: ptr RECT, useAuxData: BOOL, auxData: ptr pointer, auxDataSize: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapCreateApplyEffect*(inputBitmaps: ptr ptr GpBitmap, numInputs: INT, effect: ptr CGpEffect, roi: ptr RECT, outputRect: ptr RECT, outputBitmap: ptr ptr GpBitmap, useAuxData: BOOL, auxData: ptr pointer, auxDataSize: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapGetHistogram*(bitmap: ptr GpBitmap, format: HistogramFormat, NumberOfEntries: UINT, channel0: ptr UINT, channel1: ptr UINT, channel2: ptr UINT, channel3: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBitmapGetHistogramSize*(format: HistogramFormat, NumberOfEntries: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneBrush*(brush: ptr GpBrush, cloneBrush: ptr ptr GpBrush): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteBrush*(brush: ptr GpBrush): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetBrushType*(brush: ptr GpBrush, Type: ptr GpBrushType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateCachedBitmap*(bitmap: ptr GpBitmap, graphics: ptr GpGraphics, cachedBitmap: ptr ptr GpCachedBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteCachedBitmap*(cachedBitmap: ptr GpCachedBitmap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCachedBitmap*(graphics: ptr GpGraphics, cachedBitmap: ptr GpCachedBitmap, x: INT, y: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateCustomLineCap*(fillPath: ptr GpPath, strokePath: ptr GpPath, baseCap: GpLineCap, baseInset: REAL, customCap: ptr ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteCustomLineCap*(customCap: ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneCustomLineCap*(customCap: ptr GpCustomLineCap, clonedCap: ptr ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapType*(customCap: ptr GpCustomLineCap, capType: ptr CustomLineCapType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCustomLineCapStrokeCaps*(customCap: ptr GpCustomLineCap, startCap: GpLineCap, endCap: GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapStrokeCaps*(customCap: ptr GpCustomLineCap, startCap: ptr GpLineCap, endCap: ptr GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCustomLineCapStrokeJoin*(customCap: ptr GpCustomLineCap, lineJoin: GpLineJoin): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapStrokeJoin*(customCap: ptr GpCustomLineCap, lineJoin: ptr GpLineJoin): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCustomLineCapBaseCap*(customCap: ptr GpCustomLineCap, baseCap: GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapBaseCap*(customCap: ptr GpCustomLineCap, baseCap: ptr GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCustomLineCapBaseInset*(customCap: ptr GpCustomLineCap, inset: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapBaseInset*(customCap: ptr GpCustomLineCap, inset: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCustomLineCapWidthScale*(customCap: ptr GpCustomLineCap, widthScale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCustomLineCapWidthScale*(customCap: ptr GpCustomLineCap, widthScale: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateEffect*(guid: GUID, effect: ptr ptr CGpEffect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteEffect*(effect: ptr CGpEffect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetEffectParameterSize*(effect: ptr CGpEffect, size: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetEffectParameters*(effect: ptr CGpEffect, params: pointer, size: UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetEffectParameters*(effect: ptr CGpEffect, size: ptr UINT, params: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFontFromDC*(hdc: HDC, font: ptr ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFontFromLogfontA*(hdc: HDC, logfont: ptr LOGFONTA, font: ptr ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFontFromLogfontW*(hdc: HDC, logfont: ptr LOGFONTW, font: ptr ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFont*(fontFamily: ptr GpFontFamily, emSize: REAL, style: INT, unit: GpUnit, font: ptr ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneFont*(font: ptr GpFont, cloneFont: ptr ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteFont*(font: ptr GpFont): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFamily*(font: ptr GpFont, family: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontStyle*(font: ptr GpFont, style: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontSize*(font: ptr GpFont, size: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontUnit*(font: ptr GpFont, unit: ptr GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontHeight*(font: ptr GpFont, graphics: ptr GpGraphics, height: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontHeightGivenDPI*(font: ptr GpFont, dpi: REAL, height: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLogFontA*(font: ptr GpFont, graphics: ptr GpGraphics, logfontA: ptr LOGFONTA): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLogFontW*(font: ptr GpFont, graphics: ptr GpGraphics, logfontW: ptr LOGFONTW): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipNewInstalledFontCollection*(fontCollection: ptr ptr GpFontCollection): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipNewPrivateFontCollection*(fontCollection: ptr ptr GpFontCollection): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeletePrivateFontCollection*(fontCollection: ptr ptr GpFontCollection): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontCollectionFamilyCount*(fontCollection: ptr GpFontCollection, numFound: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFontCollectionFamilyList*(fontCollection: ptr GpFontCollection, numSought: INT, gpfamilies: ptr ptr GpFontFamily, numFound: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPrivateAddFontFile*(fontCollection: ptr GpFontCollection, filename: ptr WCHAR): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPrivateAddMemoryFont*(fontCollection: ptr GpFontCollection, memory: pointer, length: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFontFamilyFromName*(name: ptr WCHAR, fontCollection: ptr GpFontCollection, FontFamily: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteFontFamily*(fontFamily: ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneFontFamily*(FontFamily: ptr GpFontFamily, clonedFontFamily: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetGenericFontFamilySansSerif*(nativeFamily: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetGenericFontFamilySerif*(nativeFamily: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetGenericFontFamilyMonospace*(nativeFamily: ptr ptr GpFontFamily): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetFamilyName*(family: ptr GpFontFamily, name: ptr WCHAR, language: LANGID): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsStyleAvailable*(family: ptr GpFontFamily, style: INT, IsStyleAvailable: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetEmHeight*(family: ptr GpFontFamily, style: INT, EmHeight: ptr UINT16): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCellAscent*(family: ptr GpFontFamily, style: INT, CellAscent: ptr UINT16): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCellDescent*(family: ptr GpFontFamily, style: INT, CellDescent: ptr UINT16): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineSpacing*(family: ptr GpFontFamily, style: INT, LineSpacing: ptr UINT16): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFlush*(graphics: ptr GpGraphics, intention: GpFlushIntention): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFromHDC*(hdc: HDC, graphics: ptr ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFromHDC2*(hdc: HDC, hDevice: HANDLE, graphics: ptr ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFromHWND*(hwnd: HWND, graphics: ptr ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateFromHWNDICM*(hwnd: HWND, graphics: ptr ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteGraphics*(graphics: ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetDC*(graphics: ptr GpGraphics, hdc: ptr HDC): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipReleaseDC*(graphics: ptr GpGraphics, hdc: HDC): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCompositingMode*(graphics: ptr GpGraphics, compositingMode: CompositingMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCompositingMode*(graphics: ptr GpGraphics, compositingMode: ptr CompositingMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetRenderingOrigin*(graphics: ptr GpGraphics, x: INT, y: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRenderingOrigin*(graphics: ptr GpGraphics, x: ptr INT, y: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetCompositingQuality*(graphics: ptr GpGraphics, compositingQuality: CompositingQuality): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetCompositingQuality*(graphics: ptr GpGraphics, compositingQuality: ptr CompositingQuality): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetSmoothingMode*(graphics: ptr GpGraphics, smoothingMode: SmoothingMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetSmoothingMode*(graphics: ptr GpGraphics, smoothingMode: ptr SmoothingMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPixelOffsetMode*(graphics: ptr GpGraphics, pixelOffsetMode: PixelOffsetMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPixelOffsetMode*(graphics: ptr GpGraphics, pixelOffsetMode: ptr PixelOffsetMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetTextRenderingHint*(graphics: ptr GpGraphics, mode: TextRenderingHint): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetTextRenderingHint*(graphics: ptr GpGraphics, mode: ptr TextRenderingHint): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetTextContrast*(graphics: ptr GpGraphics, contrast: UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetTextContrast*(graphics: ptr GpGraphics, contrast: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetInterpolationMode*(graphics: ptr GpGraphics, interpolationMode: InterpolationMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGraphicsSetAbort*(pGraphics: ptr GpGraphics, pIAbort: ptr GdiplusAbort): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetInterpolationMode*(graphics: ptr GpGraphics, interpolationMode: ptr InterpolationMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetWorldTransform*(graphics: ptr GpGraphics, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetWorldTransform*(graphics: ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyWorldTransform*(graphics: ptr GpGraphics, matrix: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateWorldTransform*(graphics: ptr GpGraphics, dx: REAL, dy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScaleWorldTransform*(graphics: ptr GpGraphics, sx: REAL, sy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotateWorldTransform*(graphics: ptr GpGraphics, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetWorldTransform*(graphics: ptr GpGraphics, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetPageTransform*(graphics: ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPageUnit*(graphics: ptr GpGraphics, unit: ptr GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPageScale*(graphics: ptr GpGraphics, scale: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPageUnit*(graphics: ptr GpGraphics, unit: GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPageScale*(graphics: ptr GpGraphics, scale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetDpiX*(graphics: ptr GpGraphics, dpi: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetDpiY*(graphics: ptr GpGraphics, dpi: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformPoints*(graphics: ptr GpGraphics, destSpace: GpCoordinateSpace, srcSpace: GpCoordinateSpace, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformPointsI*(graphics: ptr GpGraphics, destSpace: GpCoordinateSpace, srcSpace: GpCoordinateSpace, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetNearestColor*(graphics: ptr GpGraphics, argb: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateHalftonePalette*(): HPALETTE {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawLine*(graphics: ptr GpGraphics, pen: ptr GpPen, x1: REAL, y1: REAL, x2: REAL, y2: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawLineI*(graphics: ptr GpGraphics, pen: ptr GpPen, x1: INT, y1: INT, x2: INT, y2: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawLines*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawLinesI*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawArc*(graphics: ptr GpGraphics, pen: ptr GpPen, x: REAL, y: REAL, width: REAL, height: REAL, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawArcI*(graphics: ptr GpGraphics, pen: ptr GpPen, x: INT, y: INT, width: INT, height: INT, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawBezier*(graphics: ptr GpGraphics, pen: ptr GpPen, x1: REAL, y1: REAL, x2: REAL, y2: REAL, x3: REAL, y3: REAL, x4: REAL, y4: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawBezierI*(graphics: ptr GpGraphics, pen: ptr GpPen, x1: INT, y1: INT, x2: INT, y2: INT, x3: INT, y3: INT, x4: INT, y4: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawBeziers*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawBeziersI*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawRectangle*(graphics: ptr GpGraphics, pen: ptr GpPen, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawRectangleI*(graphics: ptr GpGraphics, pen: ptr GpPen, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawRectangles*(graphics: ptr GpGraphics, pen: ptr GpPen, rects: ptr GpRectF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawRectanglesI*(graphics: ptr GpGraphics, pen: ptr GpPen, rects: ptr GpRect, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawEllipse*(graphics: ptr GpGraphics, pen: ptr GpPen, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawEllipseI*(graphics: ptr GpGraphics, pen: ptr GpPen, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawPie*(graphics: ptr GpGraphics, pen: ptr GpPen, x: REAL, y: REAL, width: REAL, height: REAL, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawPieI*(graphics: ptr GpGraphics, pen: ptr GpPen, x: INT, y: INT, width: INT, height: INT, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawPolygon*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawPolygonI*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawPath*(graphics: ptr GpGraphics, pen: ptr GpPen, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurve*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurveI*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurve2*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurve2I*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurve3*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT, offset: INT, numberOfSegments: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawCurve3I*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT, offset: INT, numberOfSegments: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawClosedCurve*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawClosedCurveI*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawClosedCurve2*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPointF, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawClosedCurve2I*(graphics: ptr GpGraphics, pen: ptr GpPen, points: ptr GpPoint, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGraphicsClear*(graphics: ptr GpGraphics, color: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillRectangle*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillRectangleI*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillRectangles*(graphics: ptr GpGraphics, brush: ptr GpBrush, rects: ptr GpRectF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillRectanglesI*(graphics: ptr GpGraphics, brush: ptr GpBrush, rects: ptr GpRect, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPolygon*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPointF, count: INT, fillMode: GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPolygonI*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPoint, count: INT, fillMode: GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPolygon2*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPolygon2I*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillEllipse*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillEllipseI*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPie*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: REAL, y: REAL, width: REAL, height: REAL, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPieI*(graphics: ptr GpGraphics, brush: ptr GpBrush, x: INT, y: INT, width: INT, height: INT, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillPath*(graphics: ptr GpGraphics, brush: ptr GpBrush, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillClosedCurve*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillClosedCurveI*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillClosedCurve2*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPointF, count: INT, tension: REAL, fillMode: GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillClosedCurve2I*(graphics: ptr GpGraphics, brush: ptr GpBrush, points: ptr GpPoint, count: INT, tension: REAL, fillMode: GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFillRegion*(graphics: ptr GpGraphics, brush: ptr GpBrush, region: ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImage*(graphics: ptr GpGraphics, image: ptr GpImage, x: REAL, y: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageI*(graphics: ptr GpGraphics, image: ptr GpImage, x: INT, y: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageRect*(graphics: ptr GpGraphics, image: ptr GpImage, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageRectI*(graphics: ptr GpGraphics, image: ptr GpImage, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePoints*(graphics: ptr GpGraphics, image: ptr GpImage, dstpoints: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePointsI*(graphics: ptr GpGraphics, image: ptr GpImage, dstpoints: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePointRect*(graphics: ptr GpGraphics, image: ptr GpImage, x: REAL, y: REAL, srcx: REAL, srcy: REAL, srcwidth: REAL, srcheight: REAL, srcUnit: GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePointRectI*(graphics: ptr GpGraphics, image: ptr GpImage, x: INT, y: INT, srcx: INT, srcy: INT, srcwidth: INT, srcheight: INT, srcUnit: GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageRectRect*(graphics: ptr GpGraphics, image: ptr GpImage, dstx: REAL, dsty: REAL, dstwidth: REAL, dstheight: REAL, srcx: REAL, srcy: REAL, srcwidth: REAL, srcheight: REAL, srcUnit: GpUnit, imageAttributes: ptr GpImageAttributes, callback: DrawImageAbort, callbackData: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageRectRectI*(graphics: ptr GpGraphics, image: ptr GpImage, dstx: INT, dsty: INT, dstwidth: INT, dstheight: INT, srcx: INT, srcy: INT, srcwidth: INT, srcheight: INT, srcUnit: GpUnit, imageAttributes: ptr GpImageAttributes, callback: DrawImageAbort, callbackData: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePointsRect*(graphics: ptr GpGraphics, image: ptr GpImage, points: ptr GpPointF, count: INT, srcx: REAL, srcy: REAL, srcwidth: REAL, srcheight: REAL, srcUnit: GpUnit, imageAttributes: ptr GpImageAttributes, callback: DrawImageAbort, callbackData: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImagePointsRectI*(graphics: ptr GpGraphics, image: ptr GpImage, points: ptr GpPoint, count: INT, srcx: INT, srcy: INT, srcwidth: INT, srcheight: INT, srcUnit: GpUnit, imageAttributes: ptr GpImageAttributes, callback: DrawImageAbort, callbackData: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawImageFX*(graphics: ptr GpGraphics, image: ptr GpImage, source: ptr GpRectF, xForm: ptr GpMatrix, effect: ptr CGpEffect, imageAttributes: ptr GpImageAttributes, srcUnit: GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipEnumerateMetafileDestPoints*(graphics: ptr GpGraphics, metafile: ptr GpMetafile, destPoints: ptr GpPointF, count: INT, callback: EnumerateMetafileProc, callbackData: pointer, imageAttributes: ptr GpImageAttributes): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipEnumerateMetafileDestPointsI*(graphics: ptr GpGraphics, metafile: ptr GpMetafile, destGpPoints: ptr GpPoint, count: INT, callback: EnumerateMetafileProc, callbackData: pointer, imageAttributes: ptr GpImageAttributes): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipGraphics*(graphics: ptr GpGraphics, srcgraphics: ptr GpGraphics, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipRect*(graphics: ptr GpGraphics, x: REAL, y: REAL, width: REAL, height: REAL, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipRectI*(graphics: ptr GpGraphics, x: INT, y: INT, width: INT, height: INT, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipPath*(graphics: ptr GpGraphics, path: ptr GpPath, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipRegion*(graphics: ptr GpGraphics, region: ptr GpRegion, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetClipHrgn*(graphics: ptr GpGraphics, hRgn: HRGN, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetClip*(graphics: ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateClip*(graphics: ptr GpGraphics, dx: REAL, dy: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateClipI*(graphics: ptr GpGraphics, dx: INT, dy: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetClip*(graphics: ptr GpGraphics, region: ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetClipBounds*(graphics: ptr GpGraphics, rect: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetClipBoundsI*(graphics: ptr GpGraphics, rect: ptr GpRect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsClipEmpty*(graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetVisibleClipBounds*(graphics: ptr GpGraphics, rect: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetVisibleClipBoundsI*(graphics: ptr GpGraphics, rect: ptr GpRect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleClipEmpty*(graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisiblePoint*(graphics: ptr GpGraphics, x: REAL, y: REAL, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisiblePointI*(graphics: ptr GpGraphics, x: INT, y: INT, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRect*(graphics: ptr GpGraphics, x: REAL, y: REAL, width: REAL, height: REAL, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRectI*(graphics: ptr GpGraphics, x: INT, y: INT, width: INT, height: INT, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSaveGraphics*(graphics: ptr GpGraphics, state: ptr GraphicsState): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRestoreGraphics*(graphics: ptr GpGraphics, state: GraphicsState): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBeginContainer*(graphics: ptr GpGraphics, dstrect: ptr GpRectF, srcrect: ptr GpRectF, unit: GpUnit, state: ptr GraphicsContainer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBeginContainerI*(graphics: ptr GpGraphics, dstrect: ptr GpRect, srcrect: ptr GpRect, unit: GpUnit, state: ptr GraphicsContainer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipBeginContainer2*(graphics: ptr GpGraphics, state: ptr GraphicsContainer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipEndContainer*(graphics: ptr GpGraphics, state: GraphicsContainer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipComment*(graphics: ptr GpGraphics, sizeData: UINT, data: ptr BYTE): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePath*(brushMode: GpFillMode, path: ptr ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePath2*(points: ptr GpPointF, types: ptr BYTE, count: INT, fillMode: GpFillMode, path: ptr ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePath2I*(points: ptr GpPoint, types: ptr BYTE, count: INT, fillMode: GpFillMode, path: ptr ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipClonePath*(path: ptr GpPath, clonePath: ptr ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeletePath*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetPath*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPointCount*(path: ptr GpPath, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathTypes*(path: ptr GpPath, types: ptr BYTE, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathPoints*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathPointsI*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathFillMode*(path: ptr GpPath, fillmode: ptr GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathFillMode*(path: ptr GpPath, fillmode: GpFillMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathData*(path: ptr GpPath, pathData: ptr GpPathData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipStartPathFigure*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipClosePathFigure*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipClosePathFigures*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathMarker*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipClearPathMarkers*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipReversePath*(path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathLastPoint*(path: ptr GpPath, lastPoint: ptr GpPointF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathLine*(path: ptr GpPath, x1: REAL, y1: REAL, x2: REAL, y2: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathLine2*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathArc*(path: ptr GpPath, x: REAL, y: REAL, width: REAL, height: REAL, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathBezier*(path: ptr GpPath, x1: REAL, y1: REAL, x2: REAL, y2: REAL, x3: REAL, y3: REAL, x4: REAL, y4: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathBeziers*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurve*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurve2*(path: ptr GpPath, points: ptr GpPointF, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurve3*(path: ptr GpPath, points: ptr GpPointF, count: INT, offset: INT, numberOfSegments: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathClosedCurve*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathClosedCurve2*(path: ptr GpPath, points: ptr GpPointF, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathRectangle*(path: ptr GpPath, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathRectangles*(path: ptr GpPath, rects: ptr GpRectF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathEllipse*(path: ptr GpPath, x: REAL, y: REAL, width: REAL, height: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathPie*(path: ptr GpPath, x: REAL, y: REAL, width: REAL, height: REAL, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathPolygon*(path: ptr GpPath, points: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathPath*(path: ptr GpPath, addingPath: ptr GpPath, connect: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathString*(path: ptr GpPath, string: ptr WCHAR, length: INT, family: ptr GpFontFamily, style: INT, emSize: REAL, layoutRect: ptr GpRectF, format: ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathStringI*(path: ptr GpPath, string: ptr WCHAR, length: INT, family: ptr GpFontFamily, style: INT, emSize: REAL, layoutGpRect: ptr GpRect, format: ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathLineI*(path: ptr GpPath, x1: INT, y1: INT, x2: INT, y2: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathLine2I*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathArcI*(path: ptr GpPath, x: INT, y: INT, width: INT, height: INT, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathBezierI*(path: ptr GpPath, x1: INT, y1: INT, x2: INT, y2: INT, x3: INT, y3: INT, x4: INT, y4: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathBeziersI*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurveI*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurve2I*(path: ptr GpPath, points: ptr GpPoint, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathCurve3I*(path: ptr GpPath, points: ptr GpPoint, count: INT, offset: INT, numberOfSegments: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathClosedCurveI*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathClosedCurve2I*(path: ptr GpPath, points: ptr GpPoint, count: INT, tension: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathRectangleI*(path: ptr GpPath, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathRectanglesI*(path: ptr GpPath, rects: ptr GpRect, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathEllipseI*(path: ptr GpPath, x: INT, y: INT, width: INT, height: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathPieI*(path: ptr GpPath, x: INT, y: INT, width: INT, height: INT, startAngle: REAL, sweepAngle: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipAddPathPolygonI*(path: ptr GpPath, points: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFlattenPath*(path: ptr GpPath, matrix: ptr GpMatrix, flatness: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipWindingModeOutline*(path: ptr GpPath, matrix: ptr GpMatrix, flatness: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipWidenPath*(nativePath: ptr GpPath, pen: ptr GpPen, matrix: ptr GpMatrix, flatness: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipWarpPath*(path: ptr GpPath, matrix: ptr GpMatrix, points: ptr GpPointF, count: INT, srcx: REAL, srcy: REAL, srcwidth: REAL, srcheight: REAL, warpMode: WarpMode, flatness: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformPath*(path: ptr GpPath, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathWorldBounds*(path: ptr GpPath, bounds: ptr GpRectF, matrix: ptr GpMatrix, pen: ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathWorldBoundsI*(path: ptr GpPath, bounds: ptr GpRect, matrix: ptr GpMatrix, pen: ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisiblePathPoint*(path: ptr GpPath, x: REAL, y: REAL, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisiblePathPointI*(path: ptr GpPath, x: INT, y: INT, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsOutlineVisiblePathPoint*(path: ptr GpPath, x: REAL, y: REAL, pen: ptr GpPen, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsOutlineVisiblePathPointI*(path: ptr GpPath, x: INT, y: INT, pen: ptr GpPen, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateHatchBrush*(hatchstyle: GpHatchStyle, forecol: ARGB, backcol: ARGB, brush: ptr ptr GpHatch): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetHatchStyle*(brush: ptr GpHatch, hatchstyle: ptr GpHatchStyle): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetHatchForegroundColor*(brush: ptr GpHatch, forecol: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetHatchBackgroundColor*(brush: ptr GpHatch, backcol: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipLoadImageFromStream*(stream: ptr IStream, image: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipLoadImageFromFile*(filename: ptr WCHAR, image: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipLoadImageFromStreamICM*(stream: ptr IStream, image: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipLoadImageFromFileICM*(filename: ptr WCHAR, image: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneImage*(image: ptr GpImage, cloneImage: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDisposeImage*(image: ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSaveImageToFile*(image: ptr GpImage, filename: ptr WCHAR, clsidEncoder: ptr CLSID, encoderParams: ptr EncoderParameters): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSaveImageToStream*(image: ptr GpImage, stream: ptr IStream, clsidEncoder: ptr CLSID, encoderParams: ptr EncoderParameters): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSaveAdd*(image: ptr GpImage, encoderParams: ptr EncoderParameters): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSaveAddImage*(image: ptr GpImage, newImage: ptr GpImage, encoderParams: ptr EncoderParameters): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageGraphicsContext*(image: ptr GpImage, graphics: ptr ptr GpGraphics): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageBounds*(image: ptr GpImage, srcRect: ptr GpRectF, srcUnit: ptr GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageDimension*(image: ptr GpImage, width: ptr REAL, height: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageType*(image: ptr GpImage, Type: ptr ImageType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageWidth*(image: ptr GpImage, width: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageHeight*(image: ptr GpImage, height: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageHorizontalResolution*(image: ptr GpImage, resolution: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageVerticalResolution*(image: ptr GpImage, resolution: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageFlags*(image: ptr GpImage, flags: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageRawFormat*(image: ptr GpImage, format: ptr GUID): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImagePixelFormat*(image: ptr GpImage, format: ptr PixelFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageThumbnail*(image: ptr GpImage, thumbWidth: UINT, thumbHeight: UINT, thumbImage: ptr ptr GpImage, callback: GetThumbnailImageAbort, callbackData: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetEncoderParameterListSize*(image: ptr GpImage, clsidEncoder: ptr CLSID, size: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetEncoderParameterList*(image: ptr GpImage, clsidEncoder: ptr CLSID, size: UINT, buffer: ptr EncoderParameters): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageGetFrameDimensionsCount*(image: ptr GpImage, count: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageGetFrameDimensionsList*(image: ptr GpImage, dimensionIDs: ptr GUID, count: UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageGetFrameCount*(image: ptr GpImage, dimensionID: ptr GUID, count: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageSelectActiveFrame*(image: ptr GpImage, dimensionID: ptr GUID, frameIndex: UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageRotateFlip*(image: ptr GpImage, rfType: RotateFlipType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImagePalette*(image: ptr GpImage, palette: ptr ColorPalette, size: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImagePalette*(image: ptr GpImage, palette: ptr ColorPalette): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImagePaletteSize*(image: ptr GpImage, size: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPropertyCount*(image: ptr GpImage, numOfProperty: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPropertyIdList*(image: ptr GpImage, numOfProperty: UINT, list: ptr PROPID): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPropertyItemSize*(image: ptr GpImage, propId: PROPID, size: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPropertyItem*(image: ptr GpImage, propId: PROPID, propSize: UINT, buffer: ptr PropertyItem): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPropertySize*(image: ptr GpImage, totalBufferSize: ptr UINT, numProperties: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetAllPropertyItems*(image: ptr GpImage, totalBufferSize: UINT, numProperties: UINT, allItems: ptr PropertyItem): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRemovePropertyItem*(image: ptr GpImage, propId: PROPID): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPropertyItem*(image: ptr GpImage, item: ptr PropertyItem): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFindFirstImageItem*(image: ptr GpImage, item: ptr ImageItemData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipFindNextImageItem*(image: ptr GpImage, item: ptr ImageItemData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageItemData*(image: ptr GpImage, item: ptr ImageItemData): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageSetAbort*(pImage: ptr GpImage, pIAbort: ptr GdiplusAbort): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipImageForceValidation*(image: ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageDecodersSize*(numDecoders: ptr UINT, size: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageDecoders*(numDecoders: UINT, size: UINT, decoders: ptr ImageCodecInfo): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageEncodersSize*(numEncoders: ptr UINT, size: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageEncoders*(numEncoders: UINT, size: UINT, encoders: ptr ImageCodecInfo): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateImageAttributes*(imageattr: ptr ptr GpImageAttributes): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneImageAttributes*(imageattr: ptr GpImageAttributes, cloneImageattr: ptr ptr GpImageAttributes): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDisposeImageAttributes*(imageattr: ptr GpImageAttributes): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesToIdentity*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetImageAttributes*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesColorMatrix*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, colorMatrix: ptr ColorMatrix, grayMatrix: ptr ColorMatrix, flags: ColorMatrixFlags): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesThreshold*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, threshold: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesGamma*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, gamma: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesNoOp*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesColorKeys*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, colorLow: ARGB, colorHigh: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesOutputChannel*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, channelFlags: ColorChannelFlags): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesOutputChannelColorProfile*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, colorProfileFilename: ptr WCHAR): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesRemapTable*(imageattr: ptr GpImageAttributes, Type: ColorAdjustType, enableFlag: BOOL, mapSize: UINT, map: ptr GpColorMap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesWrapMode*(imageAttr: ptr GpImageAttributes, wrap: GpWrapMode, argb: ARGB, clamp: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetImageAttributesAdjustedPalette*(imageAttr: ptr GpImageAttributes, colorPalette: ptr ColorPalette, colorAdjustType: ColorAdjustType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetImageAttributesCachedBackground*(imageattr: ptr GpImageAttributes, enableFlag: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrush*(point1: ptr GpPointF, point2: ptr GpPointF, color1: ARGB, color2: ARGB, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrushI*(point1: ptr GpPoint, point2: ptr GpPoint, color1: ARGB, color2: ARGB, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrushFromRect*(rect: ptr GpRectF, color1: ARGB, color2: ARGB, mode: LinearGradientMode, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrushFromRectI*(rect: ptr GpRect, color1: ARGB, color2: ARGB, mode: LinearGradientMode, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrushFromRectWithAngle*(rect: ptr GpRectF, color1: ARGB, color2: ARGB, angle: REAL, isAngleScalable: BOOL, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateLineBrushFromRectWithAngleI*(rect: ptr GpRect, color1: ARGB, color2: ARGB, angle: REAL, isAngleScalable: BOOL, wrapMode: GpWrapMode, lineGradient: ptr ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineColors*(brush: ptr GpLineGradient, color1: ARGB, color2: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineColors*(brush: ptr GpLineGradient, colors: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineRect*(brush: ptr GpLineGradient, rect: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineRectI*(brush: ptr GpLineGradient, rect: ptr GpRect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineGammaCorrection*(brush: ptr GpLineGradient, useGammaCorrection: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineGammaCorrection*(brush: ptr GpLineGradient, useGammaCorrection: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineBlendCount*(brush: ptr GpLineGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineBlend*(brush: ptr GpLineGradient, blend: ptr REAL, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineBlend*(brush: ptr GpLineGradient, blend: ptr REAL, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLinePresetBlendCount*(brush: ptr GpLineGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLinePresetBlend*(brush: ptr GpLineGradient, blend: ptr ARGB, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLinePresetBlend*(brush: ptr GpLineGradient, blend: ptr ARGB, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineSigmaBlend*(brush: ptr GpLineGradient, focus: REAL, scale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineLinearBlend*(brush: ptr GpLineGradient, focus: REAL, scale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineWrapMode*(brush: ptr GpLineGradient, wrapmode: GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineWrapMode*(brush: ptr GpLineGradient, wrapmode: ptr GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetLineTransform*(brush: ptr GpLineGradient, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetLineTransform*(brush: ptr GpLineGradient, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetLineTransform*(brush: ptr GpLineGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyLineTransform*(brush: ptr GpLineGradient, matrix: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateLineTransform*(brush: ptr GpLineGradient, dx: REAL, dy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScaleLineTransform*(brush: ptr GpLineGradient, sx: REAL, sy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotateLineTransform*(brush: ptr GpLineGradient, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMatrix*(matrix: ptr ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMatrix2*(m11: REAL, m12: REAL, m21: REAL, m22: REAL, dx: REAL, dy: REAL, matrix: ptr ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMatrix3*(rect: ptr GpRectF, dstplg: ptr GpPointF, matrix: ptr ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMatrix3I*(rect: ptr GpRect, dstplg: ptr GpPoint, matrix: ptr ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneMatrix*(matrix: ptr GpMatrix, cloneMatrix: ptr ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteMatrix*(matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetMatrixElements*(matrix: ptr GpMatrix, m11: REAL, m12: REAL, m21: REAL, m22: REAL, dx: REAL, dy: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyMatrix*(matrix: ptr GpMatrix, matrix2: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateMatrix*(matrix: ptr GpMatrix, offsetX: REAL, offsetY: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScaleMatrix*(matrix: ptr GpMatrix, scaleX: REAL, scaleY: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotateMatrix*(matrix: ptr GpMatrix, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipShearMatrix*(matrix: ptr GpMatrix, shearX: REAL, shearY: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipInvertMatrix*(matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformMatrixPoints*(matrix: ptr GpMatrix, pts: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformMatrixPointsI*(matrix: ptr GpMatrix, pts: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipVectorTransformMatrixPoints*(matrix: ptr GpMatrix, pts: ptr GpPointF, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipVectorTransformMatrixPointsI*(matrix: ptr GpMatrix, pts: ptr GpPoint, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMatrixElements*(matrix: ptr GpMatrix, matrixOut: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsMatrixInvertible*(matrix: ptr GpMatrix, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsMatrixIdentity*(matrix: ptr GpMatrix, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsMatrixEqual*(matrix: ptr GpMatrix, matrix2: ptr GpMatrix, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMetafileHeaderFromEmf*(hEmf: HENHMETAFILE, header: ptr MetafileHeader): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMetafileHeaderFromFile*(filename: ptr WCHAR, header: ptr MetafileHeader): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMetafileHeaderFromStream*(stream: ptr IStream, header: ptr MetafileHeader): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMetafileHeaderFromMetafile*(metafile: ptr GpMetafile, header: ptr MetafileHeader): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetHemfFromMetafile*(metafile: ptr GpMetafile, hEmf: ptr HENHMETAFILE): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateStreamOnFile*(filename: ptr WCHAR, access: UINT, stream: ptr ptr IStream): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMetafileFromWmf*(hWmf: HMETAFILE, deleteWmf: BOOL, wmfPlaceableFileHeader: ptr WmfPlaceableFileHeader, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMetafileFromEmf*(hEmf: HENHMETAFILE, deleteEmf: BOOL, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMetafileFromFile*(file: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMetafileFromWmfFile*(file: ptr WCHAR, wmfPlaceableFileHeader: ptr WmfPlaceableFileHeader, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateMetafileFromStream*(stream: ptr IStream, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafile*(referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRectF, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafileI*(referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRect, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafileFileName*(fileName: ptr WCHAR, referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRectF, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafileFileNameI*(fileName: ptr WCHAR, referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRect, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafileStream*(stream: ptr IStream, referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRectF, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRecordMetafileStreamI*(stream: ptr IStream, referenceHdc: HDC, Type: EmfType, frameRect: ptr GpRect, frameUnit: MetafileFrameUnit, description: ptr WCHAR, metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPlayMetafileRecord*(metafile: ptr GpMetafile, recordType: EmfPlusRecordType, flags: UINT, dataSize: UINT, data: ptr BYTE): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetMetafileDownLevelRasterizationLimit*(metafile: ptr GpMetafile, metafileRasterizationLimitDpi: UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetMetafileDownLevelRasterizationLimit*(metafile: ptr GpMetafile, metafileRasterizationLimitDpi: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipConvertToEmfPlus*(refGraphics: ptr GpGraphics, metafile: ptr GpMetafile, conversionSuccess: ptr BOOL, emfType: EmfType, description: ptr WCHAR, out_metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipConvertToEmfPlusToFile*(refGraphics: ptr GpGraphics, metafile: ptr GpMetafile, conversionSuccess: ptr BOOL, filename: ptr WCHAR, emfType: EmfType, description: ptr WCHAR, out_metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipConvertToEmfPlusToStream*(refGraphics: ptr GpGraphics, metafile: ptr GpMetafile, conversionSuccess: ptr BOOL, stream: ptr IStream, emfType: EmfType, description: ptr WCHAR, out_metafile: ptr ptr GpMetafile): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipEmfToWmfBits*(hemf: HENHMETAFILE, cbData16: UINT, pData16: LPBYTE, iMapMode: INT, eFlags: INT): UINT {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePathGradient*(points: ptr GpPointF, count: INT, wrapMode: GpWrapMode, polyGradient: ptr ptr GpPathGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePathGradientI*(points: ptr GpPoint, count: INT, wrapMode: GpWrapMode, polyGradient: ptr ptr GpPathGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePathGradientFromPath*(path: ptr GpPath, polyGradient: ptr ptr GpPathGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientCenterColor*(brush: ptr GpPathGradient, colors: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientCenterColor*(brush: ptr GpPathGradient, colors: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientSurroundColorsWithCount*(brush: ptr GpPathGradient, color: ptr ARGB, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientSurroundColorsWithCount*(brush: ptr GpPathGradient, color: ptr ARGB, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientPath*(brush: ptr GpPathGradient, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientPath*(brush: ptr GpPathGradient, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientCenterPoint*(brush: ptr GpPathGradient, points: ptr GpPointF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientCenterPointI*(brush: ptr GpPathGradient, points: ptr GpPoint): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientCenterPoint*(brush: ptr GpPathGradient, points: ptr GpPointF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientCenterPointI*(brush: ptr GpPathGradient, points: ptr GpPoint): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientRect*(brush: ptr GpPathGradient, rect: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientRectI*(brush: ptr GpPathGradient, rect: ptr GpRect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientPointCount*(brush: ptr GpPathGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientSurroundColorCount*(brush: ptr GpPathGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientGammaCorrection*(brush: ptr GpPathGradient, useGammaCorrection: BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientGammaCorrection*(brush: ptr GpPathGradient, useGammaCorrection: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientBlendCount*(brush: ptr GpPathGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientBlend*(brush: ptr GpPathGradient, blend: ptr REAL, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientBlend*(brush: ptr GpPathGradient, blend: ptr REAL, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientPresetBlendCount*(brush: ptr GpPathGradient, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientPresetBlend*(brush: ptr GpPathGradient, blend: ptr ARGB, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientPresetBlend*(brush: ptr GpPathGradient, blend: ptr ARGB, positions: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientSigmaBlend*(brush: ptr GpPathGradient, focus: REAL, scale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientLinearBlend*(brush: ptr GpPathGradient, focus: REAL, scale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientWrapMode*(brush: ptr GpPathGradient, wrapmode: ptr GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientWrapMode*(brush: ptr GpPathGradient, wrapmode: GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientTransform*(brush: ptr GpPathGradient, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientTransform*(brush: ptr GpPathGradient, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetPathGradientTransform*(brush: ptr GpPathGradient): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyPathGradientTransform*(brush: ptr GpPathGradient, matrix: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslatePathGradientTransform*(brush: ptr GpPathGradient, dx: REAL, dy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScalePathGradientTransform*(brush: ptr GpPathGradient, sx: REAL, sy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotatePathGradientTransform*(brush: ptr GpPathGradient, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPathGradientFocusScales*(brush: ptr GpPathGradient, xScale: ptr REAL, yScale: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPathGradientFocusScales*(brush: ptr GpPathGradient, xScale: REAL, yScale: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePathIter*(Iterator: ptr ptr GpPathIterator, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeletePathIter*(Iterator: ptr GpPathIterator): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterNextSubpath*(Iterator: ptr GpPathIterator, resultCount: ptr INT, startIndex: ptr INT, endIndex: ptr INT, isClosed: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterNextSubpathPath*(Iterator: ptr GpPathIterator, resultCount: ptr INT, path: ptr GpPath, isClosed: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterNextPathType*(Iterator: ptr GpPathIterator, resultCount: ptr INT, pathType: ptr BYTE, startIndex: ptr INT, endIndex: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterNextMarker*(Iterator: ptr GpPathIterator, resultCount: ptr INT, startIndex: ptr INT, endIndex: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterNextMarkerPath*(Iterator: ptr GpPathIterator, resultCount: ptr INT, path: ptr GpPath): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterGetCount*(Iterator: ptr GpPathIterator, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterGetSubpathCount*(Iterator: ptr GpPathIterator, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterIsValid*(Iterator: ptr GpPathIterator, valid: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterHasCurve*(Iterator: ptr GpPathIterator, hasCurve: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterRewind*(Iterator: ptr GpPathIterator): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterEnumerate*(Iterator: ptr GpPathIterator, resultCount: ptr INT, points: ptr GpPointF, types: ptr BYTE, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipPathIterCopyData*(Iterator: ptr GpPathIterator, resultCount: ptr INT, points: ptr GpPointF, types: ptr BYTE, startIndex: INT, endIndex: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePen1*(color: ARGB, width: REAL, unit: GpUnit, pen: ptr ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreatePen2*(brush: ptr GpBrush, width: REAL, unit: GpUnit, pen: ptr ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipClonePen*(pen: ptr GpPen, clonepen: ptr ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeletePen*(pen: ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenWidth*(pen: ptr GpPen, width: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenWidth*(pen: ptr GpPen, width: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenUnit*(pen: ptr GpPen, unit: GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenUnit*(pen: ptr GpPen, unit: ptr GpUnit): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenLineCap197819*(pen: ptr GpPen, startCap: GpLineCap, endCap: GpLineCap, dashCap: GpDashCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenStartCap*(pen: ptr GpPen, startCap: GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenEndCap*(pen: ptr GpPen, endCap: GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenDashCap197819*(pen: ptr GpPen, dashCap: GpDashCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenStartCap*(pen: ptr GpPen, startCap: ptr GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenEndCap*(pen: ptr GpPen, endCap: ptr GpLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenDashCap197819*(pen: ptr GpPen, dashCap: ptr GpDashCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenLineJoin*(pen: ptr GpPen, lineJoin: GpLineJoin): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenLineJoin*(pen: ptr GpPen, lineJoin: ptr GpLineJoin): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenCustomStartCap*(pen: ptr GpPen, customCap: ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenCustomStartCap*(pen: ptr GpPen, customCap: ptr ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenCustomEndCap*(pen: ptr GpPen, customCap: ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenCustomEndCap*(pen: ptr GpPen, customCap: ptr ptr GpCustomLineCap): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenMiterLimit*(pen: ptr GpPen, miterLimit: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenMiterLimit*(pen: ptr GpPen, miterLimit: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenMode*(pen: ptr GpPen, penMode: GpPenAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenMode*(pen: ptr GpPen, penMode: ptr GpPenAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenTransform*(pen: ptr GpPen, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenTransform*(pen: ptr GpPen, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetPenTransform*(pen: ptr GpPen): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyPenTransform*(pen: ptr GpPen, matrix: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslatePenTransform*(pen: ptr GpPen, dx: REAL, dy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScalePenTransform*(pen: ptr GpPen, sx: REAL, sy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotatePenTransform*(pen: ptr GpPen, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenColor*(pen: ptr GpPen, argb: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenColor*(pen: ptr GpPen, argb: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenBrushFill*(pen: ptr GpPen, brush: ptr GpBrush): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenBrushFill*(pen: ptr GpPen, brush: ptr ptr GpBrush): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenFillType*(pen: ptr GpPen, Type: ptr GpPenType): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenDashStyle*(pen: ptr GpPen, dashstyle: ptr GpDashStyle): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenDashStyle*(pen: ptr GpPen, dashstyle: GpDashStyle): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenDashOffset*(pen: ptr GpPen, offset: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenDashOffset*(pen: ptr GpPen, offset: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenDashCount*(pen: ptr GpPen, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenDashArray*(pen: ptr GpPen, dash: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenDashArray*(pen: ptr GpPen, dash: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenCompoundCount*(pen: ptr GpPen, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetPenCompoundArray*(pen: ptr GpPen, dash: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetPenCompoundArray*(pen: ptr GpPen, dash: ptr REAL, count: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegion*(region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegionRect*(rect: ptr GpRectF, region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegionRectI*(rect: ptr GpRect, region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegionPath*(path: ptr GpPath, region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegionRgnData*(regionData: ptr BYTE, size: INT, region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateRegionHrgn*(hRgn: HRGN, region: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneRegion*(region: ptr GpRegion, cloneRegion: ptr ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteRegion*(region: ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetInfinite*(region: ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetEmpty*(region: ptr GpRegion): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCombineRegionRect*(region: ptr GpRegion, rect: ptr GpRectF, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCombineRegionRectI*(region: ptr GpRegion, rect: ptr GpRect, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCombineRegionPath*(region: ptr GpRegion, path: ptr GpPath, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCombineRegionRegion*(region: ptr GpRegion, region2: ptr GpRegion, combineMode: CombineMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateRegion*(region: ptr GpRegion, dx: REAL, dy: REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateRegionI*(region: ptr GpRegion, dx: INT, dy: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTransformRegion*(region: ptr GpRegion, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionBounds*(region: ptr GpRegion, graphics: ptr GpGraphics, rect: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionBoundsI*(region: ptr GpRegion, graphics: ptr GpGraphics, rect: ptr GpRect): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionHRgn*(region: ptr GpRegion, graphics: ptr GpGraphics, hRgn: ptr HRGN): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsEmptyRegion*(region: ptr GpRegion, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsInfiniteRegion*(region: ptr GpRegion, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsEqualRegion*(region: ptr GpRegion, region2: ptr GpRegion, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionDataSize*(region: ptr GpRegion, bufferSize: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionData*(region: ptr GpRegion, buffer: ptr BYTE, bufferSize: UINT, sizeFilled: ptr UINT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRegionPoint*(region: ptr GpRegion, x: REAL, y: REAL, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRegionPointI*(region: ptr GpRegion, x: INT, y: INT, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRegionRect*(region: ptr GpRegion, x: REAL, y: REAL, width: REAL, height: REAL, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipIsVisibleRegionRectI*(region: ptr GpRegion, x: INT, y: INT, width: INT, height: INT, graphics: ptr GpGraphics, result: ptr BOOL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionScansCount*(region: ptr GpRegion, count: ptr UINT, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionScans*(region: ptr GpRegion, rects: ptr GpRectF, count: ptr INT, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetRegionScansI*(region: ptr GpRegion, rects: ptr GpRect, count: ptr INT, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateSolidFill*(color: ARGB, brush: ptr ptr GpSolidFill): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetSolidFillColor*(brush: ptr GpSolidFill, color: ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetSolidFillColor*(brush: ptr GpSolidFill, color: ptr ARGB): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateStringFormat*(formatAttributes: INT, language: LANGID, format: ptr ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipStringFormatGetGenericDefault*(format: ptr ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipStringFormatGetGenericTypographic*(format: ptr ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDeleteStringFormat*(format: ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCloneStringFormat*(format: ptr GpStringFormat, newFormat: ptr ptr GpStringFormat): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatFlags*(format: ptr GpStringFormat, flags: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatFlags*(format: ptr GpStringFormat, flags: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatAlign*(format: ptr GpStringFormat, align: StringAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatAlign*(format: ptr GpStringFormat, align: ptr StringAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatLineAlign*(format: ptr GpStringFormat, align: StringAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatLineAlign*(format: ptr GpStringFormat, align: ptr StringAlignment): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatTrimming*(format: ptr GpStringFormat, trimming: StringTrimming): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatTrimming*(format: ptr GpStringFormat, trimming: ptr StringTrimming): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatHotkeyPrefix*(format: ptr GpStringFormat, hotkeyPrefix: INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatHotkeyPrefix*(format: ptr GpStringFormat, hotkeyPrefix: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatTabStops*(format: ptr GpStringFormat, firstTabOffset: REAL, count: INT, tabStops: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatTabStops*(format: ptr GpStringFormat, count: INT, firstTabOffset: ptr REAL, tabStops: ptr REAL): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatTabStopCount*(format: ptr GpStringFormat, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatDigitSubstitution*(format: ptr GpStringFormat, language: LANGID, substitute: StringDigitSubstitute): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatDigitSubstitution*(format: ptr GpStringFormat, language: ptr LANGID, substitute: ptr StringDigitSubstitute): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetStringFormatMeasurableCharacterRangeCount*(format: ptr GpStringFormat, count: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetStringFormatMeasurableCharacterRanges*(format: ptr GpStringFormat, rangeCount: INT, ranges: ptr CharacterRange): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawString*(graphics: ptr GpGraphics, string: ptr WCHAR, length: INT, font: ptr GpFont, layoutRect: ptr GpRectF, stringFormat: ptr GpStringFormat, brush: ptr GpBrush): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMeasureString*(graphics: ptr GpGraphics, string: ptr WCHAR, length: INT, font: ptr GpFont, layoutRect: ptr GpRectF, stringFormat: ptr GpStringFormat, boundingBox: ptr GpRectF, codepointsFitted: ptr INT, linesFilled: ptr INT): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipDrawDriverString*(graphics: ptr GpGraphics, text: ptr UINT16, length: INT, font: ptr GpFont, brush: ptr GpBrush, positions: ptr GpPointF, flags: INT, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMeasureDriverString*(graphics: ptr GpGraphics, text: ptr UINT16, length: INT, font: ptr GpFont, positions: ptr GpPointF, flags: INT, matrix: ptr GpMatrix, boundingBox: ptr GpRectF): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateTexture*(image: ptr GpImage, wrapmode: GpWrapMode, texture: ptr ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateTexture2*(image: ptr GpImage, wrapmode: GpWrapMode, x: REAL, y: REAL, width: REAL, height: REAL, texture: ptr ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateTexture2I*(image: ptr GpImage, wrapmode: GpWrapMode, x: INT, y: INT, width: INT, height: INT, texture: ptr ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateTextureIA*(image: ptr GpImage, imageAttributes: ptr GpImageAttributes, x: REAL, y: REAL, width: REAL, height: REAL, texture: ptr ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipCreateTextureIAI*(image: ptr GpImage, imageAttributes: ptr GpImageAttributes, x: INT, y: INT, width: INT, height: INT, texture: ptr ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetTextureTransform*(brush: ptr GpTexture, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetTextureTransform*(brush: ptr GpTexture, matrix: ptr GpMatrix): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipResetTextureTransform*(brush: ptr GpTexture): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipMultiplyTextureTransform*(brush: ptr GpTexture, matrix: ptr GpMatrix, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTranslateTextureTransform*(brush: ptr GpTexture, dx: REAL, dy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipScaleTextureTransform*(brush: ptr GpTexture, sx: REAL, sy: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipRotateTextureTransform*(brush: ptr GpTexture, angle: REAL, order: GpMatrixOrder): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipSetTextureWrapMode*(brush: ptr GpTexture, wrapmode: GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetTextureWrapMode*(brush: ptr GpTexture, wrapmode: ptr GpWrapMode): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipGetTextureImage*(brush: ptr GpTexture, image: ptr ptr GpImage): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc GdipTestControl*(control: GpTestControlEnum, param: pointer): GpStatus {.winapi, stdcall, dynlib: "gdiplus", importc.}
proc `WmfHeader=`*(self: var MetafileHeader, x: METAHEADER) {.inline.} = self.union1.WmfHeader = x
proc WmfHeader*(self: MetafileHeader): METAHEADER {.inline.} = self.union1.WmfHeader
proc WmfHeader*(self: var MetafileHeader): var METAHEADER {.inline.} = self.union1.WmfHeader
proc `EmfHeader=`*(self: var MetafileHeader, x: ENHMETAHEADER3) {.inline.} = self.union1.EmfHeader = x
proc EmfHeader*(self: MetafileHeader): ENHMETAHEADER3 {.inline.} = self.union1.EmfHeader
proc EmfHeader*(self: var MetafileHeader): var ENHMETAHEADER3 {.inline.} = self.union1.EmfHeader
