require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#stock" do
    subject do
      machine.stock
    end

    context "初期状態" do
      it { is_expected.to eq({ COLA => 5 }) }
    end

    context "レッドブルを5本追加" do
      before do
        machine.add_stock(REDBULL, 5)
      end

      it do
        is_expected.to eq({
          COLA => 5,
          REDBULL => 5
        })
      end
    end

    context "レッドブルを5本,水を5本追加" do
      before do
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
