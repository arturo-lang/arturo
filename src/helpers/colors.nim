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

import math
import std/colors as stdColors

#=======================================
# Types
#=======================================

type
    RGB* = tuple[r: int, g: int, b: int]
    HSL* = tuple[h: int, s: float, l: float]

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

template rawRGB(r, g, b: int): stdColors.Color =
    stdColors.Color(r shl 16 or g shl 8 or b)

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

#=======================================
# Methods
#=======================================

proc alterColorValue*(c: stdColors.Color, f: float): stdColors.Color =
    var (r,g,b) = extractRGB(c)
    var pcent: float
    if f > 0:
        pcent = f
        r = satPlus(r, toInt(toFloat(r) * pcent))
        g = satPlus(g, toInt(toFloat(g) * pcent))
        b = satPlus(b, toInt(toFloat(b) * pcent))
        result = rawRGB(r, g, b)
    elif f < 0:
        pcent = (-1) * f
        r = satMinus(r, toInt(toFloat(r) * pcent))
        g = satMinus(g, toInt(toFloat(g) * pcent))
        b = satMinus(b, toInt(toFloat(b) * pcent))
        result = rawRGB(r, g, b)
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

proc RGBtoHSL*(c: Color): HSL =
    let rgb = extractRGB(c)

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

proc invertColor*(c: Color): RGB =
    var hsl = RGBtoHSL(c)
    hsl.h += 180;
    if hsl.h > 360:
        hsl.h -= 360
    return HSLtoRGB(hsl)

proc saturateColor*(c: Color, diff: float): RGB =
    var hsl = RGBtoHSL(c)
    hsl.s = hsl.s + hsl.s * diff
    if hsl.s > 1: hsl.s = 1
    if hsl.s < 0: hsl.s = 0
    return HSLtoRGB(hsl)

proc blendColors*(c1: Color, c2: Color, balance: float): RGB =
    let rgb1 = extractRGB(c1)
    let rgb2 = extractRGB(c2)

    let w1 = 1.0 - balance
    let w2 = balance

    let r = (float)(rgb1.r) * w1 + (float)(rgb2.r) * w2
    let g = (float)(rgb1.g) * w1 + (float)(rgb2.g) * w2
    let b = (float)(rgb1.b) * w1 + (float)(rgb2.b) * w2

    return ((int)(r.round), (int)(g.round), (int)(b.round))