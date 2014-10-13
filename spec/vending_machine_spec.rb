require 'spec_helper'

context "コーラ1本在庫がある場合" do
  let(:machine) do
    VendingMachine.new.tap do |m|
      m.add_drink_stock(COLA, 1)
      m.add_change_stock(1000, 10)
      m.add_change_stock(500, 10)
      m.add_change_stock(100, 10)
      m.add_change_stock(50, 10)
      m.add_change_stock(10, 10)
    end
  end

  it do
    machine.receive_money(10)
    expect(machine.deposite).to eq(10)
    expect(machine.available_drinks).to be_empty

    machine.receive_money(100)
    expect(machine.deposite).to eq(110)
    expect(machine.available_drinks).to be_empty

    machine.receive_money(10)
    expect(machine.deposite).to eq(120)
    expect(machine.available_drinks).to match([COLA])

    machine.serve_drink(COLA)
    expect(machine.drink_stock[COLA]).to eq(0)
    expect(machine.deposite).to eq(0)
    expect(machine.pay_back).to eq([])
    expect(machine.sales).to eq(COLA.price)

    machine.receive_money(500)
    expect(machine.deposite).to eq(500)
    expect(machine.available_drinks).to be_empty
  end
end

context "コーラ2本,レッドブル1本,水2本在庫がある場合" do
  let(:machine) do
    VendingMachine.new.tap do |m|
      m.add_drink_stock(COLA, 2)
      m.add_drink_stock(REDBULL, 1)
      m.add_drink_stock(WATER, 2)
      m.add_change_stock(1000, 10)
      m.add_change_stock(500, 10)
      m.add_change_stock(100, 10)
      m.add_change_stock(50, 10)
      m.add_change_stock(10, 10)
    end
  end

  it do
    machine.receive_money(500)
    expect(machine.deposite).to eq(500)
    expect(machine.available_drinks).to match([COLA, REDBULL, WATER])

    machine.serve_drink(WATER)
    expect(machine.drink_stock[WATER]).to eq(1)
    expect(machine.sales).to eq(WATER.price)
    expect(machine.deposite).to eq(400)
    expect(machine.available_drinks).to match([COLA, REDBULL, WATER])

    machine.serve_drink(REDBULL)
    expect(machine.drink_stock[REDBULL]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price)
    expect(machine.deposite).to eq(200)
    expect(machine.available_drinks).to match([COLA, WATER])

    machine.serve_drink(COLA)
    expect(machine.drink_stock[COLA]).to eq(1)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price)
    expect(machine.deposite).to eq(80)
    expect(machine.available_drinks).to be_empty
    expect(machine.pay_back).to eq([50, 10, 10, 10])
    expect(machine.deposite).to eq(0)

    machine.receive_money(100)
    machine.receive_money(10)
    machine.receive_money(10)
    machine.receive_money(10)
    expect(machine.deposite).to eq(130)
    expect(machine.available_drinks).to match([COLA, WATER])

    machine.serve_drink(COLA)
    expect(machine.drink_stock[COLA]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price + COLA.price)
    expect(machine.deposite).to eq(10)
    expect(machine.available_drinks).to be_empty

    machine.receive_money(1000)
    expect(machine.deposite).to eq(1010)
    expect(machine.available_drinks).to match([WATER])

    machine.serve_drink(WATER)
    expect(machine.drink_stock[WATER]).to eq(0)
    expect(machine.sales).to eq(WATER.price + REDBULL.price + COLA.price + COLA.price + WATER.price)
    expect(machine.available_drinks).to be_empty
    expect(machine.pay_back).to eq([500, 100, 100, 100, 100, 10])
    expect(machine.deposite).to eq(0)
  end
end
