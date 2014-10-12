class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_STOCK = { name: 'コーラ', price: 120, quantity: 5 }

  attr_reader :sales

  def initialize(stock=DEFAULT_STOCK)
    @stock = stock.dup
    @amount = 0
    @sales = 0
  end

  def serve_drink
    return self unless can_buy?
    @stock[:quantity] -= 1
    @amount -= @stock[:price]
    @sales += @stock[:price]
  end

  def can_buy?
    @amount >= @stock[:price] && @stock[:quantity] > 0
  end

  def drinks
    @stock
  end

  def receive_money(money)
    return money if available_money?(money)
    @amount += money
  end

  def pay_back
    @amount
  end

private

  def available_money?(money)
    !AVAILABLE_MONEY.include?(money)
  end
end
