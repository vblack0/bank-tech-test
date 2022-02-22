require_relative 'transaction'
require_relative 'statement'
require_relative 'error_methods'

class Account
  include ErrorMethods
  attr_reader :balance, :overdraft

  def initialize(balance=0, overdraft=0)
    @statement = Statement.new
    @balance = balance
    @overdraft = overdraft
  end

  def deposit(amount)
    begin
      check_amount(amount)

      @balance += amount
      add_to_statement(amount)
    rescue StandardError => error_message
      puts error_message
    end
  end

  def withdrawal(amount)
    begin
      check_amount(amount)
      check_funds(amount)

      @balance -= amount
      add_to_statement(-amount)
    rescue StandardError => error_message
      puts error_message
    end
  end

  def print_statement
    puts 'date || credit || debit || balance'
    puts @statement.display
  end

  private

  def add_to_statement(amount)
    transaction = Transaction.new(amount, @balance)
    @statement.add_transaction(transaction)
  end
end
