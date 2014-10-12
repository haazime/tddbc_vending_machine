require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new(COLA, 15)
  end

  subject do
    machine.sales
  end

  before do
    machine.receive_money(1000)
    machine.receive_money(500)
    20.times { machine.serve_drink }
  end

  it { is_expected.to eq(120 * 12) }
end
