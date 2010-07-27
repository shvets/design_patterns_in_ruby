# observer3.rb

# Implements Observer pattern with the help of ruby observer library

require 'observer'

# 1. observer

class Observer
  def initialize(name) 
    @name = name
  end

  def update(value)
    puts "updated " + @name + ". New value: " + value
  end
end

# 2. Observable is imported from 'observer' module

# 3. Implementation of the observer

class MyObservable
  include Observable

  def my_property= my_property
    @my_property = my_property
  
    changed # specific to ruby Observable library
    notify_observers(my_property)
  end
end

# 4. test

observer1 = Observer.new("n1")
observer2 = Observer.new("n2")
observer3 = Observer.new("n3")

observer4 = Proc.new {}

observer4.instance_eval do
  def update(value)
    puts "updated from lambda (update is :#{value})"
  end
end

my_observable = MyObservable.new

my_observable.add_observer observer1
my_observable.add_observer observer2
my_observable.add_observer observer3
my_observable.add_observer observer4

my_observable.my_property = 'red'

puts 'Deleting observer 3 ----------'

my_observable.delete_observer observer3

my_observable.my_property = 'green'
