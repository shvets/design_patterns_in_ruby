# observer.rb

# Define a one-to-many dependency between objects so that when one object
# changes state, all it's dependents are notified and updated automatically.

# 1. observer 

class Observer
  def initialize(name) 
    @name = name;
  end

  def update 
    puts "updated " + @name
  end
end

# 2. Observable, serves as a container for observers and takes care of notifying them

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

  def notify_observers() 
    @observers.clone.each { |observer| observer.update }
  end
end

# 3. test

class Tester
  include Observable
end

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")

tester = Tester.new

tester << observer1
tester << observer2
tester << observer3

tester.notify_observers

puts '----------'

tester >> observer3

tester.notify_observers
