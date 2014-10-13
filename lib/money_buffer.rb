class MoneyBuffer
  include Comparable

  def initialize(moneis={})
    @moneis = moneis
  end

  def kinds
    @moneis.keys
  end

  def quantity(kind)
    @moneis[kind]
  end

  def amount
    to_a.inject(&:+) || 0
  end

  def append(kind, quantity=1)
    new = @moneis.dup
    new[kind] = (new[kind] || 0) + quantity
    self.class.new(new)
  end

  def add(other)
    other.kinds.inject(self) do |acc, kind|
      acc.append(kind, other.quantity(kind))
    end
  end

  def subtract(other)
    new = @moneis.dup
    other.kinds.each do |kind|
      new[kind] -= other.quantity(kind)
    end
    self.class.new(new)
  end

  def exchange(amount, new=self.class.new, moneis=to_a)
    return nil if amount < 0
    return new if amount == 0
    unders = moneis.select {|m| m <= amount }
    return nil if (unders.inject(&:+) || 0) <= amount
    money = unders.shift
    exchange(amount - money, new.append(money), unders)
  end

  def to_a
    kinds.sort.reverse.inject([]) do |acc, k|
      acc + ([k] * @moneis[k])
    end
  end

  def <=>(other)
    if other.respond_to?(:amount)
      self.amount <=> other.amount
    else
      self.amount <=> other
    end
  end
end
