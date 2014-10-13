require 'spec_helper'

RSpec.describe MoneyBuffer do
  describe "#add" do
    it do
      a = described_class.new
      b = described_class.new(10 => 2)
      expect(a.add(b)).to eq(described_class.new(10 => 2))
    end

    it do
      a = described_class.new(10 => 1)
      b = described_class.new(10 => 2)
      expect(a.add(b)).to eq(described_class.new(10 => 3))
    end

    it do
      a = described_class.new(1000 => 10, 500 => 3, 100 => 7, 50 => 2, 10 => 8)
      b = described_class.new(100 => 1, 50 => 1, 10 => 5)
      expect(a.add(b)).to eq(described_class.new(1000 => 10, 500 => 3, 100 => 8, 50 => 3, 10 => 13))
    end
  end

  describe "#exchange" do
    it do
      mc = described_class.new(10 => 1)
      expect(mc.exchange(0)).to eq(described_class.new)
    end

    it do
      mc = described_class.new
      expect(mc.exchange(0)).to eq(described_class.new)
    end

    it do
      mc = described_class.new(10 => 5)
      expect(mc.exchange(10)).to eq(described_class.new(10 => 1))
    end

    it do
      mc = described_class.new(500 => 2, 100 => 3, 10 => 5)
      expect(mc.exchange(30)).to eq(described_class.new(10 => 3))
    end

    it do
      mc = described_class.new(1000 => 10, 100 => 5, 50 => 10, 10 => 10)
      expect(mc.exchange(500)).to eq(described_class.new(100 => 5))
    end

    it do
      mc = described_class.new(1000 => 2, 100 => 3, 50 => 2, 10 => 20)
      expect(mc.exchange(500)).to eq(described_class.new(100 => 3, 50 => 2, 10 => 10))
    end

    it do
      mc = described_class.new(1000 => 2, 100 => 3, 50 => 1, 10 => 20)
      expect(mc.exchange(500)).to eq(described_class.new(100 => 3, 50 => 1, 10 => 15))
    end

    it do
      mc = described_class.new(1000 => 10, 500 => 5)
      expect(mc.exchange(100)).to be nil
    end

    it do
      mc = described_class.new(1000 => 10, 500 => 5, 10 => 9)
      expect(mc.exchange(100)).to be nil
    end
  end

  describe "#subtract" do
    it do
      a = described_class.new(10 => 5)
      b = described_class.new
      expect(a.subtract(b)).to eq(described_class.new(10 => 5))
    end

    it do
      a = described_class.new(10 => 5)
      b = described_class.new(10 => 3)
      expect(a.subtract(b)).to eq(described_class.new(10 => 2))
    end

    it do
      a = described_class.new(1000 => 10, 500 => 3, 50 => 2, 10 => 5)
      b = described_class.new(10 => 3, 50 => 1)
      expect(a.subtract(b)).to eq(described_class.new(1000 => 10, 500 => 3, 50 => 1, 10 => 2))
    end

    it do
      a = described_class.new(1000 => 10, 500 => 3, 100 => 1, 50 => 2, 10 => 5)
      b = described_class.new(100 => 1, 50 => 1, 10 => 5)
      expect(a.subtract(b)).to eq(described_class.new(1000 => 10, 500 => 3, 50 => 1))
    end
  end

  describe "#to_a" do
    it do
      mc = described_class.new(10 => 1)
      expect(mc.to_a).to eq([10])
    end

    it do
      mc = described_class.new(
        10 => 3,
        50 => 2,
        500 => 4,
        1000 => 3
      )
      expect(mc.to_a).to eq([1000, 1000, 1000, 500, 500, 500, 500, 50, 50, 10, 10, 10])
    end
  end

  describe "#<=>" do
    context "with Fixnum" do
      it do
        mc = described_class.new(100 => 1)

        expect(mc == 100).to be true
        expect(mc > 100).to be false
        expect(mc < 100).to be false
        expect(mc >= 100).to be true
        expect(mc <= 100).to be true
      end
    end

    context "with self.class" do
      it do
        a = described_class.new(100 => 1)
        b = described_class.new(500 => 1, 10 => 3)

        expect(a == b).to be false
        expect(a > b).to be false
        expect(a < b).to be true
        expect(a >= b).to be false
        expect(a <= b).to be true
      end
    end
  end
end
