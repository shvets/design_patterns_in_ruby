# singleton2.rb

# This example does the same qith the help of 'singleton' library.

require 'singleton'

class MySingleton
  include Singleton
end

puts "singleton: " + MySingleton.instance.to_s
puts "singleton: " + MySingleton.instance.to_s