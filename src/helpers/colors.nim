######################################################
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2022 Yanis Zafirópulos
#
# @file: helpers/colors.nim
######################################################

#=======================================
# Libraries
#=======================================

import math, random, sequtils
import strutils, sugar

#=======================================
# Types
#=======================================

type
    VColor* = distinct int

    RGB* = tuple[r: int, g: int, b: int, a: int]
    HSL* = tuple[h: int, s: float, l: float, a: int]
    HSV* = tuple[h: int, s: float, v: float, a: int]
    Palette = seq[VColor]

#=======================================
# Global Variables
#=======================================

var
    NoColors* = false

#=======================================
# Constants
#=======================================

const
    noColor*     = "\e[0m"

    blackColor*     = ";30"
    redColor*       = ";31"
    greenColor*     = ";32"
    yellowColor*    = ";33"
    blueColor*      = ";34"
    magentaColor*   = ";35"
    cyanColor*      = ";36"
    whiteColor*     = ";37"
    grayColor*      = ";90"

#=======================================
# Templates
#=======================================

template resetColor*():string =
    if NoColors: ""
    else: noColor

template fg*(color: string=""):string =
    if NoColors: ""
    else: "\e[0" & color & "m"

template bold*(color: string=""):string =
    if NoColors: ""
    else: "\e[1" & color & "m"

template underline*(color: string=""):string = 
    if NoColors: ""
    else: "\e[4" & color & "m"

template rgb*(color: string=""):string =
    if NoColors: ""
    else: ";38;5;" & color

template rgb*(color: tuple[r, g, b: range[0 .. 255]]):string =
    if NoColors: ""
    else: ";38;2;" & $(color[0]) & ";" & $(color[1]) & ";" & $(color[2])

template colorFromRGB*(r, g, b: int, a = 0xff): VColor =
    VColor(r shl 24 or g shl 16 or b shl 8 or a)

template colorFromRGB*(rgb: RGB): VColor =
    RGBColor(rgb.r shl 24 or rgb.g shl 16 or rgb.b shl 8 or rgb.a)

proc RGBfromColor*(c: VColor): RGB =
    result.r = c.int shr 24 and 0xff
    result.g = c.int shr 16 and 0xff
    result.b = c.int shr 8 and 0xff
    result.a = c.int and 0xff

proc RGBAfromColor*(c: VColor): RGB =
    result.r = c.int shr 24 and 0xff
    result.g = c.int shr 16 and 0xff
    result.b = c.int shr 8 and 0xff
    result.a = c.int and 0xff

proc parseColor*(s: string): VColor =
    result = VColor(0xff88cc55)

#=======================================
# Helpers
#=======================================

proc hueToRGB*(p, q, t: float): float =
    var T = t
    if t<0: T += 1.0
    if t>1: T -= 1.0

    if T < 1/6.0: return (p+(q-p)*6*T)
    if T < 1/2.0: return q
    if T < 2/3.0: return (p+(q-p)*(2/3.0-T)*6)
    return p

proc satPlus(a, b: int): int {.inline.} =
    result = a +% b
    if result > 255: result = 255

proc satMinus(a, b: int): int {.inline.} =
    result = a -% b
    if result < 0: result = 0

proc `==` *(a, b: VColor): bool {.borrow.}

proc `+`*(a, b: VColor): VColor =
    let A = RGBfromColor(a)
    let B = RGBfromColor(b)

    colorFromRGB(
        satPlus(A.r, B.r),
        satPlus(A.g, B.g),
        satPlus(A.b, B.b),
        satPlus(A.a, B.a)
    )

proc `-`*(a, b: VColor): VColor =
    let A = RGBfromColor(a)
    let B = RGBfromColor(b)

    colorFromRGB(
        satMinus(A.r, B.r),
        satMinus(A.g, B.g),
        satMinus(A.b, B.b),
        satMinus(A.a, B.a)
    )

proc `$`*(c: VColor): string =
    result = '#' & toHex(int(c), 8)

#=======================================
# Methods
#=======================================

proc alterColorValue*(c: RGBColor, f: float): RGBColor =
    var (r,g,b) = RGBfromColor(c)
    var pcent: float
    if f > 0:
        pcent = f
        r = satPlus(r, toInt(toFloat(r) * pcent))
        g = satPlus(g, toInt(toFloat(g) * pcent))
        b = satPlus(b, toInt(toFloat(b) * pcent))
        result = colorFromRGB(r, g, b)
    elif f < 0:
        pcent = (-1) * f
        r = satMinus(r, toInt(toFloat(r) * pcent))
        g = satMinus(g, toInt(toFloat(g) * pcent))
        b = satMinus(b, toInt(toFloat(b) * pcent))
        result = colorFromRGB(r, g, b)
    else:
        return c

proc HSLtoRGB*(hsl: HSL): RGB =
    let h = hsl.h/360
    let s = hsl.s
    let l = hsl.l

    var r = 0.0
    var g = 0.0
    var b = 0.0
    
    if s == 0.0:
        r = l
        g = l
        b = l
    else:
        var q: float
        if l<0.5:   q = l * (1+s)
        else:       q = l + s - l * s

        let p = 2*l - q
        r = (hueToRGB(p, q, h + 1/3.0) * 255).round
        g = (hueToRGB(p, q, h) * 255).round
        b = (hueToRGB(p, q, h - 1/3.0) * 255).round

    return ((int)r, (int)g, (int)b)

