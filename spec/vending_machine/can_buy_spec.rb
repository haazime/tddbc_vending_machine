require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#can_buy?" do
    subject do
      machine.can_buy?
    end

    context "お金を投入していない時" do
      it { is_expected.to be false }
    end

    context "コーラの在庫がある場合" do
      [
        { money: [100, 10], can_buy: false },
        { money: [100, 10, 10], can_buy: true },
        { money: [100, 10, 10, 10], can_buy: true },
        { money: [100, 50], can_buy: true },
        { money: [500], can_buy: true },
        { money: [1000], can_buy: true },
      ].each do |c|
        context "#{c[:money].inject(&:+)}円を投入した時" do
          before do
            c[:money].each {|m| machine.receive_money(m) }
          end

          it { is_expected.to be c[:can_buy] }
        end
      end
    end

    context "コーラの在庫がない場合" do
      let(:machine) do
        described_class.new(name: 'コーラ', price: 120, quantity: 0)
      end

      [
        { money: [100, 10], can_buy: false },
        { money: [100, 10, 10], can_buy: false },
        { money: [100, 10, 10, 10], can_buy: false },
        { money: [100, 50], can_buy: false },
        { money: [500], can_buy: false },
        { money: [1000], can_buy: false },
      ].each do |c|
        context "#{c[:money].inject(&:+)}円を投入した時" do
          before do
            c[:money].each {|m| machine.receive_money(m) }
          end

          it { is_expected.to be c[:can_buy] }
        end
      end
    end
  end
end
