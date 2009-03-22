# flyweight.bsh

# Uses sharing to support large numbers of fine grained objects efficiently.

# 1. type interface

class Item 
  def process
  end
end 

# 2. type implementations

class MyItem1 < Item 
  def process
    puts "my item1 process"
  end
end

class MyItem2 < Item 
  def process
    puts "my item2 process"
  end
end

# 3. type factory; some kind of cache

class ItemCache 
  def initialize
    @item1 = MyItem1.new
    @item2 = MyItem2.new
  end

  def item(type) 
    if(type == 1) 
      return item1
    elsif(type == 2) 
      return item2
    end
  end
end

//4. test

cache = ItemCache.new

items = [ 
  cache.item(1), 
  cache.item(2),
  cache.item(2),
  cache.item(2),
  cache.item(1),
  cache.item(2),
  cache.item(1),
  cache.item(2)
]

for(item in items) do 
  item.process
end
