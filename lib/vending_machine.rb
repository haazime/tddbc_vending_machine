class VendingMachine

  def initialize
    @money_collection = []
  end

  def receive(money)
    return money if [1, 5, 5000, 10000].include?(money)
    @money_collection << money
  end

  def pay_back
    @money_collection.inject(&:+)
  end
end
