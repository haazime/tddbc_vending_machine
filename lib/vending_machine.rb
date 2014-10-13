require 'drink'
require 'money_collection'
require 'change_stock'

class VendingMachine
  AVAILABLE_MONEY = [10, 50, 100, 500, 1000].freeze
  DEFAULT_DRINK = COLA
  DEFAULT_DRINK_QUANTITY = 5

  attr_reader :drink_stock, :sales

  def initialize
    @drink_stock = Hash.new(0)
    @change_stock = MoneyCollection.new
    @deposite = MoneyCollection.new
    @pay_back = MoneyCollection.new
    @sales = 0
  end

  def add_drink_stock(drink, quantity)
    @drink_stock.merge!(drink => quantity)
  end

  def add_change_stock(money, quantity)
    @change_stock = @change_stock.append(money, quantity)
  end

  def serve_drink(drink=DEFAULT_DRINK)
    return self unless can_serve?(drink)

    new_change_stock = @change_stock.add(@deposite)
    pay_back = new_change_stock.exchange(@deposite.amount - drink.price)
    return self unless pay_back

    @drink_stock[drink] -= 1
    @sales += drink.price
    @change_stock = new_change_stock
    @deposite = pay_back
  end

  def available_drinks
    @drink_stock.keys.select {|d| can_serve?(d) }
  end

  def can_serve?(drink=DEFAULT_DRINK)
    @deposite >= drink.price &&
      @drink_stock[drink] > 0
  end

  def receive_money(money)
    if AVAILABLE_MONEY.include?(money)
      @deposite = @deposite.append(money)
    else
      @pay_back = @pay_back.append(money)
    end
  end

  def deposite
    @deposite.amount
  end

  def pay_back
    pay_back = @pay_back.add(@deposite)
    @deposite = MoneyCollection.new
    @pay_back = MoneyCollection.new
    pay_back.to_a
  end
end
