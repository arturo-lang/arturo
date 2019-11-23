maxLimit = 5000

class Fibber
  attr_accessor :hash
  def initialize
    @hash = {}
  end
  def memo_fib(n)
    for number in 0..n
      if number < 2
        @hash[number] = number
      else
        @hash[number] = @hash[number-1] + @hash[number-2]
      end
    end
    @hash[n]
  end
end

fibber = Fibber.new

(1..maxLimit+1).each{|n|
  puts fibber.memo_fib(n)
}