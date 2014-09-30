# from https://gist.github.com/petrachi/637f9367404708ec341a

A = ->(s){ s << "a" }
B = ->(s){ s << "b" }
C = ->(s){ s << "c" }

str = ""


class Object
  PIPED = ->(*args, arg){ arg.is_a?(Proc) ? arg[PIPED[*args]] : arg }

  def | *args
    PIPED.curry[self, *args]
  end
end

puts str | A | B | C