proc HSVtoRGB*(hsv: HSV): RGB =
    let h = (((float)hsv.h)/360)
    let s = hsv.s
    let v = hsv.v

    var r = 0.0
    var g = 0.0
    var b = 0.0

    let hI = (float)(h*6)
    let f = (float)(h*6 - hI)
    let p = v * (1 - s)
    let q = v * (float)(1 - f*s)
    let t = v * (float)(1 - (1 - f) * s)
    
    if hI==0: (r, g, b) = (v, t, p)
    elif hI==1: (r, g, b) = (q, v, p)
    elif hI==2: (r, g, b) = (p, v, t)
    elif hI==3: (r, g, b) = (p, q, v)
    elif hI==4: (r, g, b) = (t, p, v)
    elif hI==5: (r, g, b) = (v, p, q)

    r = 255*r
    g = 255*g
    b = 255*b

    return ((int)r, (int)g, (int)b)

proc RGBtoHSL*(c: RGBColor): HSL =
    let rgb = RGBfromColor(c)

    let R = rgb.r / 255
    let G = rgb.g / 255
    let B = rgb.b / 255

    let cMax = max(@[R,G,B])
    let cMin = min(@[R,G,B])
    let D = cMax - cMin

    var h,s,l : float

    if D==0:
        h = 0
    elif cMax==R:
        h = (G-B)/D
        if G<B: h += 6.0
    elif cMax==G:
        h = (B-R)/D + 2
    elif cMax==B:
        h = ((R-G)/D) + 4

    h /= 6.0
    h = (360*h).round

    l = (cMax + cMin)/2

    if D==0:
        s = 0
    else:
        s = D / (1 - abs(2*l - 1))

    return ((int)h,s,l)

proc RGBtoHSV*(c: RGBColor): HSV =
    let rgb = RGBfromColor(c)

    let R = rgb.r / 255
    let G = rgb.g / 255
    let B = rgb.b / 255

    let cMax = max(@[R,G,B])
    let cMin = min(@[R,G,B])
    let D = cMax - cMin

    var s = 0.0
    var v = cMax*100.0

    if cMax != 0.0:
        s = D / cMax * 100
    
    var h = 0.0
    if s != 0.0:
        if R == cMax:
            h = (G - B) / D
        elif G == cMax:
            h = 2 + (B - R) / D
        elif B == cMax:
            h = 4 + (R - G) / D

        h *= 60.0

        if h < 0:
            h += 360.0

    return ((int)h,s/100.0,v/100.0)

proc invertColor*(c: RGBColor): RGB =
    var hsl = RGBtoHSL(c)
    hsl.h += 180;
    if hsl.h > 360:
        hsl.h -= 360
    return HSLtoRGB(hsl)

proc saturateColor*(c: RGBColor, diff: float): RGB =
    var hsl = RGBtoHSL(c)
    hsl.s = hsl.s + hsl.s * diff
    if hsl.s > 1: hsl.s = 1
    if hsl.s < 0: hsl.s = 0
    return HSLtoRGB(hsl)

proc blendColors*(c1: RGBColor, c2: RGBColor, balance: float): RGB =
    let rgb1 = RGBfromColor(c1)
    let rgb2 = RGBfromColor(c2)

    let w1 = 1.0 - balance
    let w2 = balance

    let r = (float)(rgb1.r) * w1 + (float)(rgb2.r) * w2
    let g = (float)(rgb1.g) * w1 + (float)(rgb2.g) * w2
    let b = (float)(rgb1.b) * w1 + (float)(rgb2.b) * w2

    return ((int)(r.round), (int)(g.round), (int)(b.round))

func spinColor*(c: RGBColor, amount: int): RGBColor =
    var hsl = RGBtoHSL(c)
    let hue = (hsl.h + amount) mod 360
    if hue < 0: 
        hsl.h = hue + 360
    else:
        hsl.h = hue    
    
    return colorFromRGB(HSLtoRGB(hsl))

# Palettes

proc triadPalette*(c: RGBColor): Palette =
    result = @[0, 120, 240].map((x) => spinColor(c, x))

proc tetradPalette*(c: RGBColor): Palette =
    result = @[0, 90, 180, 270].map((x) => spinColor(c, x))

proc splitPalette*(c: RGBColor): Palette =
    result = @[0, 72, 216].map((x) => spinColor(c, x))

proc analogousPalette*(c: RGBColor, size: int): Palette =
    let slices = 30
    let part = (int)(360 / slices)

    var hsl = RGBtoHSL(c)
    hsl.h = ((hsl.h - (part * (size shr 1))) + 720) mod 360
                
    var i = 0
    while i < size:
        result.add(colorFromRGB(HSLtoRGB(hsl)))
        hsl.h = (hsl.h + part) mod 360
        inc i

proc monochromePalette*(c: RGBColor, size: int): Palette =
    var hsv = RGBtoHSV(c)
    let modification = 1.0 / (float)(size)
    var i = 0
    while i < size:
        result.add(colorFromRGB(HSVtoRGB(hsv)))
        hsv.v = hsv.v - modification
        inc i

proc randomPalette*(c: RGBColor, size: int): Palette =
    let threshold = 0.2
    result.add(c)
    while len(result) < size:
        for col in triadPalette(c):
            if len(result) == size: return
            var r = rand(2*threshold) - threshold
            result.add(alterColorValue(col, r))
            result = result.deduplicate()