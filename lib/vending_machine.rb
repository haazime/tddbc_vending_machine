require 'yen'

class VendingMachine

  def initialize
    @money_collection = []
  end

  def receive(money)
    @money_collection << money
  end

  def pay_back
    @money_collection
      .inject(Yen.new(0)) {|acc, m| acc + m }
      .to_i
  end
end
