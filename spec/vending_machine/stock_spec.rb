require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  describe "#stock" do
    subject do
      machine.stock
    end

    context "初期状態" do
      before do
        machine.add_stock(COLA, 5)
      end

      it { is_expected.to eq({ COLA => 5 }) }
    end

    context "コーラ5本,レッドブルを5本追加" do
      before do
        machine.add_stock(COLA, 5)
        machine.add_stock(REDBULL, 5)
      end

      it do
        is_expected.to eq({
          COLA => 5,
          REDBULL => 5
        })
      end
    end

    context "コーラ5本,レッドブルを5本,水を5本追加" do
      before do
        machine.add_stock(COLA, 5)
        machine.add_stock(REDBULL, 5)
        machine.add_stock(WATER, 5)
      end

      it do
        is_expected.to eq({
          COLA => 5,
          REDBULL => 5,
          WATER => 5
        })
      end
    end
  end
end
