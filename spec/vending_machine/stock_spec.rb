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
      it do
        is_expected.to eq({ name: 'コーラ', price: 120, quantity: 5 })
      end
    end

    context "レッドブルを5本追加" do
    end
  end
end
