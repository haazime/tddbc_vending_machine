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
      skip do
      before do
        machine.add_stock(name: 'レッドブル', price: 200, quantity: 5)
      end

      it do
        is_expected.to eq({
          name: 'コーラ', price: 120, quantity: 5,
          name: 'レッドブル', price: 200, quantity: 5,
        })
      end
      end
    end
  end
end
