require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#payback" do
    subject do
      Array(money).each {|m| machine.receive(m) }
      machine.pay_back
    end

    context "10円を投入した場合" do
      let(:money) do
        Yen.new(10)
      end

      it { is_expected.to eq(10) }
    end

    context "100円1枚と10円5枚を投入した場合" do
      let(:money) do
        [
          Yen.new(100),
          Yen.new(10), Yen.new(10), Yen.new(10), Yen.new(10), Yen.new(10)
        ]
      end

      it { is_expected.to eq(150) }
    end

    context "1000円1枚と10円3枚を投入した場合" do
      let(:money) do
        [
          Yen.new(1000),
          Yen.new(10), Yen.new(10), Yen.new(10)
        ]
      end

      it { is_expected.to eq(1030) }
    end
  end
end
