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
  def initialize(&creation_block)
    @creation_block = creation_block
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

    @subject || (@subject = Item.new)
  end
end


# test

item1 = ItemProxy.subject

item2 = ItemProxy.subject

item3 = ItemProxy.subject

item4 = ItemProxy.new { Item.new }.class.subject

item1.operation
item2.operation
item3.operation
item4.operation
