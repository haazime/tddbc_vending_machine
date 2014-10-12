class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_STOCK = { name: 'コーラ', price: 120, quantity: 5 }

  attr_reader :sales

  def initialize(stock=DEFAULT_STOCK)
    @stock = stock.dup
    @charge = 0
    @sales = 0
  end

  def serve_drink
    return self unless can_serve?
    @stock[:quantity] -= 1
    @charge -= @stock[:price]
    @sales += @stock[:price]
  end

  def can_serve?
    @charge >= @stock[:price] && @stock[:quantity] > 0
  end

  def drinks
    @stock
  end

  def receive_money(money)
    return money unless AVAILABLE_MONEY.include?(money)
    @charge += money
  end

  def pay_back
    @charge
  end
end
