# builder.rb

# Separates the construction of a complex object from its representation so that the same
# construction process can create different representations.

# 1. type builder interface

class ProductBuilder 
  def build_part1
  end

  def build_part2
  end

  def build_part3
  end
end

# 2. type builder implementations

class ComputerBuilder < ProductBuilder 
  def build_part1
    puts "Building part1: motherboard"
  end

  def build_part2
    puts "Building part2: CPU"
  end

  def build_part3
    puts "Building part3: display"
  end
end

class TableBuilder < ProductBuilder 
  def build_part1
    puts "Building part1: legs"
  end

  def build_part2
    puts "Building part2: top"
  end

  def build_part3
    puts "Building part3: mounting"
  end
end

# 3. director

class Director 
  def construct(builder) 
    builder.build_part1;
    builder.build_part2;
    builder.build_part3;
  end
end

# 4. test

director = Director.new;

director.construct(ComputerBuilder.new);

director.construct(TableBuilder.new);
