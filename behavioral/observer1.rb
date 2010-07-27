# observer1.rb

# Define a one-to-many dependency between objects so that when one object
# changes state, all it's dependents are notified and updated automatically.

# 1. observer 

class Observer
  def initialize(name) 
    @name = name
  end

  def update(value)
    puts "updated " + @name + ". New value: " + value
  end
end

# 2. Observable (serves as a container for observers and takes care of notifying them)

module Observable 
  def initialize
    @observers = []
  end

  def <<(observer) 
    @observers << observer
  end
  
  def >>(observer) 
    @observers.delete(observer)
  end

  protected
  
  def notify_observers(value)
    @observers.clone.each {|observer| observer.update(value) }
  end
end

# 3. Implementation of the observer
class MyObservable 
  include Observable
  
  attr_reader :my_property
  
  def my_property=(my_property)
    @my_property = my_property
    
    notify_observers(my_property)
  end
end

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")

my_observable = MyObservable.new

my_observable << observer1
my_observable << observer2
my_observable << observer3

my_observable.my_property = 'red'

puts 'Deleting observer 3 ----------'

my_observable >> observer3

my_observable.my_property = 'green'
