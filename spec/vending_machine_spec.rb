require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#recieve" do
    context "1円1枚を投入" do
      it do
        expect(machine.receive(1)).to eq(1)
      end
    end

    context "5円1枚を投入" do
      it do
        expect(machine.receive(5)).to eq(5)
      end
    end

    context "5000円1枚を投入" do
      it do
        expect(machine.receive(5000)).to eq(5000)
      end
    end

    context "10000円1枚を投入" do
      it do
        expect(machine.receive(10000)).to eq(10000)
      end
    end

    context "1円3枚,5円2枚,5000円1枚,10000円1枚を投入" do
      it do
        money = [
          1, 1, 1,
          5, 5,
          5000,
          10000
        ]
        backs = money.map {|m| machine.receive(m) }
        expect(backs).to eq(money)
      end
    end
  end

  describe "#payback" do
    subject do
      Array(money).each {|m| machine.receive(m) }
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
