Drink = Struct.new(:name, :price)

COLA    = Drink.new('コーラ', 120)
REDBULL = Drink.new('レッドブル', 200)
WATER   = Drink.new('水', 100)

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_DRINK = COLA
  DEFAULT_DRINK_QUANTITY = 5

  attr_reader :deposite, :drink_stock, :sales

  def initialize
    @drink_stock = Hash.new(0)
    @deposite = 0
    @pay_back = 0
    @sales = 0
  end

  def add_drink_stock(drink, quantity)
    @drink_stock.merge!(drink => quantity)
  end

  def serve_drink(drink=DEFAULT_DRINK)
    return self unless can_serve?(drink)
    @drink_stock[drink] -= 1
    @deposite -= drink.price
    @sales += drink.price
  end

  def available_drinks
    @drink_stock.keys.select {|d| can_serve?(d) }
  end

  def can_serve?(drink=DEFAULT_DRINK)
    @deposite >= drink.price && @drink_stock[drink] > 0
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
