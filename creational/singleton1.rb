# singleton1.rb

# Ensure a class only has one instance and provide a global point of access to it.

class MySingleton
  @@instance = nil
 
  def self.instance()
    if @@instance == nil
      public_class_method :new # enables instance creation for this class

      @@instance = new unless @@instance

      private_class_method :new # disable instance creation for this class
    end

    @@instance
  end

  private_class_method :new # disable instance creation for this class
end


# MySingleton1.new # error

puts "singleton: #{MySingleton.instance.to_s}"
puts "singleton: #{MySingleton.instance.to_s}"
