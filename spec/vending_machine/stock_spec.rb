require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#drinks" do
    subject do
      machine.drinks
    end

    context "初期状態" do
      it do
        is_expected.to eq({ name: 'コーラ', price: 120, stock: 5 })
      end
    end
  end
end
