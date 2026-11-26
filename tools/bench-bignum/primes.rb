require "openssl"   # (Ruby has no built-in primality test for big integers)
c = 0
(1..200000).each { |k| c += 1 if OpenSSL::BN.new(2**100 + k).prime? }
puts c
