# observer.rb

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

  protected

  def notify_observers(value) 
    @observers.clone.each do |observer| 
      observer.update(value) if observer.kind_of? Observer
      observer.call(value)  if observer.kind_of? Proc
    end
  end
end

# 3. test

class Tester
  include Observable

  def property= property
    @property = property

    notify_observers(property)
  end
end

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")
observer4 = lambda { |value| puts "updated from lambda (update is :#{value})" }

tester = Tester.new

tester << observer1
tester << observer2
tester << observer3
tester << observer4

tester.property = 'red'

puts '----------'

tester >> observer3

tester.property = 'green'
