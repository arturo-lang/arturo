class Array
  def quick_sort
    return self if length <= 1
    pivot = self[0]
    less, greatereq = self[1..-1].partition { |x| x < pivot }
    less.quick_sort + [pivot] + greatereq.quick_sort
  end
end

list = (1..50000).to_a.shuffle
list = list.quick_sort

list.each{|x|
	puts x
}