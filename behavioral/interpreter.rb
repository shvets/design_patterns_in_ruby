# interpreter.rb

# Given a language, defines a representation for it's grammar along with an interpreter
# that uses the representation to interpret sentences in the language

# 1. context

class NamesInterpreterContext
  def initialize
    @names = []

    @names << 'monitor'
    @names << 'keyboard'
    @names << 'mouse'
    @names << 'system-block'
  end

  attr_reader :names
end

class NamesInterpreter
  def initialize(context)
    @context = context
  end

  # expression syntax:
  # show names
  def interpret(expression)
    result = ''

    tokens = expression.chomp.scan(/\(|\)|[\w.*]+/) # extract each word

    i = 0
    while i <= tokens.size do
      token = tokens[i]

      unless token.nil?
        if token == 'show'
          token = tokens[i + 1]
          i += 1

          result = if token == 'names'
                     result + @context.names.join(', ')
                   else
                     "#{result}error!"
                   end
        else
          result += 'error!'
        end
      end

      i += 1
    end

    result
  end
end

# test

interpreter = NamesInterpreter.new(NamesInterpreterContext.new)

puts "interpreting show names: #{interpreter.interpret('show names')}"
