require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  subject do
    machine.serve_drink
  end

  before do
    machine.add_change_stock(500, 10)
    machine.add_change_stock(100, 10)
    machine.add_change_stock(50, 10)
    machine.add_change_stock(10, 10)
  end

  context "コーラの在庫がある場合" do
    before do
      machine.add_drink_stock(COLA, 5)
    end

    [
      { money: Money.new([100, 10, 10]), pay_back: 0, sales: 120 },
      { money: Money.new([100, 10, 10, 10]), pay_back: 10, sales: 120 },
      { money: Money.new([100, 50]), pay_back: 30, sales: 120 },
      { money: Money.new([500]), pay_back: 380, sales: 120 },
      { money: Money.new([1000]), pay_back: 880, sales: 120 },
    ].each do |c|
      context "#{c[:money].total}円を投入した時" do
        before do
          c[:money].throw_to(machine)
        end

        it do
          expect { subject }.to change { machine.drink_stock[COLA] }
            .from(machine.drink_stock[COLA]).to(machine.drink_stock[COLA] - 1)
          expect(machine.pay_back).to eq(c[:pay_back])
          expect(machine.sales).to eq(c[:sales])
        end
      end
    end

    context "110円を投入した時" do
      before do
        Money.new([100, 10]).throw_to(machine)
      end

      it do
        expect { subject }.to_not change { machine.drink_stock[COLA] }
        expect(machine.pay_back).to eq(110)
        expect(machine.sales).to eq(0)
      end
    end
  end

  context "コーラの在庫がない場合" do
    [
      { money: Money.new([100, 10, 10]), pay_back: 120, sales: 0 },
      { money: Money.new([100, 10, 10, 10]), pay_back: 130, sales: 0 },
      { money: Money.new([100, 50]), pay_back: 150, sales: 0 },
      { money: Money.new([500]), pay_back: 500, sales: 0 },
      { money: Money.new([1000]), pay_back: 1000, sales: 0 },
    ].each do |c|
      context "#{c[:money].total}円を投入した時" do
        before do
          c[:money].throw_to(machine)
        end

        it do
          expect { subject }.to_not change { machine.drink_stock[COLA] }
          expect(machine.pay_back).to eq(c[:pay_back])
          expect(machine.sales).to eq(c[:sales])
        end
      end
    end
  end
end
