/* Single compilation unit for PocketBignum.
 * Build this file once and put compat/ on the include path to replace GMP + MPFR,
 * e.g. from Nim:  {.compile: "pocketbignum.c".}  {.passC: "-I<path>/compat".}  */
#define PBN_IMPLEMENTATION
#include "pocketbignum.h"
