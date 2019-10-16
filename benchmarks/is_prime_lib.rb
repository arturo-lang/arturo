require 'prime'

maxLimit = 5000

(0..maxLimit).each{|n|
	puts Prime.prime?(n)
}