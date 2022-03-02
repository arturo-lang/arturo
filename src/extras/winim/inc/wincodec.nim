#====================================================================
#
#               Winim - Nim's Windows API Module
#                 (c) Copyright 2016-2021 Ward
#
#====================================================================

import winimbase
import windef
import objbase
#include <wincodec.h>
type
  WICDecodeOptions* = int32
  WICBitmapCreateCacheOption* = int32
  WICBitmapAlphaChannelOption* = int32
  WICBitmapDecoderCapabilities* = int32
  WICBitmapDitherType* = int32
  WICBitmapEncoderCacheOption* = int32
  WICBitmapInterpolationMode* = int32
  WICBitmapLockFlags* = int32
  WICBitmapPaletteType* = int32
  WICBitmapTransformOptions* = int32
  WICColorContextType* = int32
  WICComponentType* = int32
  WICComponentSigning* = int32
  WICComponentEnumerateOptions* = int32
  WICPixelFormatNumericRepresentation* = int32
  WICTiffCompressionOption* = int32
  WICPixelFormatGUID* = GUID
  REFWICPixelFormatGUID* = REFGUID
  WICColor* = UINT32
const
  WINCODEC_SDK_VERSION* = 0x0236
  wICDecodeMetadataCacheOnDemand* = 0x0
  wICDecodeMetadataCacheOnLoad* = 0x1
  WICMETADATACACHEOPTION_FORCE_DWORD* = 0x7fffffff
  wICBitmapNoCache* = 0x0
  wICBitmapCacheOnDemand* = 0x1
  wICBitmapCacheOnLoad* = 0x2
  WICBITMAPCREATECACHEOPTION_FORCE_DWORD* = 0x7fffffff
  wICBitmapUseAlpha* = 0x0
  wICBitmapUsePremultipliedAlpha* = 0x1
  wICBitmapIgnoreAlpha* = 0x2
  WICBITMAPALPHACHANNELOPTIONS_FORCE_DWORD* = 0x7fffffff
  wICBitmapDecoderCapabilitySameEncoder* = 0x1
  wICBitmapDecoderCapabilityCanDecodeAllImages* = 0x2
  wICBitmapDecoderCapabilityCanDecodeSomeImages* = 0x4
  wICBitmapDecoderCapabilityCanEnumerateMetadata* = 0x8
  wICBitmapDecoderCapabilityCanDecodeThumbnail* = 0x10
  wICBitmapDitherTypeNone* = 0x0
  wICBitmapDitherTypeSolid* = 0x0
  wICBitmapDitherTypeOrdered4x4* = 0x1
  wICBitmapDitherTypeOrdered8x8* = 0x2
  wICBitmapDitherTypeOrdered16x16* = 0x3
  wICBitmapDitherTypeSpiral4x4* = 0x4
  wICBitmapDitherTypeSpiral8x8* = 0x5
  wICBitmapDitherTypeDualSpiral4x4* = 0x6
  wICBitmapDitherTypeDualSpiral8x8* = 0x7
  wICBitmapDitherTypeErrorDiffusion* = 0x8
  WICBITMAPDITHERTYPE_FORCE_DWORD* = 0x7fffffff
  wICBitmapEncoderCacheInMemory* = 0x0
  wICBitmapEncoderCacheTempFile* = 0x1
  wICBitmapEncoderNoCache* = 0x2
  WICBITMAPENCODERCACHEOPTION_FORCE_DWORD* = 0x7fffffff
  wICBitmapInterpolationModeNearestNeighbor* = 0x0
  wICBitmapInterpolationModeLinear* = 0x1
  wICBitmapInterpolationModeCubic* = 0x2
  wICBitmapInterpolationModeFant* = 0x3
  WICBITMAPINTERPOLATIONMODE_FORCE_DWORD* = 0x7fffffff
  wICBitmapLockRead* = 0x1
  wICBitmapLockWrite* = 0x2
  WICBITMAPLOCKFLAGS_FORCE_DWORD* = 0x7fffffff
  wICBitmapPaletteTypeCustom* = 0x0
  wICBitmapPaletteTypeMedianCut* = 0x1
  wICBitmapPaletteTypeFixedBW* = 0x2
  wICBitmapPaletteTypeFixedHalftone8* = 0x3
  wICBitmapPaletteTypeFixedHalftone27* = 0x4
  wICBitmapPaletteTypeFixedHalftone64* = 0x5
  wICBitmapPaletteTypeFixedHalftone125* = 0x6
  wICBitmapPaletteTypeFixedHalftone216* = 0x7
  wICBitmapPaletteTypeFixedWebPalette* = wICBitmapPaletteTypeFixedHalftone216
  wICBitmapPaletteTypeFixedHalftone252* = 0x8
  wICBitmapPaletteTypeFixedHalftone256* = 0x9
  wICBitmapPaletteTypeFixedGray4* = 0xa
  wICBitmapPaletteTypeFixedGray16* = 0xb
  wICBitmapPaletteTypeFixedGray256* = 0xc
  WICBITMAPPALETTETYPE_FORCE_DWORD* = 0x7fffffff
  wICBitmapTransformRotate0* = 0x0
  wICBitmapTransformRotate90* = 0x1
  wICBitmapTransformRotate180* = 0x2
  wICBitmapTransformRotate270* = 0x3
  wICBitmapTransformFlipHorizontal* = 0x8
  wICBitmapTransformFlipVertical* = 0x10
  WICBITMAPTRANSFORMOPTIONS_FORCE_DWORD* = 0x7fffffff
  wICColorContextUninitialized* = 0x0
  wICColorContextProfile* = 0x1
  wICColorContextExifColorSpace* = 0x2
  wICDecoder* = 0x1
  wICEncoder* = 0x2
  wICPixelFormatConverter* = 0x4
  wICMetadataReader* = 0x8
  wICMetadataWriter* = 0x10
  wICPixelFormat* = 0x20
  WICCOMPONENTTYPE_FORCE_DWORD* = 0x7fffffff
  wICComponentSigned* = 0x1
  wICComponentUnsigned* = 0x2
  wICComponentSafe* = 0x4
  wICComponentDisabled* = 0x80000000'i32
  wICComponentEnumerateDefault* = 0x0
  wICComponentEnumerateRefresh* = 0x1
  wICComponentEnumerateBuiltInOnly* = 0x20000000
  wICComponentEnumerateUnsigned* = 0x40000000
  wICComponentEnumerateDisabled* = 0x80000000'i32
  wICPixelFormatNumericRepresentationUnspecified* = 0x0
  wICPixelFormatNumericRepresentationIndexed* = 0x1
  wICPixelFormatNumericRepresentationUnsignedInteger* = 0x2
  wICPixelFormatNumericRepresentationSignedInteger* = 0x3
  wICPixelFormatNumericRepresentationFixed* = 0x4
  wICPixelFormatNumericRepresentationFloat* = 0x5
  WICPIXELFORMATNUMERICREPRESENTATION_FORCE_DWORD* = 0x7fffffff
  wICTiffCompressionDontCare* = 0x0
  wICTiffCompressionNone* = 0x1
  wICTiffCompressionCCITT3* = 0x2
  wICTiffCompressionCCITT4* = 0x3
  wICTiffCompressionLZW* = 0x4
  wICTiffCompressionRLE* = 0x5
  wICTiffCompressionZIP* = 0x6
  wICTiffCompressionLZWHDifferencing* = 0x7
  WICTIFFCOMPRESSIONOPTION_FORCE_DWORD* = 0x7fffffff
  GUID_WICPixelFormatDontCare* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc900")
  GUID_WICPixelFormatUndefined* = GUID_WICPixelFormatDontCare
  GUID_WICPixelFormat1bppIndexed* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc901")
  GUID_WICPixelFormat2bppIndexed* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc902")
  GUID_WICPixelFormat4bppIndexed* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc903")
  GUID_WICPixelFormat8bppIndexed* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc904")
  GUID_WICPixelFormatBlackWhite* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc905")
  GUID_WICPixelFormat2bppGray* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc906")
  GUID_WICPixelFormat4bppGray* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc907")
  GUID_WICPixelFormat8bppGray* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc908")
  GUID_WICPixelFormat16bppGray* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90b")
  GUID_WICPixelFormat16bppBGR555* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc909")
  GUID_WICPixelFormat16bppBGR565* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90a")
  GUID_WICPixelFormat16bppBGRA5551* = DEFINE_GUID("05ec7c2b-f1e6-4961-ad46-e1cc810a87d2")
  GUID_WICPixelFormat24bppBGR* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90c")
  GUID_WICPixelFormat24bppRGB* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90d")
  GUID_WICPixelFormat32bppBGR* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90e")
  GUID_WICPixelFormat32bppBGRA* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc90f")
  GUID_WICPixelFormat32bppPBGRA* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc910")
  GUID_WICPixelFormat32bppRGB* = DEFINE_GUID("d98c6b95-3efe-47d6-bb25-eb1748ab0cf1")
  GUID_WICPixelFormat32bppRGBA* = DEFINE_GUID("f5c7ad2d-6a8d-43dd-a7a8-a29935261ae9")
  GUID_WICPixelFormat32bppPRGBA* = DEFINE_GUID("3cc4a650-a527-4d37-a916-3142c7ebedba")
  GUID_WICPixelFormat48bppRGB* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc915")
  GUID_WICPixelFormat64bppRGBA* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc916")
  GUID_WICPixelFormat64bppPRGBA* = DEFINE_GUID("6fddc324-4e03-4bfe-b185-3d77768dc917")
  GUID_WICPixelFormat32bppCMYK* = DEFINE_GUID("6fddc324-4e03-4fbe-b185-3d77768dc91c")
  WINCODEC_ERR_WRONGSTATE* = 0x88982f04'i32
  WINCODEC_ERR_VALUEOUTOFRANGE* = 0x88982f05'i32
  WINCODEC_ERR_NOTINITIALIZED* = 0x88982f0c'i32
  WINCODEC_ERR_ALREADYLOCKED* = 0x88982f0d'i32
  WINCODEC_ERR_PROPERTYNOTFOUND* = 0x88982f40'i32
  WINCODEC_ERR_CODECNOTHUMBNAIL* = 0x88982f44'i32
  WINCODEC_ERR_PALETTEUNAVAILABLE* = 0x88982f45'i32
  WINCODEC_ERR_COMPONENTNOTFOUND* = 0x88982f50'i32
  WINCODEC_ERR_BADIMAGE* = 0x88982f60'i32
  WINCODEC_ERR_FRAMEMISSING* = 0x88982f62'i32
  WINCODEC_ERR_BADMETADATAHEADER* = 0x88982f63'i32
  WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT* = 0x88982f80'i32
  WINCODEC_ERR_UNSUPPORTEDOPERATION* = 0x88982f81'i32
  WINCODEC_ERR_INSUFFICIENTBUFFER* = 0x88982f8c'i32
  WINCODEC_ERR_PROPERTYUNEXPECTEDTYPE* = 0x88982f8e'i32
  WINCODEC_ERR_WIN32ERROR* = 0x88982f94'i32
  IID_IWICColorContext* = DEFINE_GUID("3c613a02-34b2-44ea-9a7c-45aea9c6fd6d")
  IID_IWICBitmapSource* = DEFINE_GUID("00000120-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICBitmapLock* = DEFINE_GUID("00000123-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICBitmapFlipRotator* = DEFINE_GUID("5009834f-2d6a-41ce-9e1b-17c5aff7a782")
  IID_IWICBitmap* = DEFINE_GUID("00000121-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICPalette* = DEFINE_GUID("00000040-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICComponentInfo* = DEFINE_GUID("23bc3f0a-698b-4357-886b-f24d50671334")
  IID_IWICMetadataQueryReader* = DEFINE_GUID("30989668-e1c9-4597-b395-458eedb808df")
  IID_IWICMetadataQueryWriter* = DEFINE_GUID("a721791a-0def-4d06-bd91-2118bf1db10b")
  IID_IWICBitmapFrameDecode* = DEFINE_GUID("3b16811b-6a43-4ec9-a813-3d930c13b940")
  IID_IWICPixelFormatInfo* = DEFINE_GUID("e8eda601-3d48-431a-ab44-69059be88bbe")
  IID_IWICPixelFormatInfo2* = DEFINE_GUID("a9db33a2-af5f-43c7-b679-74f5984b5aa4")
  IID_IWICBitmapCodecInfo* = DEFINE_GUID("e87a44c4-b76e-4c47-8b09-298eb12a2714")
  IID_IWICBitmapDecoderInfo* = DEFINE_GUID("d8cd007f-d08f-4191-9bfc-236ea7f0e4b5")
  IID_IWICBitmapDecoder* = DEFINE_GUID("9edde9e7-8dee-47ea-99df-e6faf2ed44bf")
  IID_IWICBitmapFrameEncode* = DEFINE_GUID("00000105-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICBitmapEncoderInfo* = DEFINE_GUID("94c9b4ee-a09f-4f92-8a1e-4a9bce7e76fb")
  IID_IWICBitmapEncoder* = DEFINE_GUID("00000103-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICFormatConverter* = DEFINE_GUID("00000301-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICFormatConverterInfo* = DEFINE_GUID("9f34fb65-13f4-4f15-bc57-3726b5e53d9f")
  IID_IWICStream* = DEFINE_GUID("135ff860-22b7-4ddf-b0f6-218f4f299a43")
  IID_IWICBitmapScaler* = DEFINE_GUID("00000302-a8f2-4877-ba0a-fd2b6645fb94")
  IID_IWICBitmapClipper* = DEFINE_GUID("e4fbcf03-223d-4e81-9333-d635556dd1b5")
  IID_IWICColorTransform* = DEFINE_GUID("b66f034f-d0e2-40ab-b436-6de39e321a94")
  IID_IWICFastMetadataEncoder* = DEFINE_GUID("b84e2c09-78c9-4ac4-8bd3-524ae1663a2f")
  CLSID_WICImagingFactory* = DEFINE_GUID("cacaf262-9370-4615-a13b-9f5539da4c0a")
  IID_IWICImagingFactory* = DEFINE_GUID("ec5ec8a9-c395-4314-9c77-54d7a935ff70")
  IID_IWICEnumMetadataItem* = DEFINE_GUID("dc2bb46d-3f07-481e-8625-220c4aedbb33")
  CLSID_WICBmpDecoder* = DEFINE_GUID("6b462062-7cbf-400d-9fdb-813dd10f2778")
  CLSID_WICPngDecoder* = DEFINE_GUID("389ea17b-5078-4cde-b6ef-25c15175c751")
  CLSID_WICIcoDecoder* = DEFINE_GUID("c61bfcdf-2e0f-4aad-a8d7-e06bafebcdfe")
  CLSID_WICJpegDecoder* = DEFINE_GUID("9456a480-e88b-43ea-9e73-0b2d9b71b1ca")
  CLSID_WICGifDecoder* = DEFINE_GUID("381dda3c-9ce9-4834-a23e-1f98f8fc52be")
  CLSID_WICTiffDecoder* = DEFINE_GUID("b54e85d9-fe23-499f-8b88-6acea713752b")
  CLSID_WICWmpDecoder* = DEFINE_GUID("a26cec36-234c-4950-ae16-e34aace71d0d")
  CLSID_WICBmpEncoder* = DEFINE_GUID("69be8bb4-d66d-47c8-865a-ed1589433782")
  CLSID_WICPngEncoder* = DEFINE_GUID("27949969-876a-41d7-9447-568f6a35a4dc")
  CLSID_WICJpegEncoder* = DEFINE_GUID("1a34f5c1-4a5a-46dc-b644-1f4567e7a676")
  CLSID_WICGifEncoder* = DEFINE_GUID("114f5598-0b22-40a0-86a1-c83ea495adbd")
  CLSID_WICTiffEncoder* = DEFINE_GUID("0131be10-2001-4c5f-a9b0-cc88fab64ce8")
  CLSID_WICWmpEncoder* = DEFINE_GUID("ac4ce3cb-e1c1-44cd-8215-5a1665509ec2")
  CLSID_WICDefaultFormatConverter* = DEFINE_GUID("1a3f11dc-b514-4b17-8c5f-2154513852f1")
  GUID_ContainerFormatBmp* = DEFINE_GUID("0af1d87e-fcfe-4188-bdeb-a7906471cbe3")
  GUID_ContainerFormatPng* = DEFINE_GUID("1b7cfaf4-713f-473c-bbcd-6137425faeaf")
  GUID_ContainerFormatIco* = DEFINE_GUID("a3a860c4-338f-4c17-919a-fba4b5628f21")
  GUID_ContainerFormatJpeg* = DEFINE_GUID("19e4a5aa-5662-4fc5-a0c0-1758028e1057")
  GUID_ContainerFormatTiff* = DEFINE_GUID("163bcc30-e2e9-4f0b-961d-a3e9fdb788a3")
  GUID_ContainerFormatGif* = DEFINE_GUID("1f8a5601-7d4d-4cbd-9c82-1bc8d4eeb9a5")
  GUID_ContainerFormatWmp* = DEFINE_GUID("57a37caa-367a-4540-916b-f183c5093a4b")
  GUID_VendorMicrosoft* = DEFINE_GUID("f0e749ca-edef-4589-a73a-ee0e626a2a2b")
  CLSID_WICImagingCategories* = DEFINE_GUID("fae3d380-fea4-4623-8c75-c6b61110b681")
  CATID_WICBitmapDecoders* = DEFINE_GUID("7ed96837-96f0-4812-b211-f13c24117ed3")
  CATID_WICBitmapEncoders* = DEFINE_GUID("ac757296-3522-4e11-9862-c17be5a1767e")
  CATID_WICFormatConverters* = DEFINE_GUID("7835eae8-bf14-49d1-93ce-533a407b2248")
  CATID_WICMetadataReader* = DEFINE_GUID("05af94d8-7174-4cd2-be4a-4124b80ee4b8")
  CATID_WICPixelFormats* = DEFINE_GUID("2b46e70f-cda7-473e-89f6-dc9630a2390b")
type
  WICRect* {.pure.} = object
    X*: INT
    Y*: INT
    Width*: INT
    Height*: INT
  WICBitmapPattern* {.pure.} = object
    Position*: ULARGE_INTEGER
    Length*: ULONG
    Pattern*: ptr BYTE
    Mask*: ptr BYTE
    EndOfStream*: WINBOOL
  IWICColorContext* {.pure.} = object
    lpVtbl*: ptr IWICColorContextVtbl
  IWICColorContextVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitializeFromFilename*: proc(self: ptr IWICColorContext, wzFilename: LPCWSTR): HRESULT {.stdcall.}
    InitializeFromMemory*: proc(self: ptr IWICColorContext, pbBuffer: ptr BYTE, cbBufferSize: UINT): HRESULT {.stdcall.}
    InitializeFromExifColorSpace*: proc(self: ptr IWICColorContext, value: UINT): HRESULT {.stdcall.}
    GetType*: proc(self: ptr IWICColorContext, pType: ptr WICColorContextType): HRESULT {.stdcall.}
    GetProfileBytes*: proc(self: ptr IWICColorContext, cbBuffer: UINT, pbBuffer: ptr BYTE, pcbActual: ptr UINT): HRESULT {.stdcall.}
    GetExifColorSpace*: proc(self: ptr IWICColorContext, pValue: ptr UINT): HRESULT {.stdcall.}
  IWICPalette* {.pure.} = object
    lpVtbl*: ptr IWICPaletteVtbl
  IWICPaletteVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    InitializePredefined*: proc(self: ptr IWICPalette, ePaletteType: WICBitmapPaletteType, fAddTransparentColor: WINBOOL): HRESULT {.stdcall.}
    InitializeCustom*: proc(self: ptr IWICPalette, pColors: ptr WICColor, colorCount: UINT): HRESULT {.stdcall.}
    InitializeFromBitmap*: proc(self: ptr IWICPalette, pISurface: ptr IWICBitmapSource, colorCount: UINT, fAddTransparentColor: WINBOOL): HRESULT {.stdcall.}
    InitializeFromPalette*: proc(self: ptr IWICPalette, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    GetType*: proc(self: ptr IWICPalette, pePaletteType: ptr WICBitmapPaletteType): HRESULT {.stdcall.}
    GetColorCount*: proc(self: ptr IWICPalette, pcCount: ptr UINT): HRESULT {.stdcall.}
    GetColors*: proc(self: ptr IWICPalette, colorCount: UINT, pColors: ptr WICColor, pcActualColors: ptr UINT): HRESULT {.stdcall.}
    IsBlackWhite*: proc(self: ptr IWICPalette, pfIsBlackWhite: ptr WINBOOL): HRESULT {.stdcall.}
    IsGrayscale*: proc(self: ptr IWICPalette, pfIsGrayscale: ptr WINBOOL): HRESULT {.stdcall.}
    HasAlpha*: proc(self: ptr IWICPalette, pfHasAlpha: ptr WINBOOL): HRESULT {.stdcall.}
  IWICBitmapSource* {.pure.} = object
    lpVtbl*: ptr IWICBitmapSourceVtbl
  IWICBitmapSourceVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSize*: proc(self: ptr IWICBitmapSource, puiWidth: ptr UINT, puiHeight: ptr UINT): HRESULT {.stdcall.}
    GetPixelFormat*: proc(self: ptr IWICBitmapSource, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.stdcall.}
    GetResolution*: proc(self: ptr IWICBitmapSource, pDpiX: ptr float64, pDpiY: ptr float64): HRESULT {.stdcall.}
    CopyPalette*: proc(self: ptr IWICBitmapSource, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    CopyPixels*: proc(self: ptr IWICBitmapSource, prc: ptr WICRect, cbStride: UINT, cbBufferSize: UINT, pbBuffer: ptr BYTE): HRESULT {.stdcall.}
  IWICBitmapLock* {.pure.} = object
    lpVtbl*: ptr IWICBitmapLockVtbl
  IWICBitmapLockVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetSize*: proc(self: ptr IWICBitmapLock, pWidth: ptr UINT, pHeight: ptr UINT): HRESULT {.stdcall.}
    GetStride*: proc(self: ptr IWICBitmapLock, pcbStride: ptr UINT): HRESULT {.stdcall.}
    GetDataPointer*: proc(self: ptr IWICBitmapLock, pcbBufferSize: ptr UINT, ppbData: ptr ptr BYTE): HRESULT {.stdcall.}
    GetPixelFormat*: proc(self: ptr IWICBitmapLock, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.stdcall.}
  IWICBitmapFlipRotator* {.pure.} = object
    lpVtbl*: ptr IWICBitmapFlipRotatorVtbl
  IWICBitmapFlipRotatorVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Initialize*: proc(self: ptr IWICBitmapFlipRotator, pISource: ptr IWICBitmapSource, options: WICBitmapTransformOptions): HRESULT {.stdcall.}
  IWICBitmap* {.pure.} = object
    lpVtbl*: ptr IWICBitmapVtbl
  IWICBitmapVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Lock*: proc(self: ptr IWICBitmap, prcLock: ptr WICRect, flags: DWORD, ppILock: ptr ptr IWICBitmapLock): HRESULT {.stdcall.}
    SetPalette*: proc(self: ptr IWICBitmap, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    SetResolution*: proc(self: ptr IWICBitmap, dpiX: float64, dpiY: float64): HRESULT {.stdcall.}
  IWICComponentInfo* {.pure.} = object
    lpVtbl*: ptr IWICComponentInfoVtbl
  IWICComponentInfoVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetComponentType*: proc(self: ptr IWICComponentInfo, pType: ptr WICComponentType): HRESULT {.stdcall.}
    GetCLSID*: proc(self: ptr IWICComponentInfo, pclsid: ptr CLSID): HRESULT {.stdcall.}
    GetSigningStatus*: proc(self: ptr IWICComponentInfo, pStatus: ptr DWORD): HRESULT {.stdcall.}
    GetAuthor*: proc(self: ptr IWICComponentInfo, cchAuthor: UINT, wzAuthor: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetVendorGUID*: proc(self: ptr IWICComponentInfo, pguidVendor: ptr GUID): HRESULT {.stdcall.}
    GetVersion*: proc(self: ptr IWICComponentInfo, cchVersion: UINT, wzVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetSpecVersion*: proc(self: ptr IWICComponentInfo, cchSpecVersion: UINT, wzSpecVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetFriendlyName*: proc(self: ptr IWICComponentInfo, cchFriendlyName: UINT, wzFriendlyName: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
  IWICMetadataQueryReader* {.pure.} = object
    lpVtbl*: ptr IWICMetadataQueryReaderVtbl
  IWICMetadataQueryReaderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    GetContainerFormat*: proc(self: ptr IWICMetadataQueryReader, pguidContainerFormat: ptr GUID): HRESULT {.stdcall.}
    GetLocation*: proc(self: ptr IWICMetadataQueryReader, cchMaxLength: UINT, wzNamespace: ptr WCHAR, pcchActualLength: ptr UINT): HRESULT {.stdcall.}
    GetMetadataByName*: proc(self: ptr IWICMetadataQueryReader, wzName: LPCWSTR, pvarValue: ptr PROPVARIANT): HRESULT {.stdcall.}
    GetEnumerator*: proc(self: ptr IWICMetadataQueryReader, ppIEnumString: ptr ptr IEnumString): HRESULT {.stdcall.}
  IWICMetadataQueryWriter* {.pure.} = object
    lpVtbl*: ptr IWICMetadataQueryWriterVtbl
  IWICMetadataQueryWriterVtbl* {.pure, inheritable.} = object of IWICMetadataQueryReaderVtbl
    SetMetadataByName*: proc(self: ptr IWICMetadataQueryWriter, wzName: LPCWSTR, pvarValue: ptr PROPVARIANT): HRESULT {.stdcall.}
    RemoveMetadataByName*: proc(self: ptr IWICMetadataQueryWriter, wzName: LPCWSTR): HRESULT {.stdcall.}
  IWICBitmapFrameDecode* {.pure.} = object
    lpVtbl*: ptr IWICBitmapFrameDecodeVtbl
  IWICBitmapFrameDecodeVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    GetMetadataQueryReader*: proc(self: ptr IWICBitmapFrameDecode, ppIMetadataQueryReader: ptr ptr IWICMetadataQueryReader): HRESULT {.stdcall.}
    GetColorContexts*: proc(self: ptr IWICBitmapFrameDecode, cCount: UINT, ppIColorContexts: ptr ptr IWICColorContext, pcActualCount: ptr UINT): HRESULT {.stdcall.}
    GetThumbnail*: proc(self: ptr IWICBitmapFrameDecode, ppIThumbnail: ptr ptr IWICBitmapSource): HRESULT {.stdcall.}
  IWICPixelFormatInfo* {.pure.} = object
    lpVtbl*: ptr IWICPixelFormatInfoVtbl
  IWICPixelFormatInfoVtbl* {.pure, inheritable.} = object of IWICComponentInfoVtbl
    GetFormatGUID*: proc(self: ptr IWICPixelFormatInfo, pFormat: ptr GUID): HRESULT {.stdcall.}
    GetColorContext*: proc(self: ptr IWICPixelFormatInfo, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.stdcall.}
    GetBitsPerPixel*: proc(self: ptr IWICPixelFormatInfo, puiBitsPerPixel: ptr UINT): HRESULT {.stdcall.}
    GetChannelCount*: proc(self: ptr IWICPixelFormatInfo, puiChannelCount: ptr UINT): HRESULT {.stdcall.}
    GetChannelMask*: proc(self: ptr IWICPixelFormatInfo, uiChannelIndex: UINT, cbMaskBuffer: UINT, pbMaskBuffer: ptr BYTE, pcbActual: ptr UINT): HRESULT {.stdcall.}
  IWICPixelFormatInfo2* {.pure.} = object
    lpVtbl*: ptr IWICPixelFormatInfo2Vtbl
  IWICPixelFormatInfo2Vtbl* {.pure, inheritable.} = object of IWICPixelFormatInfoVtbl
    SupportsTransparency*: proc(self: ptr IWICPixelFormatInfo2, pfSupportsTransparency: ptr WINBOOL): HRESULT {.stdcall.}
    GetNumericRepresentation*: proc(self: ptr IWICPixelFormatInfo2, pNumericRepresentation: ptr WICPixelFormatNumericRepresentation): HRESULT {.stdcall.}
  IWICBitmapCodecInfo* {.pure.} = object
    lpVtbl*: ptr IWICBitmapCodecInfoVtbl
  IWICBitmapCodecInfoVtbl* {.pure, inheritable.} = object of IWICComponentInfoVtbl
    GetContainerFormat*: proc(self: ptr IWICBitmapCodecInfo, pguidContainerFormat: ptr GUID): HRESULT {.stdcall.}
    GetPixelFormats*: proc(self: ptr IWICBitmapCodecInfo, cFormats: UINT, pguidPixelFormats: ptr GUID, pcActual: ptr UINT): HRESULT {.stdcall.}
    GetColorManagementVersion*: proc(self: ptr IWICBitmapCodecInfo, cchColorManagementVersion: UINT, wzColorManagementVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetDeviceManufacturer*: proc(self: ptr IWICBitmapCodecInfo, cchDeviceManufacturer: UINT, wzDeviceManufacturer: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetDeviceModels*: proc(self: ptr IWICBitmapCodecInfo, cchDeviceModels: UINT, wzDeviceModels: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetMimeTypes*: proc(self: ptr IWICBitmapCodecInfo, cchMimeTypes: UINT, wzMimeTypes: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    GetFileExtensions*: proc(self: ptr IWICBitmapCodecInfo, cchFileExtensions: UINT, wzFileExtensions: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.stdcall.}
    DoesSupportAnimation*: proc(self: ptr IWICBitmapCodecInfo, pfSupportAnimation: ptr WINBOOL): HRESULT {.stdcall.}
    DoesSupportChromaKey*: proc(self: ptr IWICBitmapCodecInfo, pfSupportChromaKey: ptr WINBOOL): HRESULT {.stdcall.}
    DoesSupportLossless*: proc(self: ptr IWICBitmapCodecInfo, pfSupportLossless: ptr WINBOOL): HRESULT {.stdcall.}
    DoesSupportMultiframe*: proc(self: ptr IWICBitmapCodecInfo, pfSupportMultiframe: ptr WINBOOL): HRESULT {.stdcall.}
    MatchesMimeType*: proc(self: ptr IWICBitmapCodecInfo, wzMimeType: LPCWSTR, pfMatches: ptr WINBOOL): HRESULT {.stdcall.}
  IWICBitmapDecoder* {.pure.} = object
    lpVtbl*: ptr IWICBitmapDecoderVtbl
  IWICBitmapDecoderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    QueryCapability*: proc(self: ptr IWICBitmapDecoder, pIStream: ptr IStream, pdwCapability: ptr DWORD): HRESULT {.stdcall.}
    Initialize*: proc(self: ptr IWICBitmapDecoder, pIStream: ptr IStream, cacheOptions: WICDecodeOptions): HRESULT {.stdcall.}
    GetContainerFormat*: proc(self: ptr IWICBitmapDecoder, pguidContainerFormat: ptr GUID): HRESULT {.stdcall.}
    GetDecoderInfo*: proc(self: ptr IWICBitmapDecoder, ppIDecoderInfo: ptr ptr IWICBitmapDecoderInfo): HRESULT {.stdcall.}
    CopyPalette*: proc(self: ptr IWICBitmapDecoder, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    GetMetadataQueryReader*: proc(self: ptr IWICBitmapDecoder, ppIMetadataQueryReader: ptr ptr IWICMetadataQueryReader): HRESULT {.stdcall.}
    GetPreview*: proc(self: ptr IWICBitmapDecoder, ppIBitmapSource: ptr ptr IWICBitmapSource): HRESULT {.stdcall.}
    GetColorContexts*: proc(self: ptr IWICBitmapDecoder, cCount: UINT, ppIColorContexts: ptr ptr IWICColorContext, pcActualCount: ptr UINT): HRESULT {.stdcall.}
    GetThumbnail*: proc(self: ptr IWICBitmapDecoder, ppIThumbnail: ptr ptr IWICBitmapSource): HRESULT {.stdcall.}
    GetFrameCount*: proc(self: ptr IWICBitmapDecoder, pCount: ptr UINT): HRESULT {.stdcall.}
    GetFrame*: proc(self: ptr IWICBitmapDecoder, index: UINT, ppIBitmapFrame: ptr ptr IWICBitmapFrameDecode): HRESULT {.stdcall.}
  IWICBitmapDecoderInfo* {.pure.} = object
    lpVtbl*: ptr IWICBitmapDecoderInfoVtbl
  IWICBitmapDecoderInfoVtbl* {.pure, inheritable.} = object of IWICBitmapCodecInfoVtbl
    GetPatterns*: proc(self: ptr IWICBitmapDecoderInfo, cbSizePatterns: UINT, pPatterns: ptr WICBitmapPattern, pcPatterns: ptr UINT, pcbPatternsActual: ptr UINT): HRESULT {.stdcall.}
    MatchesPattern*: proc(self: ptr IWICBitmapDecoderInfo, pIStream: ptr IStream, pfMatches: ptr WINBOOL): HRESULT {.stdcall.}
    CreateInstance*: proc(self: ptr IWICBitmapDecoderInfo, ppIBitmapDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.stdcall.}
  IWICBitmapFrameEncode* {.pure.} = object
    lpVtbl*: ptr IWICBitmapFrameEncodeVtbl
  IWICBitmapFrameEncodeVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IWICBitmapFrameEncode, pIEncoderOptions: ptr IPropertyBag2): HRESULT {.stdcall.}
    SetSize*: proc(self: ptr IWICBitmapFrameEncode, uiWidth: UINT, uiHeight: UINT): HRESULT {.stdcall.}
    SetResolution*: proc(self: ptr IWICBitmapFrameEncode, dpiX: float64, dpiY: float64): HRESULT {.stdcall.}
    SetPixelFormat*: proc(self: ptr IWICBitmapFrameEncode, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.stdcall.}
    SetColorContexts*: proc(self: ptr IWICBitmapFrameEncode, cCount: UINT, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.stdcall.}
    SetPalette*: proc(self: ptr IWICBitmapFrameEncode, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    SetThumbnail*: proc(self: ptr IWICBitmapFrameEncode, pIThumbnail: ptr IWICBitmapSource): HRESULT {.stdcall.}
    WritePixels*: proc(self: ptr IWICBitmapFrameEncode, lineCount: UINT, cbStride: UINT, cbBufferSize: UINT, pbPixels: ptr BYTE): HRESULT {.stdcall.}
    WriteSource*: proc(self: ptr IWICBitmapFrameEncode, pIBitmapSource: ptr IWICBitmapSource, prc: ptr WICRect): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IWICBitmapFrameEncode): HRESULT {.stdcall.}
    GetMetadataQueryWriter*: proc(self: ptr IWICBitmapFrameEncode, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.stdcall.}
  IWICBitmapEncoder* {.pure.} = object
    lpVtbl*: ptr IWICBitmapEncoderVtbl
  IWICBitmapEncoderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Initialize*: proc(self: ptr IWICBitmapEncoder, pIStream: ptr IStream, cacheOption: WICBitmapEncoderCacheOption): HRESULT {.stdcall.}
    GetContainerFormat*: proc(self: ptr IWICBitmapEncoder, pguidContainerFormat: ptr GUID): HRESULT {.stdcall.}
    GetEncoderInfo*: proc(self: ptr IWICBitmapEncoder, ppIEncoderInfo: ptr ptr IWICBitmapEncoderInfo): HRESULT {.stdcall.}
    SetColorContexts*: proc(self: ptr IWICBitmapEncoder, cCount: UINT, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.stdcall.}
    SetPalette*: proc(self: ptr IWICBitmapEncoder, pIPalette: ptr IWICPalette): HRESULT {.stdcall.}
    SetThumbnail*: proc(self: ptr IWICBitmapEncoder, pIThumbnail: ptr IWICBitmapSource): HRESULT {.stdcall.}
    SetPreview*: proc(self: ptr IWICBitmapEncoder, pIPreview: ptr IWICBitmapSource): HRESULT {.stdcall.}
    CreateNewFrame*: proc(self: ptr IWICBitmapEncoder, ppIFrameEncode: ptr ptr IWICBitmapFrameEncode, ppIEncoderOptions: ptr ptr IPropertyBag2): HRESULT {.stdcall.}
    Commit*: proc(self: ptr IWICBitmapEncoder): HRESULT {.stdcall.}
    GetMetadataQueryWriter*: proc(self: ptr IWICBitmapEncoder, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.stdcall.}
  IWICBitmapEncoderInfo* {.pure.} = object
    lpVtbl*: ptr IWICBitmapEncoderInfoVtbl
  IWICBitmapEncoderInfoVtbl* {.pure, inheritable.} = object of IWICBitmapCodecInfoVtbl
    CreateInstance*: proc(self: ptr IWICBitmapEncoderInfo, ppIBitmapEncoder: ptr ptr IWICBitmapEncoder): HRESULT {.stdcall.}
  IWICFormatConverter* {.pure.} = object
    lpVtbl*: ptr IWICFormatConverterVtbl
  IWICFormatConverterVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Initialize*: proc(self: ptr IWICFormatConverter, pISource: ptr IWICBitmapSource, dstFormat: REFWICPixelFormatGUID, dither: WICBitmapDitherType, pIPalette: ptr IWICPalette, alphaThresholdPercent: float64, paletteTranslate: WICBitmapPaletteType): HRESULT {.stdcall.}
    CanConvert*: proc(self: ptr IWICFormatConverter, srcPixelFormat: REFWICPixelFormatGUID, dstPixelFormat: REFWICPixelFormatGUID, pfCanConvert: ptr WINBOOL): HRESULT {.stdcall.}
  IWICFormatConverterInfo* {.pure.} = object
    lpVtbl*: ptr IWICFormatConverterInfoVtbl
  IWICFormatConverterInfoVtbl* {.pure, inheritable.} = object of IWICComponentInfoVtbl
    GetPixelFormats*: proc(self: ptr IWICFormatConverterInfo, cFormats: UINT, pPixelFormatGUIDs: ptr WICPixelFormatGUID, pcActual: ptr UINT): HRESULT {.stdcall.}
    CreateInstance*: proc(self: ptr IWICFormatConverterInfo, ppIConverter: ptr ptr IWICFormatConverter): HRESULT {.stdcall.}
  IWICStream* {.pure.} = object
    lpVtbl*: ptr IWICStreamVtbl
  IWICStreamVtbl* {.pure, inheritable.} = object of IStreamVtbl
    InitializeFromIStream*: proc(self: ptr IWICStream, pIStream: ptr IStream): HRESULT {.stdcall.}
    InitializeFromFilename*: proc(self: ptr IWICStream, wzFileName: LPCWSTR, dwAccessMode: DWORD): HRESULT {.stdcall.}
    InitializeFromMemory*: proc(self: ptr IWICStream, pbBuffer: ptr BYTE, cbBufferSize: DWORD): HRESULT {.stdcall.}
    InitializeFromIStreamRegion*: proc(self: ptr IWICStream, pIStream: ptr IStream, ulOffset: ULARGE_INTEGER, ulMaxSize: ULARGE_INTEGER): HRESULT {.stdcall.}
  IWICBitmapScaler* {.pure.} = object
    lpVtbl*: ptr IWICBitmapScalerVtbl
  IWICBitmapScalerVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Initialize*: proc(self: ptr IWICBitmapScaler, pISource: ptr IWICBitmapSource, uiWidth: UINT, uiHeight: UINT, mode: WICBitmapInterpolationMode): HRESULT {.stdcall.}
  IWICBitmapClipper* {.pure.} = object
    lpVtbl*: ptr IWICBitmapClipperVtbl
  IWICBitmapClipperVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Initialize*: proc(self: ptr IWICBitmapClipper, pISource: ptr IWICBitmapSource, prc: ptr WICRect): HRESULT {.stdcall.}
  IWICColorTransform* {.pure.} = object
    lpVtbl*: ptr IWICColorTransformVtbl
  IWICColorTransformVtbl* {.pure, inheritable.} = object of IWICBitmapSourceVtbl
    Initialize*: proc(self: ptr IWICColorTransform, pIBitmapSource: ptr IWICBitmapSource, pIContextSource: ptr IWICColorContext, pIContextDest: ptr IWICColorContext, pixelFmtDest: REFWICPixelFormatGUID): HRESULT {.stdcall.}
  IWICFastMetadataEncoder* {.pure.} = object
    lpVtbl*: ptr IWICFastMetadataEncoderVtbl
  IWICFastMetadataEncoderVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Commit*: proc(self: ptr IWICFastMetadataEncoder): HRESULT {.stdcall.}
    GetMetadataQueryWriter*: proc(self: ptr IWICFastMetadataEncoder, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.stdcall.}
  IWICImagingFactory* {.pure.} = object
    lpVtbl*: ptr IWICImagingFactoryVtbl
  IWICImagingFactoryVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    CreateDecoderFromFilename*: proc(self: ptr IWICImagingFactory, wzFilename: LPCWSTR, pguidVendor: ptr GUID, dwDesiredAccess: DWORD, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.stdcall.}
    CreateDecoderFromStream*: proc(self: ptr IWICImagingFactory, pIStream: ptr IStream, pguidVendor: ptr GUID, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.stdcall.}
    CreateDecoderFromFileHandle*: proc(self: ptr IWICImagingFactory, hFile: ULONG_PTR, pguidVendor: ptr GUID, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.stdcall.}
    CreateComponentInfo*: proc(self: ptr IWICImagingFactory, clsidComponent: REFCLSID, ppIInfo: ptr ptr IWICComponentInfo): HRESULT {.stdcall.}
    CreateDecoder*: proc(self: ptr IWICImagingFactory, guidContainerFormat: REFGUID, pguidVendor: ptr GUID, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.stdcall.}
    CreateEncoder*: proc(self: ptr IWICImagingFactory, guidContainerFormat: REFGUID, pguidVendor: ptr GUID, ppIEncoder: ptr ptr IWICBitmapEncoder): HRESULT {.stdcall.}
    CreatePalette*: proc(self: ptr IWICImagingFactory, ppIPalette: ptr ptr IWICPalette): HRESULT {.stdcall.}
    CreateFormatConverter*: proc(self: ptr IWICImagingFactory, ppIFormatConverter: ptr ptr IWICFormatConverter): HRESULT {.stdcall.}
    CreateBitmapScaler*: proc(self: ptr IWICImagingFactory, ppIBitmapScaler: ptr ptr IWICBitmapScaler): HRESULT {.stdcall.}
    CreateBitmapClipper*: proc(self: ptr IWICImagingFactory, ppIBitmapClipper: ptr ptr IWICBitmapClipper): HRESULT {.stdcall.}
    CreateBitmapFlipRotator*: proc(self: ptr IWICImagingFactory, ppIBitmapFlipRotator: ptr ptr IWICBitmapFlipRotator): HRESULT {.stdcall.}
    CreateStream*: proc(self: ptr IWICImagingFactory, ppIWICStream: ptr ptr IWICStream): HRESULT {.stdcall.}
    CreateColorContext*: proc(self: ptr IWICImagingFactory, ppIWICColorContext: ptr ptr IWICColorContext): HRESULT {.stdcall.}
    CreateColorTransformer*: proc(self: ptr IWICImagingFactory, ppIWICColorTransform: ptr ptr IWICColorTransform): HRESULT {.stdcall.}
    CreateBitmap*: proc(self: ptr IWICImagingFactory, uiWidth: UINT, uiHeight: UINT, pixelFormat: REFWICPixelFormatGUID, option: WICBitmapCreateCacheOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateBitmapFromSource*: proc(self: ptr IWICImagingFactory, piBitmapSource: ptr IWICBitmapSource, option: WICBitmapCreateCacheOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateBitmapFromSourceRect*: proc(self: ptr IWICImagingFactory, piBitmapSource: ptr IWICBitmapSource, x: UINT, y: UINT, width: UINT, height: UINT, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateBitmapFromMemory*: proc(self: ptr IWICImagingFactory, uiWidth: UINT, uiHeight: UINT, pixelFormat: REFWICPixelFormatGUID, cbStride: UINT, cbBufferSize: UINT, pbBuffer: ptr BYTE, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateBitmapFromHBITMAP*: proc(self: ptr IWICImagingFactory, hBitmap: HBITMAP, hPalette: HPALETTE, options: WICBitmapAlphaChannelOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateBitmapFromHICON*: proc(self: ptr IWICImagingFactory, hIcon: HICON, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.stdcall.}
    CreateComponentEnumerator*: proc(self: ptr IWICImagingFactory, componentTypes: DWORD, options: DWORD, ppIEnumUnknown: ptr ptr IEnumUnknown): HRESULT {.stdcall.}
    CreateFastMetadataEncoderFromDecoder*: proc(self: ptr IWICImagingFactory, pIDecoder: ptr IWICBitmapDecoder, ppIFastEncoder: ptr ptr IWICFastMetadataEncoder): HRESULT {.stdcall.}
    CreateFastMetadataEncoderFromFrameDecode*: proc(self: ptr IWICImagingFactory, pIFrameDecoder: ptr IWICBitmapFrameDecode, ppIFastEncoder: ptr ptr IWICFastMetadataEncoder): HRESULT {.stdcall.}
    CreateQueryWriter*: proc(self: ptr IWICImagingFactory, guidMetadataFormat: REFGUID, pguidVendor: ptr GUID, ppIQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.stdcall.}
    CreateQueryWriterFromReader*: proc(self: ptr IWICImagingFactory, pIQueryReader: ptr IWICMetadataQueryReader, pguidVendor: ptr GUID, ppIQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.stdcall.}
  IWICEnumMetadataItem* {.pure.} = object
    lpVtbl*: ptr IWICEnumMetadataItemVtbl
  IWICEnumMetadataItemVtbl* {.pure, inheritable.} = object of IUnknownVtbl
    Next*: proc(self: ptr IWICEnumMetadataItem, celt: ULONG, rgeltSchema: ptr PROPVARIANT, rgeltId: ptr PROPVARIANT, rgeltValue: ptr PROPVARIANT, pceltFetched: ptr ULONG): HRESULT {.stdcall.}
    Skip*: proc(self: ptr IWICEnumMetadataItem, celt: ULONG): HRESULT {.stdcall.}
    Reset*: proc(self: ptr IWICEnumMetadataItem): HRESULT {.stdcall.}
    Clone*: proc(self: ptr IWICEnumMetadataItem, ppIEnumMetadataItem: ptr ptr IWICEnumMetadataItem): HRESULT {.stdcall.}
proc InitializeFromFilename*(self: ptr IWICColorContext, wzFilename: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromFilename(self, wzFilename)
proc InitializeFromMemory*(self: ptr IWICColorContext, pbBuffer: ptr BYTE, cbBufferSize: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromMemory(self, pbBuffer, cbBufferSize)
proc InitializeFromExifColorSpace*(self: ptr IWICColorContext, value: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromExifColorSpace(self, value)
proc GetType*(self: ptr IWICColorContext, pType: ptr WICColorContextType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pType)
proc GetProfileBytes*(self: ptr IWICColorContext, cbBuffer: UINT, pbBuffer: ptr BYTE, pcbActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetProfileBytes(self, cbBuffer, pbBuffer, pcbActual)
proc GetExifColorSpace*(self: ptr IWICColorContext, pValue: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetExifColorSpace(self, pValue)
proc GetSize*(self: ptr IWICBitmapSource, puiWidth: ptr UINT, puiHeight: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, puiWidth, puiHeight)
proc GetPixelFormat*(self: ptr IWICBitmapSource, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPixelFormat(self, pPixelFormat)
proc GetResolution*(self: ptr IWICBitmapSource, pDpiX: ptr float64, pDpiY: ptr float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetResolution(self, pDpiX, pDpiY)
proc CopyPalette*(self: ptr IWICBitmapSource, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyPalette(self, pIPalette)
proc CopyPixels*(self: ptr IWICBitmapSource, prc: ptr WICRect, cbStride: UINT, cbBufferSize: UINT, pbBuffer: ptr BYTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyPixels(self, prc, cbStride, cbBufferSize, pbBuffer)
proc GetSize*(self: ptr IWICBitmapLock, pWidth: ptr UINT, pHeight: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSize(self, pWidth, pHeight)
proc GetStride*(self: ptr IWICBitmapLock, pcbStride: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetStride(self, pcbStride)
proc GetDataPointer*(self: ptr IWICBitmapLock, pcbBufferSize: ptr UINT, ppbData: ptr ptr BYTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDataPointer(self, pcbBufferSize, ppbData)
proc GetPixelFormat*(self: ptr IWICBitmapLock, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPixelFormat(self, pPixelFormat)
proc Initialize*(self: ptr IWICBitmapFlipRotator, pISource: ptr IWICBitmapSource, options: WICBitmapTransformOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pISource, options)
proc Lock*(self: ptr IWICBitmap, prcLock: ptr WICRect, flags: DWORD, ppILock: ptr ptr IWICBitmapLock): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Lock(self, prcLock, flags, ppILock)
proc SetPalette*(self: ptr IWICBitmap, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPalette(self, pIPalette)
proc SetResolution*(self: ptr IWICBitmap, dpiX: float64, dpiY: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetResolution(self, dpiX, dpiY)
proc InitializePredefined*(self: ptr IWICPalette, ePaletteType: WICBitmapPaletteType, fAddTransparentColor: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializePredefined(self, ePaletteType, fAddTransparentColor)
proc InitializeCustom*(self: ptr IWICPalette, pColors: ptr WICColor, colorCount: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeCustom(self, pColors, colorCount)
proc InitializeFromBitmap*(self: ptr IWICPalette, pISurface: ptr IWICBitmapSource, colorCount: UINT, fAddTransparentColor: WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromBitmap(self, pISurface, colorCount, fAddTransparentColor)
proc InitializeFromPalette*(self: ptr IWICPalette, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromPalette(self, pIPalette)
proc GetType*(self: ptr IWICPalette, pePaletteType: ptr WICBitmapPaletteType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetType(self, pePaletteType)
proc GetColorCount*(self: ptr IWICPalette, pcCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorCount(self, pcCount)
proc GetColors*(self: ptr IWICPalette, colorCount: UINT, pColors: ptr WICColor, pcActualColors: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColors(self, colorCount, pColors, pcActualColors)
proc IsBlackWhite*(self: ptr IWICPalette, pfIsBlackWhite: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsBlackWhite(self, pfIsBlackWhite)
proc IsGrayscale*(self: ptr IWICPalette, pfIsGrayscale: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.IsGrayscale(self, pfIsGrayscale)
proc HasAlpha*(self: ptr IWICPalette, pfHasAlpha: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.HasAlpha(self, pfHasAlpha)
proc GetComponentType*(self: ptr IWICComponentInfo, pType: ptr WICComponentType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetComponentType(self, pType)
proc GetCLSID*(self: ptr IWICComponentInfo, pclsid: ptr CLSID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetCLSID(self, pclsid)
proc GetSigningStatus*(self: ptr IWICComponentInfo, pStatus: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSigningStatus(self, pStatus)
proc GetAuthor*(self: ptr IWICComponentInfo, cchAuthor: UINT, wzAuthor: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetAuthor(self, cchAuthor, wzAuthor, pcchActual)
proc GetVendorGUID*(self: ptr IWICComponentInfo, pguidVendor: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVendorGUID(self, pguidVendor)
proc GetVersion*(self: ptr IWICComponentInfo, cchVersion: UINT, wzVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetVersion(self, cchVersion, wzVersion, pcchActual)
proc GetSpecVersion*(self: ptr IWICComponentInfo, cchSpecVersion: UINT, wzSpecVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetSpecVersion(self, cchSpecVersion, wzSpecVersion, pcchActual)
proc GetFriendlyName*(self: ptr IWICComponentInfo, cchFriendlyName: UINT, wzFriendlyName: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFriendlyName(self, cchFriendlyName, wzFriendlyName, pcchActual)
proc GetContainerFormat*(self: ptr IWICMetadataQueryReader, pguidContainerFormat: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainerFormat(self, pguidContainerFormat)
proc GetLocation*(self: ptr IWICMetadataQueryReader, cchMaxLength: UINT, wzNamespace: ptr WCHAR, pcchActualLength: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetLocation(self, cchMaxLength, wzNamespace, pcchActualLength)
proc GetMetadataByName*(self: ptr IWICMetadataQueryReader, wzName: LPCWSTR, pvarValue: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataByName(self, wzName, pvarValue)
proc GetEnumerator*(self: ptr IWICMetadataQueryReader, ppIEnumString: ptr ptr IEnumString): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEnumerator(self, ppIEnumString)
proc SetMetadataByName*(self: ptr IWICMetadataQueryWriter, wzName: LPCWSTR, pvarValue: ptr PROPVARIANT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetMetadataByName(self, wzName, pvarValue)
proc RemoveMetadataByName*(self: ptr IWICMetadataQueryWriter, wzName: LPCWSTR): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.RemoveMetadataByName(self, wzName)
proc GetMetadataQueryReader*(self: ptr IWICBitmapFrameDecode, ppIMetadataQueryReader: ptr ptr IWICMetadataQueryReader): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataQueryReader(self, ppIMetadataQueryReader)
proc GetColorContexts*(self: ptr IWICBitmapFrameDecode, cCount: UINT, ppIColorContexts: ptr ptr IWICColorContext, pcActualCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorContexts(self, cCount, ppIColorContexts, pcActualCount)
proc GetThumbnail*(self: ptr IWICBitmapFrameDecode, ppIThumbnail: ptr ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetThumbnail(self, ppIThumbnail)
proc GetFormatGUID*(self: ptr IWICPixelFormatInfo, pFormat: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFormatGUID(self, pFormat)
proc GetColorContext*(self: ptr IWICPixelFormatInfo, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorContext(self, ppIColorContext)
proc GetBitsPerPixel*(self: ptr IWICPixelFormatInfo, puiBitsPerPixel: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetBitsPerPixel(self, puiBitsPerPixel)
proc GetChannelCount*(self: ptr IWICPixelFormatInfo, puiChannelCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChannelCount(self, puiChannelCount)
proc GetChannelMask*(self: ptr IWICPixelFormatInfo, uiChannelIndex: UINT, cbMaskBuffer: UINT, pbMaskBuffer: ptr BYTE, pcbActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetChannelMask(self, uiChannelIndex, cbMaskBuffer, pbMaskBuffer, pcbActual)
proc SupportsTransparency*(self: ptr IWICPixelFormatInfo2, pfSupportsTransparency: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SupportsTransparency(self, pfSupportsTransparency)
proc GetNumericRepresentation*(self: ptr IWICPixelFormatInfo2, pNumericRepresentation: ptr WICPixelFormatNumericRepresentation): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetNumericRepresentation(self, pNumericRepresentation)
proc GetContainerFormat*(self: ptr IWICBitmapCodecInfo, pguidContainerFormat: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainerFormat(self, pguidContainerFormat)
proc GetPixelFormats*(self: ptr IWICBitmapCodecInfo, cFormats: UINT, pguidPixelFormats: ptr GUID, pcActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPixelFormats(self, cFormats, pguidPixelFormats, pcActual)
proc GetColorManagementVersion*(self: ptr IWICBitmapCodecInfo, cchColorManagementVersion: UINT, wzColorManagementVersion: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorManagementVersion(self, cchColorManagementVersion, wzColorManagementVersion, pcchActual)
proc GetDeviceManufacturer*(self: ptr IWICBitmapCodecInfo, cchDeviceManufacturer: UINT, wzDeviceManufacturer: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDeviceManufacturer(self, cchDeviceManufacturer, wzDeviceManufacturer, pcchActual)
proc GetDeviceModels*(self: ptr IWICBitmapCodecInfo, cchDeviceModels: UINT, wzDeviceModels: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDeviceModels(self, cchDeviceModels, wzDeviceModels, pcchActual)
proc GetMimeTypes*(self: ptr IWICBitmapCodecInfo, cchMimeTypes: UINT, wzMimeTypes: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMimeTypes(self, cchMimeTypes, wzMimeTypes, pcchActual)
proc GetFileExtensions*(self: ptr IWICBitmapCodecInfo, cchFileExtensions: UINT, wzFileExtensions: ptr WCHAR, pcchActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFileExtensions(self, cchFileExtensions, wzFileExtensions, pcchActual)
proc DoesSupportAnimation*(self: ptr IWICBitmapCodecInfo, pfSupportAnimation: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoesSupportAnimation(self, pfSupportAnimation)
proc DoesSupportChromaKey*(self: ptr IWICBitmapCodecInfo, pfSupportChromaKey: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoesSupportChromaKey(self, pfSupportChromaKey)
proc DoesSupportLossless*(self: ptr IWICBitmapCodecInfo, pfSupportLossless: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoesSupportLossless(self, pfSupportLossless)
proc DoesSupportMultiframe*(self: ptr IWICBitmapCodecInfo, pfSupportMultiframe: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.DoesSupportMultiframe(self, pfSupportMultiframe)
proc MatchesMimeType*(self: ptr IWICBitmapCodecInfo, wzMimeType: LPCWSTR, pfMatches: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MatchesMimeType(self, wzMimeType, pfMatches)
proc GetPatterns*(self: ptr IWICBitmapDecoderInfo, cbSizePatterns: UINT, pPatterns: ptr WICBitmapPattern, pcPatterns: ptr UINT, pcbPatternsActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPatterns(self, cbSizePatterns, pPatterns, pcPatterns, pcbPatternsActual)
proc MatchesPattern*(self: ptr IWICBitmapDecoderInfo, pIStream: ptr IStream, pfMatches: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.MatchesPattern(self, pIStream, pfMatches)
proc CreateInstance*(self: ptr IWICBitmapDecoderInfo, ppIBitmapDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, ppIBitmapDecoder)
proc QueryCapability*(self: ptr IWICBitmapDecoder, pIStream: ptr IStream, pdwCapability: ptr DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.QueryCapability(self, pIStream, pdwCapability)
proc Initialize*(self: ptr IWICBitmapDecoder, pIStream: ptr IStream, cacheOptions: WICDecodeOptions): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pIStream, cacheOptions)
proc GetContainerFormat*(self: ptr IWICBitmapDecoder, pguidContainerFormat: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainerFormat(self, pguidContainerFormat)
proc GetDecoderInfo*(self: ptr IWICBitmapDecoder, ppIDecoderInfo: ptr ptr IWICBitmapDecoderInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetDecoderInfo(self, ppIDecoderInfo)
proc CopyPalette*(self: ptr IWICBitmapDecoder, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CopyPalette(self, pIPalette)
proc GetMetadataQueryReader*(self: ptr IWICBitmapDecoder, ppIMetadataQueryReader: ptr ptr IWICMetadataQueryReader): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataQueryReader(self, ppIMetadataQueryReader)
proc GetPreview*(self: ptr IWICBitmapDecoder, ppIBitmapSource: ptr ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPreview(self, ppIBitmapSource)
proc GetColorContexts*(self: ptr IWICBitmapDecoder, cCount: UINT, ppIColorContexts: ptr ptr IWICColorContext, pcActualCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetColorContexts(self, cCount, ppIColorContexts, pcActualCount)
proc GetThumbnail*(self: ptr IWICBitmapDecoder, ppIThumbnail: ptr ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetThumbnail(self, ppIThumbnail)
proc GetFrameCount*(self: ptr IWICBitmapDecoder, pCount: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFrameCount(self, pCount)
proc GetFrame*(self: ptr IWICBitmapDecoder, index: UINT, ppIBitmapFrame: ptr ptr IWICBitmapFrameDecode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetFrame(self, index, ppIBitmapFrame)
proc Initialize*(self: ptr IWICBitmapFrameEncode, pIEncoderOptions: ptr IPropertyBag2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pIEncoderOptions)
proc SetSize*(self: ptr IWICBitmapFrameEncode, uiWidth: UINT, uiHeight: UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetSize(self, uiWidth, uiHeight)
proc SetResolution*(self: ptr IWICBitmapFrameEncode, dpiX: float64, dpiY: float64): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetResolution(self, dpiX, dpiY)
proc SetPixelFormat*(self: ptr IWICBitmapFrameEncode, pPixelFormat: ptr WICPixelFormatGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPixelFormat(self, pPixelFormat)
proc SetColorContexts*(self: ptr IWICBitmapFrameEncode, cCount: UINT, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColorContexts(self, cCount, ppIColorContext)
proc SetPalette*(self: ptr IWICBitmapFrameEncode, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPalette(self, pIPalette)
proc SetThumbnail*(self: ptr IWICBitmapFrameEncode, pIThumbnail: ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThumbnail(self, pIThumbnail)
proc WritePixels*(self: ptr IWICBitmapFrameEncode, lineCount: UINT, cbStride: UINT, cbBufferSize: UINT, pbPixels: ptr BYTE): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WritePixels(self, lineCount, cbStride, cbBufferSize, pbPixels)
proc WriteSource*(self: ptr IWICBitmapFrameEncode, pIBitmapSource: ptr IWICBitmapSource, prc: ptr WICRect): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.WriteSource(self, pIBitmapSource, prc)
proc Commit*(self: ptr IWICBitmapFrameEncode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self)
proc GetMetadataQueryWriter*(self: ptr IWICBitmapFrameEncode, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataQueryWriter(self, ppIMetadataQueryWriter)
proc CreateInstance*(self: ptr IWICBitmapEncoderInfo, ppIBitmapEncoder: ptr ptr IWICBitmapEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, ppIBitmapEncoder)
proc Initialize*(self: ptr IWICBitmapEncoder, pIStream: ptr IStream, cacheOption: WICBitmapEncoderCacheOption): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pIStream, cacheOption)
proc GetContainerFormat*(self: ptr IWICBitmapEncoder, pguidContainerFormat: ptr GUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetContainerFormat(self, pguidContainerFormat)
proc GetEncoderInfo*(self: ptr IWICBitmapEncoder, ppIEncoderInfo: ptr ptr IWICBitmapEncoderInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetEncoderInfo(self, ppIEncoderInfo)
proc SetColorContexts*(self: ptr IWICBitmapEncoder, cCount: UINT, ppIColorContext: ptr ptr IWICColorContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetColorContexts(self, cCount, ppIColorContext)
proc SetPalette*(self: ptr IWICBitmapEncoder, pIPalette: ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPalette(self, pIPalette)
proc SetThumbnail*(self: ptr IWICBitmapEncoder, pIThumbnail: ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetThumbnail(self, pIThumbnail)
proc SetPreview*(self: ptr IWICBitmapEncoder, pIPreview: ptr IWICBitmapSource): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.SetPreview(self, pIPreview)
proc CreateNewFrame*(self: ptr IWICBitmapEncoder, ppIFrameEncode: ptr ptr IWICBitmapFrameEncode, ppIEncoderOptions: ptr ptr IPropertyBag2): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateNewFrame(self, ppIFrameEncode, ppIEncoderOptions)
proc Commit*(self: ptr IWICBitmapEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self)
proc GetMetadataQueryWriter*(self: ptr IWICBitmapEncoder, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataQueryWriter(self, ppIMetadataQueryWriter)
proc Initialize*(self: ptr IWICFormatConverter, pISource: ptr IWICBitmapSource, dstFormat: REFWICPixelFormatGUID, dither: WICBitmapDitherType, pIPalette: ptr IWICPalette, alphaThresholdPercent: float64, paletteTranslate: WICBitmapPaletteType): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pISource, dstFormat, dither, pIPalette, alphaThresholdPercent, paletteTranslate)
proc CanConvert*(self: ptr IWICFormatConverter, srcPixelFormat: REFWICPixelFormatGUID, dstPixelFormat: REFWICPixelFormatGUID, pfCanConvert: ptr WINBOOL): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CanConvert(self, srcPixelFormat, dstPixelFormat, pfCanConvert)
proc GetPixelFormats*(self: ptr IWICFormatConverterInfo, cFormats: UINT, pPixelFormatGUIDs: ptr WICPixelFormatGUID, pcActual: ptr UINT): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetPixelFormats(self, cFormats, pPixelFormatGUIDs, pcActual)
proc CreateInstance*(self: ptr IWICFormatConverterInfo, ppIConverter: ptr ptr IWICFormatConverter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateInstance(self, ppIConverter)
proc InitializeFromIStream*(self: ptr IWICStream, pIStream: ptr IStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromIStream(self, pIStream)
proc InitializeFromFilename*(self: ptr IWICStream, wzFileName: LPCWSTR, dwAccessMode: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromFilename(self, wzFileName, dwAccessMode)
proc InitializeFromMemory*(self: ptr IWICStream, pbBuffer: ptr BYTE, cbBufferSize: DWORD): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromMemory(self, pbBuffer, cbBufferSize)
proc InitializeFromIStreamRegion*(self: ptr IWICStream, pIStream: ptr IStream, ulOffset: ULARGE_INTEGER, ulMaxSize: ULARGE_INTEGER): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.InitializeFromIStreamRegion(self, pIStream, ulOffset, ulMaxSize)
proc Initialize*(self: ptr IWICBitmapScaler, pISource: ptr IWICBitmapSource, uiWidth: UINT, uiHeight: UINT, mode: WICBitmapInterpolationMode): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pISource, uiWidth, uiHeight, mode)
proc Initialize*(self: ptr IWICBitmapClipper, pISource: ptr IWICBitmapSource, prc: ptr WICRect): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pISource, prc)
proc Initialize*(self: ptr IWICColorTransform, pIBitmapSource: ptr IWICBitmapSource, pIContextSource: ptr IWICColorContext, pIContextDest: ptr IWICColorContext, pixelFmtDest: REFWICPixelFormatGUID): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Initialize(self, pIBitmapSource, pIContextSource, pIContextDest, pixelFmtDest)
proc Commit*(self: ptr IWICFastMetadataEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Commit(self)
proc GetMetadataQueryWriter*(self: ptr IWICFastMetadataEncoder, ppIMetadataQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.GetMetadataQueryWriter(self, ppIMetadataQueryWriter)
proc CreateDecoderFromFilename*(self: ptr IWICImagingFactory, wzFilename: LPCWSTR, pguidVendor: ptr GUID, dwDesiredAccess: DWORD, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDecoderFromFilename(self, wzFilename, pguidVendor, dwDesiredAccess, metadataOptions, ppIDecoder)
proc CreateDecoderFromStream*(self: ptr IWICImagingFactory, pIStream: ptr IStream, pguidVendor: ptr GUID, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDecoderFromStream(self, pIStream, pguidVendor, metadataOptions, ppIDecoder)
proc CreateDecoderFromFileHandle*(self: ptr IWICImagingFactory, hFile: ULONG_PTR, pguidVendor: ptr GUID, metadataOptions: WICDecodeOptions, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDecoderFromFileHandle(self, hFile, pguidVendor, metadataOptions, ppIDecoder)
proc CreateComponentInfo*(self: ptr IWICImagingFactory, clsidComponent: REFCLSID, ppIInfo: ptr ptr IWICComponentInfo): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateComponentInfo(self, clsidComponent, ppIInfo)
proc CreateDecoder*(self: ptr IWICImagingFactory, guidContainerFormat: REFGUID, pguidVendor: ptr GUID, ppIDecoder: ptr ptr IWICBitmapDecoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateDecoder(self, guidContainerFormat, pguidVendor, ppIDecoder)
proc CreateEncoder*(self: ptr IWICImagingFactory, guidContainerFormat: REFGUID, pguidVendor: ptr GUID, ppIEncoder: ptr ptr IWICBitmapEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateEncoder(self, guidContainerFormat, pguidVendor, ppIEncoder)
proc CreatePalette*(self: ptr IWICImagingFactory, ppIPalette: ptr ptr IWICPalette): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreatePalette(self, ppIPalette)
proc CreateFormatConverter*(self: ptr IWICImagingFactory, ppIFormatConverter: ptr ptr IWICFormatConverter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateFormatConverter(self, ppIFormatConverter)
proc CreateBitmapScaler*(self: ptr IWICImagingFactory, ppIBitmapScaler: ptr ptr IWICBitmapScaler): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapScaler(self, ppIBitmapScaler)
proc CreateBitmapClipper*(self: ptr IWICImagingFactory, ppIBitmapClipper: ptr ptr IWICBitmapClipper): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapClipper(self, ppIBitmapClipper)
proc CreateBitmapFlipRotator*(self: ptr IWICImagingFactory, ppIBitmapFlipRotator: ptr ptr IWICBitmapFlipRotator): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFlipRotator(self, ppIBitmapFlipRotator)
proc CreateStream*(self: ptr IWICImagingFactory, ppIWICStream: ptr ptr IWICStream): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateStream(self, ppIWICStream)
proc CreateColorContext*(self: ptr IWICImagingFactory, ppIWICColorContext: ptr ptr IWICColorContext): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateColorContext(self, ppIWICColorContext)
proc CreateColorTransformer*(self: ptr IWICImagingFactory, ppIWICColorTransform: ptr ptr IWICColorTransform): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateColorTransformer(self, ppIWICColorTransform)
proc CreateBitmap*(self: ptr IWICImagingFactory, uiWidth: UINT, uiHeight: UINT, pixelFormat: REFWICPixelFormatGUID, option: WICBitmapCreateCacheOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmap(self, uiWidth, uiHeight, pixelFormat, option, ppIBitmap)
proc CreateBitmapFromSource*(self: ptr IWICImagingFactory, piBitmapSource: ptr IWICBitmapSource, option: WICBitmapCreateCacheOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFromSource(self, piBitmapSource, option, ppIBitmap)
proc CreateBitmapFromSourceRect*(self: ptr IWICImagingFactory, piBitmapSource: ptr IWICBitmapSource, x: UINT, y: UINT, width: UINT, height: UINT, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFromSourceRect(self, piBitmapSource, x, y, width, height, ppIBitmap)
proc CreateBitmapFromMemory*(self: ptr IWICImagingFactory, uiWidth: UINT, uiHeight: UINT, pixelFormat: REFWICPixelFormatGUID, cbStride: UINT, cbBufferSize: UINT, pbBuffer: ptr BYTE, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFromMemory(self, uiWidth, uiHeight, pixelFormat, cbStride, cbBufferSize, pbBuffer, ppIBitmap)
proc CreateBitmapFromHBITMAP*(self: ptr IWICImagingFactory, hBitmap: HBITMAP, hPalette: HPALETTE, options: WICBitmapAlphaChannelOption, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFromHBITMAP(self, hBitmap, hPalette, options, ppIBitmap)
proc CreateBitmapFromHICON*(self: ptr IWICImagingFactory, hIcon: HICON, ppIBitmap: ptr ptr IWICBitmap): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateBitmapFromHICON(self, hIcon, ppIBitmap)
proc CreateComponentEnumerator*(self: ptr IWICImagingFactory, componentTypes: DWORD, options: DWORD, ppIEnumUnknown: ptr ptr IEnumUnknown): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateComponentEnumerator(self, componentTypes, options, ppIEnumUnknown)
proc CreateFastMetadataEncoderFromDecoder*(self: ptr IWICImagingFactory, pIDecoder: ptr IWICBitmapDecoder, ppIFastEncoder: ptr ptr IWICFastMetadataEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateFastMetadataEncoderFromDecoder(self, pIDecoder, ppIFastEncoder)
proc CreateFastMetadataEncoderFromFrameDecode*(self: ptr IWICImagingFactory, pIFrameDecoder: ptr IWICBitmapFrameDecode, ppIFastEncoder: ptr ptr IWICFastMetadataEncoder): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateFastMetadataEncoderFromFrameDecode(self, pIFrameDecoder, ppIFastEncoder)
proc CreateQueryWriter*(self: ptr IWICImagingFactory, guidMetadataFormat: REFGUID, pguidVendor: ptr GUID, ppIQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateQueryWriter(self, guidMetadataFormat, pguidVendor, ppIQueryWriter)
proc CreateQueryWriterFromReader*(self: ptr IWICImagingFactory, pIQueryReader: ptr IWICMetadataQueryReader, pguidVendor: ptr GUID, ppIQueryWriter: ptr ptr IWICMetadataQueryWriter): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.CreateQueryWriterFromReader(self, pIQueryReader, pguidVendor, ppIQueryWriter)
proc Next*(self: ptr IWICEnumMetadataItem, celt: ULONG, rgeltSchema: ptr PROPVARIANT, rgeltId: ptr PROPVARIANT, rgeltValue: ptr PROPVARIANT, pceltFetched: ptr ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Next(self, celt, rgeltSchema, rgeltId, rgeltValue, pceltFetched)
proc Skip*(self: ptr IWICEnumMetadataItem, celt: ULONG): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Skip(self, celt)
proc Reset*(self: ptr IWICEnumMetadataItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Reset(self)
proc Clone*(self: ptr IWICEnumMetadataItem, ppIEnumMetadataItem: ptr ptr IWICEnumMetadataItem): HRESULT {.winapi, inline.} = {.gcsafe.}: self.lpVtbl.Clone(self, ppIEnumMetadataItem)
converter winimConverterIWICColorContextToIUnknown*(x: ptr IWICColorContext): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapSourceToIUnknown*(x: ptr IWICBitmapSource): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapLockToIUnknown*(x: ptr IWICBitmapLock): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapFlipRotatorToIWICBitmapSource*(x: ptr IWICBitmapFlipRotator): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICBitmapFlipRotatorToIUnknown*(x: ptr IWICBitmapFlipRotator): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapToIWICBitmapSource*(x: ptr IWICBitmap): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICBitmapToIUnknown*(x: ptr IWICBitmap): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICPaletteToIUnknown*(x: ptr IWICPalette): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICComponentInfoToIUnknown*(x: ptr IWICComponentInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICMetadataQueryReaderToIUnknown*(x: ptr IWICMetadataQueryReader): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICMetadataQueryWriterToIWICMetadataQueryReader*(x: ptr IWICMetadataQueryWriter): ptr IWICMetadataQueryReader = cast[ptr IWICMetadataQueryReader](x)
converter winimConverterIWICMetadataQueryWriterToIUnknown*(x: ptr IWICMetadataQueryWriter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapFrameDecodeToIWICBitmapSource*(x: ptr IWICBitmapFrameDecode): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICBitmapFrameDecodeToIUnknown*(x: ptr IWICBitmapFrameDecode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICPixelFormatInfoToIWICComponentInfo*(x: ptr IWICPixelFormatInfo): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICPixelFormatInfoToIUnknown*(x: ptr IWICPixelFormatInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICPixelFormatInfo2ToIWICPixelFormatInfo*(x: ptr IWICPixelFormatInfo2): ptr IWICPixelFormatInfo = cast[ptr IWICPixelFormatInfo](x)
converter winimConverterIWICPixelFormatInfo2ToIWICComponentInfo*(x: ptr IWICPixelFormatInfo2): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICPixelFormatInfo2ToIUnknown*(x: ptr IWICPixelFormatInfo2): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapCodecInfoToIWICComponentInfo*(x: ptr IWICBitmapCodecInfo): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICBitmapCodecInfoToIUnknown*(x: ptr IWICBitmapCodecInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapDecoderInfoToIWICBitmapCodecInfo*(x: ptr IWICBitmapDecoderInfo): ptr IWICBitmapCodecInfo = cast[ptr IWICBitmapCodecInfo](x)
converter winimConverterIWICBitmapDecoderInfoToIWICComponentInfo*(x: ptr IWICBitmapDecoderInfo): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICBitmapDecoderInfoToIUnknown*(x: ptr IWICBitmapDecoderInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapDecoderToIUnknown*(x: ptr IWICBitmapDecoder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapFrameEncodeToIUnknown*(x: ptr IWICBitmapFrameEncode): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapEncoderInfoToIWICBitmapCodecInfo*(x: ptr IWICBitmapEncoderInfo): ptr IWICBitmapCodecInfo = cast[ptr IWICBitmapCodecInfo](x)
converter winimConverterIWICBitmapEncoderInfoToIWICComponentInfo*(x: ptr IWICBitmapEncoderInfo): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICBitmapEncoderInfoToIUnknown*(x: ptr IWICBitmapEncoderInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapEncoderToIUnknown*(x: ptr IWICBitmapEncoder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICFormatConverterToIWICBitmapSource*(x: ptr IWICFormatConverter): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICFormatConverterToIUnknown*(x: ptr IWICFormatConverter): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICFormatConverterInfoToIWICComponentInfo*(x: ptr IWICFormatConverterInfo): ptr IWICComponentInfo = cast[ptr IWICComponentInfo](x)
converter winimConverterIWICFormatConverterInfoToIUnknown*(x: ptr IWICFormatConverterInfo): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICStreamToIStream*(x: ptr IWICStream): ptr IStream = cast[ptr IStream](x)
converter winimConverterIWICStreamToISequentialStream*(x: ptr IWICStream): ptr ISequentialStream = cast[ptr ISequentialStream](x)
converter winimConverterIWICStreamToIUnknown*(x: ptr IWICStream): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapScalerToIWICBitmapSource*(x: ptr IWICBitmapScaler): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICBitmapScalerToIUnknown*(x: ptr IWICBitmapScaler): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICBitmapClipperToIWICBitmapSource*(x: ptr IWICBitmapClipper): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICBitmapClipperToIUnknown*(x: ptr IWICBitmapClipper): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICColorTransformToIWICBitmapSource*(x: ptr IWICColorTransform): ptr IWICBitmapSource = cast[ptr IWICBitmapSource](x)
converter winimConverterIWICColorTransformToIUnknown*(x: ptr IWICColorTransform): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICFastMetadataEncoderToIUnknown*(x: ptr IWICFastMetadataEncoder): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICImagingFactoryToIUnknown*(x: ptr IWICImagingFactory): ptr IUnknown = cast[ptr IUnknown](x)
converter winimConverterIWICEnumMetadataItemToIUnknown*(x: ptr IWICEnumMetadataItem): ptr IUnknown = cast[ptr IUnknown](x)
