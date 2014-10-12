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
end
