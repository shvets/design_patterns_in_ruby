# command1.rb

# Encapsulate a request as an object, thereby letting you to parametrize
# clients with different requests, queue or log requests, and support
# undoable operations.

# 1. command abstraction

class Command
  def execute()
  end
end

# 2. command implementations

class MyCommand1 < Command
  def execute
    puts 'command1'
  end
end

class MyCommand2 < Command
  def execute
    puts 'command2'
  end
end

class MyCommand3 < Command
  def execute
    puts 'command3'
  end
end


# 3. test

command1 = MyCommand1.new
command2 = MyCommand2.new
command3 = MyCommand3.new

command1.execute
command2.execute
command3.execute


