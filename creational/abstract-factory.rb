# abstract-factory.rb

# Provides an interface for creationg families of related or dependent objects without specifying
# their concrete class.
#
# Provides one level of interface higher than the factory pattern. It is used to return one
# of several factories.

# 1. common interface for type and it's specializations

class Alive 
  def live
  end
end

class Plant < Alive
end

class Animal < Alive
end

# 2. implementations of specializations

class Roze < Plant 
  def live
    puts "roze" 
  end
end

class Elephant < Animal 
  def live
    puts "elephant"
  end
end

# 3. interface for factory (abstract factory)

class AliveFactory 
  def create_alive
  end
end

# 4. different factories implementations

class PlantFactory < AliveFactory 
  def create_alive
    Roze.new
  end
end

class AnimalFactory < AliveFactory 
  def create_alive
    Elephant.new
  end
end

class DynamicAliveFactory 
  def initialize(alive_class)
    @alive_class = alive_class
  end

  def create_alive
    @alive_class.new 
  end
end

# 5. factories manager (optional)

class AliveManager 
  def create_alive_factory(type)
    if(type == :plant) 
      PlantFactory.new
    elsif(type == :animal) 
      AnimalFactory.new
    end
  end 
end

# 6. test

alive_manager = AliveManager.new

alive_factory1 = alive_manager.create_alive_factory(:plant)
alive_factory2 = alive_manager.create_alive_factory(:animal)
alive_factory3 = DynamicAliveFactory.new(Roze)

alive1 = alive_factory1.create_alive
alive2 = alive_factory2.create_alive 
alive3 = alive_factory3.create_alive

alive1.live
alive2.live
alive3.live
