# singleton2.rb

# This example does the same with the help of 'singleton' library.

require 'singleton'

class MySingleton
  include Singleton
end

puts "singleton: #{MySingleton.instance}"
puts "singleton: #{MySingleton.instance}"
