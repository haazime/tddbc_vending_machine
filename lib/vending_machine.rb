require 'drink'

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze

  def initialize
    @stock = { name: 'コーラ', price: 120, quantity: 5 }
    @money_collection = []
  end

  def drinks
    @stock
  end

  def receive(money)
    return money if available_money?(money)
    @money_collection << money
  end

  def pay_back
    @money_collection.inject(&:+)
  end

private

  def available_money?(money)
    !AVAILABLE_MONEY.include?(money)
  end
end
