# builder2.rb

# This example uses ruby "method_missing" to implement so-called "magic method"

# 1. type builder interface

class ProductBuilder
  def build_part1; end

  def build_part2; end

  def build_part3; end

  def method_missing(name, *args)
    words = name.to_s.split('_')

    return super(name, *args) unless words.shift == 'build'

    words.each do |word|
      next if word == 'and'

      build_part1 if word == 'part1'
      build_part2 if word == 'part2'
      build_part3 if word == 'part3'
    end
  end

end

# 2. type builder implementations

class ComputerBuilder < ProductBuilder
  def build_part1
    puts 'Building part1: motherboard'
  end

  def build_part2
    puts 'Building part2: CPU'
  end

  def build_part3
    puts 'Building part3: display'
  end
end

class TableBuilder < ProductBuilder
  def build_part1
    puts 'Building part1: legs'
  end

  def build_part2
    puts 'Building part2: top'
  end

  def build_part3
    puts 'Building part3: mounting'
  end
end

# 3. director

class Director
  def construct_with_magic(builder)
    builder.build_part1_and_part2_and_part3
  end
end

# 4. test

director = Director.new

puts 'with magic:'
director.construct_with_magic(ComputerBuilder.new)
director.construct_with_magic(TableBuilder.new)
