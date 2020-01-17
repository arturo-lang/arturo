/*****************************************************************
 * Arturo :VM
 * 
 * Programming Language + Compiler
 * (c) 2019-2020 Yanis Zafirópulos (aka Dr.Kameleon)
 *
 * @file: src/include/arturo.h
 *****************************************************************/

#ifndef __ARTURO_H__
#define __ARTURO_H__

/**************************************
  Main configuration
 **************************************/

#include "config/config.h"
#include "config/types.h"

/**************************************
  Global includes
 **************************************/

#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/time.h>
#include <sys/utsname.h>
#include <unistd.h>

// 3rd party libraries

#include <gmp.h>

// Vendor

#include "vendor/murmur3/murmur3.h"

// Helpers

#include "helpers/benchmark.h"
#include "helpers/builtin.h"
#include "helpers/debug.h"
#include "helpers/endianess.h"
#include "helpers/hash.h"
#include "helpers/i32tos.h"
#include "helpers/inlined.h"
#include "helpers/lowmath.h"
#include "helpers/memory.h"
#include "helpers/powersoftwo.h"
#include "helpers/prints.h"
#include "helpers/stoi32.h"

// Core

#include "core/string.h"
#include "core/array.h"
#include "core/bignum.h"
#include "core/dict.h"

// Repl

#include "repl/repl.h"

// VM

#include "vm/bytecode.h"
#include "vm/callframe.h"
#include "vm/env.h"
#include "vm/func.h"
#include "vm/generator.h"
#include "vm/objfile.h"
#include "vm/opcodes.h"
#include "vm/optimizer.h"
#include "vm/panic.h"
#include "vm/value.h"
#include "vm/vm.h"

/**************************************
  Super-globals
 **************************************/

ByteArray*  BCode;
ValueArray* BData;

#endif
