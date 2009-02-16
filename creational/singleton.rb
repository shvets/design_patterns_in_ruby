# singleton.rb

# Ensure a class only has one instance and provide a global point of access to it.

# Note: try to avoid singleton (see singleton-corrected.rb). 
# Major question: how to test/mock the singleton?

class MySingleton1
  @@instance = nil
 
  def self.instance()
    if @@instance == nil
      public_class_method :new # enables instance creation for this class

      @@instance = new() unless @@instance

      private_class_method :new # disable instance creation for this class
    end

    @@instance
  end

  private_class_method :new # disable instance creation for this class
end

require 'singleton'

class MySingleton2
  include Singleton
end

# MySingleton1.new # error

puts "singleton1: " + MySingleton1.instance.to_s
puts "singleton1: " + MySingleton1.instance.to_s

puts "singleton2: " + MySingleton2.instance.to_s
puts "singleton2: " + MySingleton2.instance.to_s