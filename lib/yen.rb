class Yen

  def initialize(amount)
    @amount = amount
  end

  def +(other)
    self.class.new(self.to_i + other.to_i)
  end

  def to_i
    @amount
  end
end
