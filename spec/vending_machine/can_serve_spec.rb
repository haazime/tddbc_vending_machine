require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  describe "#can_serve?" do
    subject do
      machine.can_serve?
    end

    context "お金を投入していない時" do
      it { is_expected.to be false }
    end

    context "コーラの在庫がある場合" do
      before do
        machine.add_drink_stock(COLA, 5)
      end

      [
        { money: Money.new([100, 10]), can_serve: false },
        { money: Money.new([100, 10, 10]), can_serve: true },
        { money: Money.new([100, 10, 10, 10]), can_serve: true },
        { money: Money.new([100, 50]), can_serve: true },
        { money: Money.new([500]), can_serve: true },
        { money: Money.new([1000]), can_serve: true },
      ].each do |c|
        context "#{c[:money].total}円を投入した時" do
          before do
            c[:money].throw_to(machine)
          end

          it { is_expected.to be c[:can_serve] }
        end
      end
    end

    context "コーラの在庫がない場合" do
      [
        { money: Money.new([100, 10]), can_serve: false },
        { money: Money.new([100, 10, 10]), can_serve: false },
        { money: Money.new([100, 10, 10, 10]), can_serve: false },
        { money: Money.new([100, 50]), can_serve: false },
        { money: Money.new([500]), can_serve: false },
        { money: Money.new([1000]), can_serve: false },
      ].each do |c|
        context "#{c[:money].total}円を投入した時" do
          before do
            c[:money].throw_to(machine)
          end

          it { is_expected.to be c[:can_serve] }
        end
      end
    end
  end
end
