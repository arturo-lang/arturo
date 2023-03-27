#=======================================================
# Arturo
# Programming Language + Bytecode VM compiler
# (c) 2019-2023 Yanis Zafirópulos
#
# @file: vm/values/custom/vcomplex.nim
#=======================================================

## The internal `:complex` type

# Contains code based on
# the Complex module: https://raw.githubusercontent.com/nim-lang/Nim/version-1-6/lib/pure/complex.nim
# which forms part of the Nim standard library.
# (c) Copyright 2010 Andreas Rumpf

{.push checks: off, line_dir: off, stack_trace: off, debugger: off.}

#=======================================
# Libraries
#=======================================

import math

#=======================================
# Types
#=======================================

type
    VComplexObj*[T: SomeFloat] = object
        re*: T
        im*: T

    Complex32* = VComplexObj[float32]
    VComplex* = VComplexObj[float64]

#=======================================
# Helpers
#=======================================

func complex*[T: SomeFloat](re: T; im: T = 0.0): VComplexObj[T] =
    result.re = re
    result.im = im

func complex32*(re: float32; im: float32 = 0.0): Complex32 =
    result.re = re
    result.im = im

func complex64*(re: float64; im: float64 = 0.0): VComplex =
    result.re = re
    result.im = im

template im*(arg: typedesc[float32]): Complex32 = complex32(0, 1)
template im*(arg: typedesc[float64]): VComplex = complex64(0, 1)
template im*(arg: float32): Complex32 = complex32(0, arg)
template im*(arg: float64): VComplex = complex64(0, arg)

#=======================================
# Methods
#=======================================

func abs*[T](z: VComplexObj[T]): T =
    result = hypot(z.re, z.im)

func abs2*[T](z: VComplexObj[T]): T =
    result = z.re * z.re + z.im * z.im

func conjugate*[T](z: VComplexObj[T]): VComplexObj[T] =
    result.re = z.re
    result.im = -z.im

func inv*[T](z: VComplexObj[T]): VComplexObj[T] =
    conjugate(z) / abs2(z)

func `==`*[T](x, y: VComplexObj[T]): bool =
    result = x.re == y.re and x.im == y.im

func `+`*[T](x: T; y: VComplexObj[T]): VComplexObj[T] =
    result.re = x + y.re
    result.im = y.im

func `+`*[T](x: VComplexObj[T]; y: T): VComplexObj[T] =
    result.re = x.re + y
    result.im = x.im

func `+=`*[T](x: var VComplexObj[T]; y: T) =
    x.re += y

func `+`*[T](x, y: VComplexObj[T]): VComplexObj[T] =
    result.re = x.re + y.re
    result.im = x.im + y.im

func `+=`*[T](x: var VComplexObj[T], y: VComplexObj[T]) =
    x.re += y.re
    x.im += y.im

func `-`*[T](z: VComplexObj[T]): VComplexObj[T] =
    result.re = -z.re
    result.im = -z.im

func `-`*[T](x: T; y: VComplexObj[T]): VComplexObj[T] =
    result.re = x - y.re
    result.im = -y.im

func `-`*[T](x: VComplexObj[T]; y: T): VComplexObj[T] =
    result.re = x.re - y
    result.im = x.im

func `-=`*[T](x: var VComplexObj[T]; y: T) =
    x.re -= y

func `-`*[T](x, y: VComplexObj[T]): VComplexObj[T] =
    result.re = x.re - y.re
    result.im = x.im - y.im

func `-=`*[T](x: var VComplexObj[T], y: VComplexObj[T]) =
    x.re -= y.re
    x.im -= y.im

func `*`*[T](x: T; y: VComplexObj[T]): VComplexObj[T] =
    result.re = x * y.re
    result.im = x * y.im

func `*`*[T](x: VComplexObj[T]; y: T): VComplexObj[T] =
    result.re = x.re * y
    result.im = x.im * y

func `*=`*[T](x: var VComplexObj[T]; y: T) =
    x.re *= y
    x.im *= y

func `*`*[T](x, y: VComplexObj[T]): VComplexObj[T] =
    result.re = x.re * y.re - x.im * y.im
    result.im = x.im * y.re + x.re * y.im

func `*=`*[T](x: var VComplexObj[T], y: VComplexObj[T]) =
    x.re *= y.re
    x.re -= x.im * y.im
    x.im *= y.re
    x.im += x.re * y.im

func `/`*[T](x: VComplexObj[T]; y: T): VComplexObj[T] =
    result.re = x.re / y
    result.im = x.im / y
    
func `/=`*[T](x: var VComplexObj[T]; y: T) =
    x.re /= y
    x.im /= y

func `/`*[T](x: T; y: VComplexObj[T]): VComplexObj[T] =
    result = x * inv(y)

func `/`*[T](x, y: VComplexObj[T]): VComplexObj[T] =
    var r, den: T
    if abs(y.re) < abs(y.im):
        r = y.re / y.im
        den = y.im + r * y.re
        result.re = (x.re * r + x.im) / den
        result.im = (x.im * r - x.re) / den
    else:
        r = y.im / y.re
        den = y.re + r * y.im
        result.re = (x.re + r * x.im) / den
        result.im = (x.im - r * x.re) / den

