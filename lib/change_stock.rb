class ChangeStock

  def initialize
    @changes = Hash.new(0)
  end

  def add(money, amount)
    @changes[money] = amount
  end
end
