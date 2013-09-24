# 1. This module has method that can convert list of local variables inside binding into hash

module LocalsToHash
  def locals_to_hash binding, exclusions
    vars = binding.eval("local_variables") - Kernel.local_variables - exclusions.collect(&:to_sym)

    vars.inject({}) do |hash, name|
      hash[name] = eval(name.to_s, binding)
      hash
    end
  end

end

# 2. New class

class MyClass
  include LocalsToHash

  def test
    r1 = 3
    r4 = 4

    hash = locals_to_hash binding, %w(hash)

    puts hash
  end
end

# Test it

instance = MyClass.new

instance.test
