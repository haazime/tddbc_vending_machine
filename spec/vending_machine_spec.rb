require 'spec_helper'

context "コーラ1本在庫がある場合" do
  let(:machine) do
    VendingMachine.new.tap do |m|
      m.add_stock(COLA, 1)
    end
  end

  it do
    machine.receive_money(10)
    expect(machine.available_drinks).to be_empty
    
    machine.receive_money(100)
    expect(machine.available_drinks).to be_empty
    
    machine.receive_money(10)
    expect(machine.available_drinks).to match([COLA])

    machine.serve_drink(COLA)
    expect(machine.stock[COLA]).to eq(0)
    expect(machine.pay_back).to eq(0)
    expect(machine.sales).to eq(COLA.price)

    machine.receive_money(500)
    expect(machine.available_drinks).to be_empty
  end
end

context "コーラ2本,レッドブル1本,水2本在庫がある場合" do
  let(:machine) do
    VendingMachine.new.tap do |m|
      m.add_stock(COLA, 2)
      m.add_stock(REDBULL, 1)
      m.add_stock(WATER, 2)
    end
  end

  it do
    machine.receive_money(500)
    expect(machine.available_drinks).to match([COLA, REDBULL, WATER])

    machine.serve_drink(WATER)
    expect(machine.stock[WATER]).to eq(1)
    expect(machine.sales).to eq(WATER.price)
    expect(machine.pay_back).to eq(400)
    expect(machine.available_drinks).to match([COLA, REDBULL, WATER])

    machine.serve_drink(REDBULL)
    expect(machine.stock[REDBULL]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price)
    expect(machine.pay_back).to eq(200)
    expect(machine.available_drinks).to match([COLA, WATER])

    machine.serve_drink(COLA)
    expect(machine.stock[COLA]).to eq(1)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price)
    expect(machine.pay_back).to eq(80)
    expect(machine.available_drinks).to be_empty

    machine.receive_money(50)
    expect(machine.available_drinks).to match([COLA, WATER])

    machine.serve_drink(COLA)
    expect(machine.stock[COLA]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price + COLA.price)
    expect(machine.pay_back).to eq(10)
    expect(machine.available_drinks).to be_empty

    machine.receive_money(1000)
    expect(machine.available_drinks).to match([WATER])

    machine.serve_drink(WATER)
    expect(machine.stock[WATER]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price + COLA.price + WATER.price)
    expect(machine.pay_back).to eq(910)
    expect(machine.available_drinks).to be_empty
  end
end
