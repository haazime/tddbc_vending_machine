Drink = Struct.new(:name, :price)

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_DRINK = Drink.new('コーラ', 120)
  DEFAULT_DRINK_QUANTITY = 5

  attr_reader :stock, :sales

  def initialize(drink=DEFAULT_DRINK, quantity=DEFAULT_DRINK_QUANTITY)
    @stock = {}.merge(drink => quantity)
    @charge = 0
    @sales = 0
  end

  def serve_drink(drink=DEFAULT_DRINK)
    return self unless can_serve?(drink)
    @stock[drink] -= 1
    @charge -= drink.price
    @sales += drink.price
  end

  def can_serve?(drink=DEFAULT_DRINK)
    @charge >= drink.price && @stock[drink] > 0
  end

  def receive_money(money)
    return money unless AVAILABLE_MONEY.include?(money)
    @charge += money
  end

  def pay_back
    @charge
  end
end
