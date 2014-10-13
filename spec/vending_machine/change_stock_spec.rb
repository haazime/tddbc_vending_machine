require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

skip do
  context "釣り銭に50円が5枚，10円が5枚の時200円を投入してコーラを買った場合" do
    before do
      machine.add_stock(COLA, 1)
      machine.add_change([50] * 5)
      machine.add_change([50] * 5)
      machine.receive_money(100)
      machine.receive_money(200)
      machine.serve_drink(COLA)
    end

    it do
      expect(machine.pay_back).to eq([50, 10, 10, 10])
      expect(machine.change_stock).to eq({
        1000 => 0,
        500 => 0,
        100 => 2,
        50 => 4,
        10 => 2,
      })
    end
  end
end
end
