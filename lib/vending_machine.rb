class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_STOCK = { name: 'コーラ', price: 120, quantity: 5 }

  def initialize(stock=DEFAULT_STOCK)
    @stock = stock
    @money_collection = []
  end

  def can_buy?
    amount >= @stock[:price] && @stock[:quantity] > 0
  end

  def drinks
    @stock
  end

  def receive_money(money)
    return money if available_money?(money)
    @money_collection << money
  end

  def amount
    @money_collection.inject(&:+) || 0
  end

  def pay_back
    amount
  end

private

  def available_money?(money)
    !AVAILABLE_MONEY.include?(money)
  end
end
