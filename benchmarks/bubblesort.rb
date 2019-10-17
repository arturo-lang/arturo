class Array
  def bubblesort!
    length.times do |j|
      for i in 1...(length - j)
        if self[i] < self[i - 1]
          self[i], self[i - 1] = self[i - 1], self[i]
        end
      end
    end
    self
  end
end

list = (1..2000).to_a.shuffle
list.bubblesort!

list.each{|x|
	puts x
}