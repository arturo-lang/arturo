# PocketBignum

[![CI](https://github.com/pocket-libs/pocket-bignum/actions/workflows/ci.yml/badge.svg)](https://github.com/pocket-libs/pocket-bignum/actions/workflows/ci.yml)

Small, fast, portable arbitrary-precision arithmetic in a single C99 header:
integers, rationals and correctly rounded binary floats. Exposes the subset of
GMP + MPFR that [Arturo](https://arturo-lang.io) uses, with drop-in `gmp.h` /
`mpfr.h` facades. MIT licensed. No dependencies.

## Usage

```c
#define PBN_IMPLEMENTATION      // in exactly one .c file (or just compile pocketbignum.c)
#include "pocketbignum.h"       // native names: pbz_* (int), pbq_* (rational), pbf_* (float)
```

As a GMP/MPFR replacement, put `compat/` on the include path; `<gmp.h>` and
`<mpfr.h>` then map `mpz_*`, `mpq_*`, `mpfr_*` to PocketBignum, with identical
struct layouts and field names (`__mpz_struct`, `__mpq_struct`, `__mpfr_struct`).

Options: `PBN_STATIC`, `PBN_LIMB_BITS=32|64`, `PBN_PORTABLE` (no intrinsics / `__int128`), `PBN_ABORT(msg)`.

## Scope

| Layer | Functions |
|---|---|
| `mpz` | ~115: arithmetic, all t/f/c divisions, 2exp ops, bitwise (two's complement), pow/powm/invert, gcd/lcm, sqrt, fac, primality (BPSW), nextprime, conversions, strings |
| `mpq` | ~30: canonicalize, add/sub/mul/div, inv/neg/abs, mul/div_2exp, cmp*, get/set_d, get/set_str, num/den access |
| `mpfr` | ~50: init/clear/prec, set/get (d, si, ui, z, str), cmp*, fits_uint_p, add/sub/mul/div (+ `_z`, `_d`), pow, pow_z, predicates. All 5 rounding modes, correct rounding, ternary values, exponent range [1-2^30, 2^30-1] like MPFR |

Semantics follow GMP/MPFR precisely, including edge behaviour Arturo can observe:
`mpz_probab_prime_p` 2/1/0 cutoffs, `mpq_set_si(0, d)` → 0/1, `mpfr_get_str` digit
counts and MPFR's double-rounding of ties, `mpfr_set_str` syntax (`@inf@`, `nan(...)`,
`0x...p`, `@` exponents), signed zeros, pow special cases (C99 Annex F).

## Testing

```sh
make test                  # everything below
make test64 test32 testportable   # mpz fuzz vs GMP (64-bit limbs, 32-bit limbs, pure C)
make testqf                # mpq fuzz vs GMP + mpfr fuzz vs MPFR, same three builds
make testcompat            # program written against <gmp.h> names
make testthresholds        # fuzz with tiny thresholds: Karatsuba, Toom-3 & divide-and-conquer
                           # radix conversion on almost every operation
make bench                 # timings vs GMP / MPFR
make bench-ruby            # timings vs Ruby's Integer (needs ruby)
make bench-small           # small numbers (1-3 limbs), the way Arturo uses them
```

Fuzzers run under ASan + UBSan and compare every result, ternary value and aliasing
variant against GMP 6.3 / MPFR 4.2.2 (needed only for testing: `GMP=/prefix`).

## Performance (vs GMP 6.3 / MPFR 4.2.2)

Ratio = PocketBignum's time / GMP's or MPFR's (lower is better), medians of 5 runs
on CI (Linux, 64-bit limbs; amd64: AMD EPYC, arm64: Neoverse-N2).

| | amd64 | arm64 |
|---|---|---|
| mpz add, mul, sqr, sqrt (1–2 limbs) | 0.8–1.1× | 0.4–1.0× |
| mpz mul, sqr (4–64 limbs) | 1.3–1.7× | 0.9–1.5× |
| mpz mul, sqr (128–4096 limbs) | 1.5–2.1× | 1.5–2.2× |
| mpz division (2n by n limbs) | 0.9–1.6× | 1.1–1.6× |
| mpz gcd | 0.6× (1 limb) – 1.8× | 1.0–2.7× |
| mpz powm, prime_p | 1.1–1.9× | 1.0–1.3× |
| mpz fac_ui | 1.1–3.2× | 0.7–2.8× |
| mpz get_str, set_str (base 10) | 0.9–1.9× | 1.1–1.9× |
| mpq (small & ~120-bit parts) add, mul, div, cmp | 0.8–1.1× | 0.4–1.2× |
| mpq get_d | 2.0–2.1× | 1.3–1.5× |
| mpfr 53-bit add, sub, mul, cmp, set_d, get_d, get_str, set_str | 0.4–1.2× | 0.6–1.4× |
| mpfr 53-bit div | 1.1× | 1.1× |
| mpfr 256-bit add, sub | 2.9–4.2× | 2.0–3.6× |
| mpfr 256-bit mul, div | 1.2–1.4× | 1.1× |
| mpfr pow, pow_z | 1.8–2.6× | 1.7–2.3× |
| **all 99 benchmarks (geometric mean)** | **1.23×** | **1.19×** |

`make bench` runs the same benchmarks locally.

## Known gaps / roadmap

- `mpfr_pow`: correct rounding via Ziv + atanh/Taylor series; needs double-limb kernels to reach MPFR speed
- Multi-limb float add/sub: no same-precision fast path yet
- Errors (division by zero, NaN to integer) call `PBN_ABORT` instead of raising SIGFPE
- Not implemented (unused by Arturo): `mpf_*`, `mpn_*`, random numbers, `mpz_import/export`, I/O streams, other MPFR transcendentals

See also the [open issues](https://github.com/pocket-libs/pocket-bignum/issues).
