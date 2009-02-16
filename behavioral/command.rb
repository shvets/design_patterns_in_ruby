# command.rb

# Encapsulate a request as an object, thereby letting you parametrize
# clients with different requests, queue or log requests, and support
# undoable operations.

class Command
  def execute()
  end
end

class MyCommand1 < Command
  def execute
    puts "command1"
  end
end

class MyCommand2 < Command
  def execute
     puts "command2"
  end
end

class MyCommand3 < Command
  def execute
     puts "command3"
  end
end

# test

commands = [ MyCommand1.new, MyCommand2.new, MyCommand3.new, MyCommand2.new, MyCommand1.new ]

commands.each {|command| command.execute}

puts "-------"

class Test
  def initialize(command=nil, &code)
    @command = command
    @code = code
  end

  def operation()
    @command.execute if @command != nil
    @code.call if @code != nil
  end
end

test1 = Test.new(MyCommand1.new)

test1.operation()

test2 = Test.new() {
  puts "hello!"
}

test2.operation()
