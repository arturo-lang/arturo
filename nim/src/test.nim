import algorithm, math, os, parseutils, sequtils, strutils, tables
import utils

type
    Obj = ref object
        s: string
        v: int

var arr1: seq[TableRef[string,int]]
var arr2: seq[int]
var arr3: seq[Obj]

var tbl: OrderedTable[string,int]

var lim = 5_000_000

benchmark "initTable":
    for i in 1..lim:
        discard newTable[string,int]()

benchmark "add(initTable)":
    for i in 1..lim:
        arr1.add(newTable([("one",i)]))

benchmark "arr.pop":
    for i in 1..lim:
        discard arr1.pop()

benchmark "add(int)":
    for i in 1..lim:
        arr2.add(i)

benchmark "pop(int)":
    for i in 1..lim:
        discard arr2.pop()

benchmark "add(obj)":
    for i in 1..lim:
        arr3.add(Obj(s:"i",v:i))

benchmark "pop(obj)":
    for i in 1..lim:
        discard arr3.pop()

# tbl = initOrderedTable[string,int]()

# benchmark "tbl(add)":
#     for i in 1..lim:
#         tbl.add("one",i)

import math                   # for gcd and mod
import bitops                 # for countTrailingZeroBits
import strutils, typetraits   # for number input
import times, os              # for timing code execution
 
proc addmod*[T: SomeInteger](a, b, modulus: T): T =
  ## Modular addition
  let a_m = if a < modulus: a else: a mod modulus
  if b == 0.T: return a_m
  let b_m = if b < modulus: b else: b mod modulus
 
  # Avoid doing a + b that could overflow here
  let b_from_m = modulus - b_m
  if a_m >= b_from_m: return a_m - b_from_m
  return a_m + b_m  # safe to add here; a + b < modulus
 
proc mulmod*[T: SomeInteger](a, b, modulus: T): T =
  ## Modular multiplication
  var a_m = if a < modulus: a else: a mod modulus
  var b_m = if b < modulus: b else: b mod modulus
  if b_m > a_m: swap(a_m, b_m)
  while b_m > 0.T:
    if (b_m and 1) == 1: result = addmod(result, a_m, modulus)
    a_m = (a_m shl 1) - (if a_m >= (modulus - a_m): modulus else: 0)
    b_m = b_m shr 1
 
proc expmod*[T: SomeInteger](base, exponent, modulus: T): T =
  ## Modular exponentiation
  result = 1 # (exp 0 = 1)
  var (e, b) = (exponent, base)
  while e > 0.T:
    if (e and 1) == 1: result = mulmod(result, b, modulus)
    e = e shr 1
    b = mulmod(b, b, modulus)
 
# Returns true if +self+ passes Miller-Rabin Test on witnesses +b+
proc miller_rabin_test[T: SomeInteger](num: T, witnesses: seq[uint64]): bool =
  var d = num - 1
  let (neg_one_mod, n) = (d, d)
  d = d shr countTrailingZeroBits(d) # suck out factors of 2 from d
  for b in witnesses:                # do M-R test with each witness base
    if b.T mod num == 0: continue    # **skip base if a multiple of input**
    var s = d
    var y = expmod(b.T, d, num)
    while s != n and y != 1 and y != neg_one_mod:
      y = mulmod(y, y, num)
      s = s shl 1
    if y != neg_one_mod and (s and 1) != 1: return false
  true
 
proc selectWitnesses[T: SomeInteger](num: T): seq[uint64] =
  ## Best known deterministic witnesses for given range and number of bases
  ## https://miller-rabin.appspot.com/
  ## https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test
  if num < 341_531u:
    result = @[9345883071009581737u64]
  elif num < 1_050_535_501u:
    result = @[336781006125u64, 9639812373923155u64]
  elif num < 350_269_456_337u:
    result = @[4230279247111683200u64, 14694767155120705706u64, 16641139526367750375u64]
  elif num < 55_245_642_489_451u:
    result = @[2u64, 141889084524735u64, 1199124725622454117u64, 11096072698276303650u64]
  elif num < 7_999_252_175_582_851u:
    result = @[2u64, 4130806001517u64, 149795463772692060u64, 186635894390467037u64, 3967304179347715805u64]
  elif num < 585_226_005_592_931_977u:
    result = @[2u64, 123635709730000u64, 9233062284813009u64, 43835965440333360u64, 761179012939631437u64, 1263739024124850375u64]
  elif num.uint64 < 18_446_744_073_709_551_615u64:
    result = @[2u64, 325, 9375, 28178, 450775, 9780504, 1795265022]  
  else:
    result = @[2u64, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
 
proc primemr*[T: SomeInteger](n: T): bool =
  let primes = @[2u64, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
  if n <= primes[^1].T: return (n in primes) # for n <= primes.last
  let modp47 = 614889782588491410u     # => primes.product, largest < 2^64
  if gcd(n, modp47) != 1: return false # eliminates 86.2% of all integers
  let witnesses = selectWitnesses(n)
  miller_rabin_test(n, witnesses)
 
echo "\nprimemr?"
echo("n = ", 1645333507u)
var te = epochTime()
echo primemr 1645333507u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 2147483647u)
te = epochTime()
echo primemr 2147483647u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 844674407370955389u)
te = epochTime()
echo primemr 844674407370955389u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 1844674407370954349u)
te = epochTime()
echo primemr 1844674407370954349u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 1844674407370954351u)
te = epochTime()
echo primemr 1844674407370954351u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 9223372036854775783u)
te = epochTime()
echo primemr 9223372036854775783u
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 9241386435364257883u64)
te = epochTime()
echo primemr 9241386435364257883u64
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
echo("n = ", 18446744073709551533u64, ", is largest prime < 2^64")
te = epochTime()
echo 18446744073709551533u64.primemr
echo (epochTime()-te).formatFloat(ffDecimal, 6)
 
echo "\nprimemr?"
let num = 5_000_000u        # => 348_513 primes
var primes: seq[uint] = @[]
echo("find primes < ", num)
te = epochTime()
for n in 0u..num: 
  if n.primemr: primes.add(n)
  stdout.write("\r",((float64(n) / float64(num))*100).formatFloat(ffDecimal, 1), "%")
echo("\nnumber of primes < ",num, " are ", primes.len)
echo (epochTime()-te).formatFloat(ffDecimal, 6)