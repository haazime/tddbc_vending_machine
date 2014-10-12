require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  context "まだ投入していない場合" do
    it do
      expect(machine.deposite).to eq(0)
      expect(machine.pay_back).to eq(0)
      expect(machine.deposite).to eq(0)
    end
  end

  context "10円を1枚投入した場合" do
    before do
      machine.receive_money(10)
    end

    it do
      expect(machine.deposite).to eq(10)
      expect(machine.pay_back).to eq(10)
      expect(machine.deposite).to eq(0)
    end
  end

  context "10円を3枚,1000円1枚,500円2枚投入した場合" do
    before do
      money = Money.new([10, 10, 10, 1000, 500, 500])
      money.throw_to(machine)
    end

    it do
      expect(machine.deposite).to eq(2030)
      expect(machine.pay_back).to eq(2030)
      expect(machine.deposite).to eq(0)
    end
  end

  [1, 5, 2000, 5000, 10000].each do |m|
    context "#{m}円を1枚投入した場合" do
      before do
        machine.receive_money(m)
      end

      it do
        expect(machine.deposite).to eq(0)
        expect(machine.pay_back).to eq(m)
        expect(machine.deposite).to eq(0)
      end
    end
  end

  context do
    it do
      machine.receive_money(5000)
      expect(machine.deposite).to eq(0)

      machine.receive_money(10)
      machine.receive_money(10)
      expect(machine.deposite).to eq(20)

      7.times { machine.receive_money(1) }
      expect(machine.deposite).to eq(20)

      machine.receive_money(1000)
      machine.receive_money(500)
      expect(machine.deposite).to eq(1520)

      expect(machine.pay_back).to eq(6527)
    end
  end
end
