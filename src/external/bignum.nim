## This module implements multi-precision arithmetic (big numbers). The
## following numeric types are supported:
## ::
##   - Int    signed integers
##   - Rat    rational numbers
##
## Procs are typically of the form:
##
## .. code-block:: nimrod
##
##   proc op(z, x, y: Int): Int   # similar for Rat
##
## and implement operations ``z = x op y`` with the result as receiver; if it is
## one of the operands it may be overwritten (and its memory reused). To enable
## chaining of operations, the result is also returned. Procs returning a
## result other than *Int* or *Rat* take one of the operands as the receiver.

import gmp

include bignum/int, bignum/rat
