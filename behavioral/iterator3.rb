# iterator3.rb

# Iterator with typical ruby implementation

# 1. iterator implementation

class MyEnumerable
  def for_each(array)
    i = 0
    while i < array.length
      yield(array[i])
      i += 1
    end
  end
end

# 2. test

array = %w[e1 e2 e3 e4]

my_enumerable = MyEnumerable.new

my_enumerable.for_each(array) do |e|
  puts e
end

