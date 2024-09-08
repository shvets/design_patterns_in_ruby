# dci3.rb
# Data-Context-Interaction pattern example based on account transfer money

# 1. Data

class Account
  attr_accessor :balance

  def initialize balance
    @balance = balance
  end

  def decrease_balance(amount)
    @balance -= amount
  end

  def increase_balance(amount)
    @balance += amount
  end

  def update_log(message, amount)
    puts "#{message} : #{amount}"
  end
end

# 2. Helper mixins to support context

module ContextAccessor
  def context
    Thread.current[:context]
  end
end

module Context
  include ContextAccessor

  def context=(ctx)
    Thread.current[:context] = ctx
  end

  def in_context
    old_context = self.context
    self.context = self

    res = yield

    self.context = old_context

    res
  end
end

# 3. Role(s)

module SourceAccount
  include ContextAccessor

  def transfer_out amount
    raise 'Insufficient funds' if balance < amount

    decrease_balance amount

    context.destination_account.transfer_in amount

    update_log 'Transferred out', amount
  end
end

module DestinationAccount
  include ContextAccessor

  def transfer_in amount
    increase_balance amount

    update_log 'Transferred in', amount
  end
end

# 4. Context
# The place where role is assigned to data/model.
# We do it dynamically at run-time, on object, not class declaration level.

class TransferringMoney
  include Context

  attr_reader :source_account, :destination_account

  def initialize source_account, destination_account
    @source_account = source_account.extend SourceAccount
    @destination_account = destination_account.extend DestinationAccount
  end

  def transfer amount
    in_context do
      source_account.transfer_out amount
    end
  end
end

# 5. Actual Program

class Interaction
  attr_reader :source, :destination

  def initialize
    @source = Account.new 57
    @destination = Account.new 124
  end

  def interact
    context = TransferringMoney.new(source, destination)

    puts 'Before:'
    puts "Source balance: #{source.balance}"
    puts "Destination balance: #{destination.balance}"

    context.transfer 12

    puts 'After:'
    puts "Source balance: #{source.balance}"
    puts "Destination balance: #{destination.balance}"
  end
end

interaction = Interaction.new
interaction.interact