func `/=`*[T](x: var VComplexObj[T], y: VComplexObj[T]) =
    x = x / y

func sqrt*[T](z: VComplexObj[T]): VComplexObj[T] =
    ## ([principal](https://en.wikipedia.org/wiki/Square_root#Principal_square_root_of_a_complex_number))
    var x, y, w, r: T

    if z.re == 0.0 and z.im == 0.0:
        result = z
    else:
        x = abs(z.re)
        y = abs(z.im)
        if x >= y:
            r = y / x
            w = sqrt(x) * sqrt(0.5 * (1.0 + sqrt(1.0 + r * r)))
        else:
            r = x / y
            w = sqrt(y) * sqrt(0.5 * (r + sqrt(1.0 + r * r)))

        if z.re >= 0.0:
            result.re = w
            result.im = z.im / (w * 2.0)
        else:
            result.im = if z.im >= 0.0: w else: -w
            result.re = z.im / (result.im + result.im)

func exp*[T](z: VComplexObj[T]): VComplexObj[T] =
    let
        rho = exp(z.re)
        theta = z.im
    result.re = rho * cos(theta)
    result.im = rho * sin(theta)

func ln*[T](z: VComplexObj[T]): VComplexObj[T] =
    result.re = ln(abs(z))
    result.im = arctan2(z.im, z.re)

func log10*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(z) / ln(10.0)

func log2*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(z) / ln(2.0)

func pow*[T](x, y: VComplexObj[T]): VComplexObj[T] =
    if x.re == 0.0 and x.im == 0.0:
        if y.re == 0.0 and y.im == 0.0:
            result.re = 1.0
            result.im = 0.0
        else:
            result.re = 0.0
            result.im = 0.0
    elif y.re == 1.0 and y.im == 0.0:
        result = x
    elif y.re == -1.0 and y.im == 0.0:
        result = T(1.0) / x
    else:
        let
            rho = abs(x)
            theta = arctan2(x.im, x.re)
            s = pow(rho, y.re) * exp(-y.im * theta)
            r = y.re * theta + y.im * ln(rho)
        result.re = s * cos(r)
        result.im = s * sin(r)

func pow*[T](x: VComplexObj[T]; y: T): VComplexObj[T] =
    pow(x, complex[T](y))

func sin*[T](z: VComplexObj[T]): VComplexObj[T] =
    result.re = sin(z.re) * cosh(z.im)
    result.im = cos(z.re) * sinh(z.im)

func arcsin*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = -im(T) * ln(im(T) * z + sqrt(T(1.0) - z*z))

func cos*[T](z: VComplexObj[T]): VComplexObj[T] =
    result.re = cos(z.re) * cosh(z.im)
    result.im = -sin(z.re) * sinh(z.im)

func arccos*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = -im(T) * ln(z + sqrt(z*z - T(1.0)))

func tan*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = sin(z) / cos(z)

func arctan*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5)*im(T) * (ln(T(1.0) - im(T)*z) - ln(T(1.0) + im(T)*z))

func cot*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = cos(z)/sin(z)

func arccot*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5)*im(T) * (ln(T(1.0) - im(T)/z) - ln(T(1.0) + im(T)/z))

func sec*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(1.0) / cos(z)

func arcsec*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = -im(T) * ln(im(T) * sqrt(1.0 - 1.0/(z*z)) + T(1.0)/z)

func csc*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(1.0) / sin(z)

func arccsc*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = -im(T) * ln(sqrt(T(1.0) - T(1.0)/(z*z)) + im(T)/z)

func sinh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5) * (exp(z) - exp(-z))

func arcsinh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(z + sqrt(z*z + 1.0))

func cosh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5) * (exp(z) + exp(-z))

func arccosh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(z + sqrt(z*z - T(1.0)))

func tanh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = sinh(z) / cosh(z)

func arctanh*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5) * (ln((T(1.0)+z) / (T(1.0)-z)))

func coth*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = cosh(z) / sinh(z)

func arccoth*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(0.5) * (ln(T(1.0) + T(1.0)/z) - ln(T(1.0) - T(1.0)/z))

func sech*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(2.0) / (exp(z) + exp(-z))

func arcsech*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(1.0/z + sqrt(T(1.0)/z+T(1.0)) * sqrt(T(1.0)/z-T(1.0)))

func csch*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = T(2.0) / (exp(z) - exp(-z))

func arccsch*[T](z: VComplexObj[T]): VComplexObj[T] =
    result = ln(T(1.0)/z + sqrt(T(1.0)/(z*z) + T(1.0)))

func phase*[T](z: VComplexObj[T]): T =
    arctan2(z.im, z.re)

func polar*[T](z: VComplexObj[T]): tuple[r, phi: T] =
    (r: abs(z), phi: phase(z))

func rect*[T](r, phi: T): VComplexObj[T] =
    complex(r * cos(phi), r * sin(phi))

func `$`*(z: VComplexObj): string =
    result = "(" & $z.re & ", " & $z.im & ")"

{.pop.}