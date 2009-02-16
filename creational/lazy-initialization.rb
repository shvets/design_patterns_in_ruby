# lazy-initialization.rb

# Lazy initialization is the tactic of delaying the creation of an object, 
# the calculation of a value, or some other expensive process until 
# the first time it is needed.

class Item
  def operation
    puts "executing operation..."
  end
end

class ItemProxy < Item
  def self.creational_block(&creation_block)
    @@creation_block = creation_block
  end

  def operation
    @subject.operation
  end

  def self.subject
    if (@subject == nil)
      puts "Creating new instance"
    else
      puts "Using existing instance"
    end

    @subject || (@subject = @@creation_block.call)
  end
end


# test

ItemProxy.creational_block { Item.new }

item1 = ItemProxy.subject

item2 = ItemProxy.subject

item3 = ItemProxy.subject

item1.operation
item2.operation
item3.operation
