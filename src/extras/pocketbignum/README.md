<h1 align="center">
    PocketBignum
</h1>

<p align="center">
    <b>Small, fast & portable<br>arbitrary-precision arithmetic, in a single C header</b>
    <br><br>
    <img src="https://img.shields.io/github/license/pocket-libs/pocket-bignum?style=for-the-badge">
    <img src="https://img.shields.io/badge/language-C-6489E2.svg?style=for-the-badge" alt="Language"/>
    <a href="https://github.com/pocket-libs/pocket-bignum/actions/workflows/ci.yml" style="text-decoration: none; display: inline-block;"><img src="https://img.shields.io/github/actions/workflow/status/pocket-libs/pocket-bignum/ci.yml?branch=main&label=tests&style=for-the-badge" alt="Tests"/></a>
</p>

---

<!--ts-->

* [What does this library do?](#what-does-this-library-do)
* [How do I use it?](#how-do-i-use-it)
    * [As a GMP/MPFR replacement](#as-a-gmpmpfr-replacement)
    * [Options](#options)
* [What's in it?](#whats-in-it)
* [How fast is it?](#how-fast-is-it)
* [Testing](#testing)
* [Limitations](#limitations)
* [License](#license)

<!--te-->

---

### What does this library do?

Integers, rationals and correctly-rounded binary floats - of any size - with no dependencies whatsoever: just one header file you drop into your project.

It covers a big part of GMP & MPFR (with the same semantics, down to the edge cases), comes with drop-in `gmp.h` / `mpfr.h` facades, and - for everyday sizes - it's just as fast.

> [!TIP]
> If what you need is the absolute fastest thing for numbers with millions of digits, GMP is still your friend. If what you need is something small, portable and fast enough that you can just *bundle*, then you're in the right place. :wink:

### How do I use it?

Simply include it, and define `PBN_IMPLEMENTATION` in exactly one `.c` file (or just compile `pocketbignum.c`):

```c
#include <stdio.h>
#include <stdlib.h>

#define PBN_IMPLEMENTATION
#include "pocketbignum.h"

int main(void) {
    pbz_t a;
    pbz_init(a);

    pbz_ui_pow_ui(a, 3, 1000);                  // 3^1000
    char *s = pbz_get_str(NULL, 10, a);
    printf("%s\n", s);

    free(s);
    pbz_clear(a);
    return 0;
}
```

The native names are `pbz_*` (integers), `pbq_*` (rationals) and `pbf_*` (floats).

#### As a GMP/MPFR replacement

Put `compat/` on your include path and `<gmp.h>` & `<mpfr.h>` map `mpz_*`, `mpq_*` and `mpfr_*` to PocketBignum - with identical struct layouts and field names (`__mpz_struct`, `__mpq_struct`, `__mpfr_struct`). That is: code written for GMP/MPFR should compile and run as it is.

#### Options

- `PBN_STATIC`: everything `static`
- `PBN_LIMB_BITS=32|64`: the limb size
- `PBN_PORTABLE`: pure C (no intrinsics, no `__int128`)
- `PBN_NO_ASM`: no assembly kernels
- `PBN_ABORT(msg)`: what to do on a fatal error (by default: out of memory aborts; division by zero, NaN or infinity to an integer and square roots of negative numbers raise SIGFPE - just like GMP)

Every algorithm threshold (`PBN_MUL_TOOM3_THRESHOLD`, `PBN_MUL_FFT_THRESHOLD`, etc) can also be overridden with `-D`.

### What's in it?

| Layer | Functions |
|---|---|
| `mpz` | ~145: arithmetic, all t/f/c divisions, 2exp ops, bitwise (two's complement), scan0/scan1, pow/powm/invert, gcd/gcdext/lcm, sqrt/root, perfect powers, jacobi/kronecker, remove, congruences, fac/2fac/mfac, primorial, binomials, Fibonacci & Lucas numbers, primality (BPSW), next/prevprime, conversions, strings |
| `mpq` | ~30: canonicalize, add/sub/mul/div, inv/neg/abs, mul/div_2exp, cmp*, get/set_d, get/set_str, num/den access |
| `mpfr` | ~85: init/clear/prec, set/get (d, si, ui, z, str), cmp*, comparison predicates, fits_uint_p, add/sub/mul/div (+ `_z`, `_d`, `_ui`, `_si`), sqr, min/max, floor/ceil/trunc, setsign/copysign, pow, pow_z, predicates. All 5 rounding modes, correct rounding, ternary values, exponent range [1-2^30, 2^30-1] - like MPFR |

The semantics follow GMP/MPFR precisely - edge cases included: `mpz_probab_prime_p`'s 2/1/0 cutoffs, `mpq_set_si(0, d)` → 0/1, `mpfr_get_str` digit counts and MPFR's double-rounding of ties, `mpfr_set_str`'s syntax (`@inf@`, `nan(...)`, `0x...p`, `@` exponents), signed zeros, and `pow`'s special cases (C99 Annex F).

Under the hood: Karatsuba, Toom-3 & Toom-4, an FFT (number-theoretic transforms modulo three primes) for big products, divide & conquer division and radix conversion, half-gcd, Montgomery `powm`, assembly kernels on x86-64 & arm64 - and thresholds tuned per CPU.

### How fast is it?

Here's how it compares to GMP 6.3 / MPFR 4.2.2: the ratio is PocketBignum's time divided by GMP's or MPFR's - so, lower is better and 1.0× means "just as fast". (Medians of 5 runs on CI - Linux, 64-bit limbs; amd64: AMD EPYC, arm64: Neoverse-N2)

| | amd64 | arm64 |
|---|---|---|
| mpz add (1–256 limbs) | 0.7–1.0× | 1.0–1.1× |
| mpz mul, sqr (1–2 limbs) | 0.9–1.0× | 0.4–1.0× |
| mpz mul, sqr (4–64 limbs) | 1.3–2.0× | 0.9–1.4× |
| mpz mul, sqr (128–4096 limbs) | 1.5–1.9× | 1.3–1.6× |
| mpz mul, sqr (7000–100000 limbs, FFT) | 1.3–2.0× | 1.4–1.9× |
| mpz division (2n by n limbs) | 1.1–1.5× | 1.2–1.4× |
| mpz division (quotient much shorter than the divisor) | 1.9× | 1.6× |
| mpz gcd | 0.7× (1 limb) – 1.9× | 1.0–1.9× |
| mpz powm (1–2 limb moduli) | 0.9× | 0.6–1.2× |
| mpz powm (4–32 limb moduli), prime_p | 1.3–2.1× | 1.0–1.3× |
| mpz fac_ui | 0.2× (n = 20) – 2.0× | 0.2–1.9× |
| mpz sqrt | 0.7× (1 limb) – 1.6× | 0.4–1.5× |
| mpz get_str, set_str (base 10, 4–1024 limbs) | 1.1–1.7× | 1.1–1.5× |
| mpq (small & ~120-bit parts) add, mul, div, cmp, get_str, set_d | 0.4–1.1× | 0.4–1.4× |
| mpq get_d | 0.6× (small) – 2.1× | 0.6–1.5× |
| mpfr 53-bit add, sub, mul, mul_z, cmp, set_d, get_d, get_str, set_str | 0.4–1.4× | 0.3–1.4× |
| mpfr 53-bit div, add_d | 1.2–1.3× | 1.1–1.2× |
| mpfr 256-bit add, sub | 2.6–3.9× | 1.9–3.5× |
| mpfr 256-bit mul, div | 1.4× | 1.1× |
| mpfr 256-bit add_d, mul_z, cmp, set_d, get_d, get_str, set_str | 0.4–1.6× | 0.4–1.5× |
| mpfr pow, pow_z | 1.9–2.8× | 1.6–2.2× |
| **all 103 benchmarks (geometric mean)** | **1.17×** | **1.11×** |

> [!NOTE]
> In whole programs - arithmetic loops, `powm`, primality tests, conversions, small rationals - that's within 0.8–1.2× of GMP. Where you'll actually notice the difference is with numbers of tens of thousands of limbs (e.g. `3^3000000`), or long sums of big fractions: there, it's 2–3× slower.

`make bench` runs the same benchmarks locally.

### Testing

```sh
make test                           # everything below
make test64 test32 testportable     # mpz fuzzing vs GMP (64-bit limbs, 32-bit limbs, pure C)
make testqf                         # mpq fuzzing vs GMP + mpfr fuzzing vs MPFR (same three builds)
make testcompat                     # a program written against <gmp.h> names
make testthresholds                 # fuzzing with tiny thresholds: (almost) every operation goes
                                    # through Karatsuba, Toom & divide-and-conquer
make bench                          # timings vs GMP / MPFR
make bench-ruby                     # timings vs Ruby's Integer (needs ruby)
make bench-small                    # small numbers (1-3 limbs)
tools/tune.sh [name...]             # threshold sweeps: each threshold timed with a few values
```

The fuzzers run under ASan + UBSan, comparing every result, ternary value and aliasing variant against GMP 6.3 / MPFR 4.2.2 (which are only needed for testing: `GMP=/prefix`).

### Limitations

- Very large numbers: multiplication above a few thousand limbs goes through an FFT modulo three primes (GMP uses Schönhage–Strassen and hand-tuned assembly) and is 1.3–2× slower; there's no Newton division either (division is divide & conquer at every size), so dividing or printing numbers of ~10⁵ limbs is 2–3× slower than GMP
- Mid-size multiplication (300–2000 limbs): it goes up to Toom-4 (no Toom-6/8) and is 1.5–1.8× slower
- Assembly: only the `add_n` / `sub_n` / `mul_1` / `addmul_1` / `submul_1` kernels, on x86-64 (`mul_1` & co. with ADX, detected at runtime) and arm64, with GCC or Clang - everything else (and MSVC, 32-bit or `PBN_PORTABLE` builds) is plain C; e.g. 4-16 limb products on amd64 are 1.3-2× slower than with GMP ([#45](https://github.com/pocket-libs/pocket-bignum/issues/45))
- Thresholds are tuned for the CPUs of the CI runners (amd64 & arm64) - for other ones, `tools/tune.sh` will find better values
- Floats: there's no same-precision fast path for multi-limb add/sub ([#23](https://github.com/pocket-libs/pocket-bignum/issues/23)), and `pow` needs double-limb kernels to get to MPFR's speed ([#24](https://github.com/pocket-libs/pocket-bignum/issues/24))
- The memory functions (`pbn_set_memory_functions`) are global: set them before any thread uses the library
- Not implemented: `mpf_*`, `mpn_*`, random numbers & `mpz_import/export` ([#47](https://github.com/pocket-libs/pocket-bignum/issues/47)), I/O streams, and MPFR's transcendentals (`exp`, `log`, trigonometric functions, etc. - `pow` is there: [#48](https://github.com/pocket-libs/pocket-bignum/issues/48))

> [!IMPORTANT]
> For anything else, have a look at the [open issues](https://github.com/pocket-libs/pocket-bignum/issues) - or open a new one!

---

### License

MIT License

Copyright (c) 2026 Yanis Zafirópulos

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
