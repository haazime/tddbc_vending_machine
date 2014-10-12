require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new(name: 'コーラ', price: 120, quantity: 15)
  end

  subject do
    machine.sales
  end

  before do
    machine.receive_money(1000)
    machine.receive_money(1000)
    10.times { machine.serve_drink }
  end

  it { is_expected.to eq(1200) }
end
