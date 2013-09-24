class Programs
  attr_reader :list

  def initialize
    @list = []
  end

  def program program
    list << program
  end
end

class MyConfig
  def name name
    @name = name
  end

  def os os
    @os = os
  end

  def memory memory
    @memory = memory
  end

  def display_size display_size
    @display_size = display_size
  end

  def hard_drive hard_drive
    @hard_drive = hard_drive
  end

  def programs &block
    @programs ||= Programs.new

    @programs.instance_eval(&block)
  end

  def [] property
    instance_variable_get("@#{property}".to_sym)
  end

  def to_s
    "Config: #{@name}"
  end
end

module MyConfig::DSL
  def config(&block)
    my_config = MyConfig.new

    my_config.instance_eval(&block)

    my_config
  end
end

class MyClass
  include MyConfig::DSL

  def test_dsl
    mac_config = config do
      name :mac_config

      os "OSX 10.8.5"
      memory "8GB"
      display_size "27'"
      hard_drive "1TB"

      programs do
        program "Finder"
        program "Firefox"
        program "VLC"
      end
    end

    puts mac_config[:os]
    puts mac_config[:memory]

    puts mac_config[:programs].list
  end
end

# test

instance = MyClass.new

instance.test_dsl

