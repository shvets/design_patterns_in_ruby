# http://www.skorks.com/2011/02/a-unit-testing-framework-in-44-lines-of-ruby/

module Kernel
  def describe(description, &block)
    tests = Dsl.new.parse(description, block)
    tests.execute
  end
end

class Object
  def should
    self
  end
end

class Dsl
  def initialize
    @tests = {}
  end

  def parse(description, block)
    self.instance_eval(&block)
    Executor.new(description, @tests)
  end

  def it(description, &block)
    @tests[description] = block
  end
end

class Executor
  def initialize(description, tests)
    @description = description
    @tests = tests
    @success_count = 0
    @failure_count = 0
  end

  def execute
    puts @description
    @tests.each_pair do |name, block|
      print " - #{name}"
      result = self.instance_eval(&block)
      result ? @success_count += 1 : @failure_count += 1
      puts result ? ' SUCCESS' : ' FAILURE'
    end
    summary
  end

  def summary
    puts "\n#{@tests.keys.size} tests, #{@success_count} success, #{@failure_count} failure"
  end
end

describe 'some test' do
  it 'should be true' do
    true.should == true
  end

  it 'should show that an expression can be true' do
    (5 == 5).should == true
  end

  it 'should be failing deliberately' do
    5.should == 6
  end
end