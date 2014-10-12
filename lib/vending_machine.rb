Drink = Struct.new(:name, :price)

COLA    = Drink.new('コーラ', 120)
REDBULL = Drink.new('レッドブル', 200)
WATER   = Drink.new('水', 100)

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_DRINK = COLA
  DEFAULT_DRINK_QUANTITY = 5

  attr_reader :deposite, :stock, :sales

  def initialize
    @stock = Hash.new(0)
    @deposite = 0
    @pay_back = 0
    @sales = 0
  end

  def add_stock(drink, quantity)
    @stock.merge!(drink => quantity)
  end

  def serve_drink(drink=DEFAULT_DRINK)
    return self unless can_serve?(drink)
    @stock[drink] -= 1
    @deposite -= drink.price
    @sales += drink.price
  end

  def available_drinks
    @stock.keys.select {|d| can_serve?(d) }
  end

  def can_serve?(drink=DEFAULT_DRINK)
    @deposite >= drink.price && @stock[drink] > 0
  end

  def receive_money(money)
    if AVAILABLE_MONEY.include?(money)
      @deposite += money
    else
      @pay_back += money
    end
  end

  def pay_back
    amount = @deposite + @pay_back
    @deposite = 0
    amount
  end
end
