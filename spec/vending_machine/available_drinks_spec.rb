require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  subject do
    machine.available_drinks
  end

  before do
    machine.add_change_stock(500, 10)
    machine.add_change_stock(100, 10)
    machine.add_change_stock(50, 10)
    machine.add_change_stock(10, 10)
  end

  context "在庫が何もない場合" do
    it { is_expected.to be_empty }
  end

  context "コーラ:5,レッドブル:5,水:5がある場合" do
    before do
      machine.add_drink_stock(COLA, 5)
      machine.add_drink_stock(REDBULL, 5)
      machine.add_drink_stock(WATER, 5)
    end

    context "お金を投入していない時" do
      it { is_expected.to be_empty }
    end

    [
      { money: Money.new([100, 10, 10]), drinks: [COLA, WATER] },
      { money: Money.new([100]), drinks: [WATER] },
      { money: Money.new([100, 50]), drinks: [COLA, WATER] },
      { money: Money.new([500]), drinks: [COLA, REDBULL, WATER] },
      { money: Money.new([1000]), drinks: [COLA, REDBULL, WATER] },
    ].each do |c|
      context "#{c[:money].total}円投入した時" do
        before do
          c[:money].throw_to(machine)
        end

        it { is_expected.to match(c[:drinks]) }
      end
    end

    context "レッドブルを5本買った後、500円を投入する" do
      before do
        Money.new([1000]).throw_to(machine)
        5.times { machine.serve_drink(REDBULL) }
        Money.new([100, 100, 100, 100, 100]).throw_to(machine)
      end

      it { is_expected.to match([COLA, WATER]) }
    end
  end

  context "コーラ:0,レッドブル:5,水:5がある場合" do
    before do
      machine.add_drink_stock(COLA, 0)
      machine.add_drink_stock(REDBULL, 5)
      machine.add_drink_stock(WATER, 5)
    end

    context "お金を投入していない時" do
      it { is_expected.to be_empty }
    end

    [
      { money: Money.new([100, 10, 10]), drinks: [WATER] },
      { money: Money.new([100]), drinks: [WATER] },
      { money: Money.new([100, 50]), drinks: [WATER] },
      { money: Money.new([500]), drinks: [REDBULL, WATER] },
      { money: Money.new([1000]), drinks: [REDBULL, WATER] },
    ].each do |c|
      context "#{c[:money].total}円投入した時" do
        before do
          c[:money].throw_to(machine)
        end

        it { is_expected.to match(c[:drinks]) }
      end
    end
  end
end
