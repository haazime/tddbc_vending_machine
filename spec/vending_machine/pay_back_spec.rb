require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#payback" do
    subject do
      Array(money).each {|m| machine.receive_money(m) }
      machine.pay_back
    end

    context "10円を投入した場合" do
      let(:money) do
        10
      end

      it { is_expected.to eq(10) }
    end

    context "100円1枚と10円5枚を投入した場合" do
      let(:money) do
        [
          100,
          10, 10, 10, 10, 10
        ]
      end

      it { is_expected.to eq(150) }
    end

    context "1000円1枚と10円3枚を投入した場合" do
      let(:money) do
        [
          1000,
          10, 10, 10
        ]
      end

      it { is_expected.to eq(1030) }
    end

    context "10円3枚,50円1枚,100円2枚,500円1枚,1000円1枚を投入した場合" do
      let(:money) do
        [
          10, 10, 10,
          50,
          100, 100,
          500,
          1000
        ]
      end

      it { is_expected.to eq(1780) }
    end
  end
end
