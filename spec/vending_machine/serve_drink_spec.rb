require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  subject do
    machine.serve_drink
  end

  context "コーラの在庫がある場合" do
    context "120円を投入した時" do
      before do
        [100, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to change { machine.drinks[:quantity] }
          .from(machine.drinks[:quantity]).to(machine.drinks[:quantity] - 1)
        expect(machine.pay_back).to eq(0)
        expect(machine.sales).to eq(120)
      end
    end

    context "130円を投入した時" do
      before do
        [100, 10, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to change { machine.drinks[:quantity] }
          .from(machine.drinks[:quantity]).to(machine.drinks[:quantity] - 1)
        expect(machine.pay_back).to eq(10)
        expect(machine.sales).to eq(120)
      end
    end

    context "150円を投入した時" do
      before do
        [100, 50].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to change { machine.drinks[:quantity] }
          .from(machine.drinks[:quantity]).to(machine.drinks[:quantity] - 1)
        expect(machine.pay_back).to eq(30)
        expect(machine.sales).to eq(120)
      end
    end

    context "500円を投入した時" do
      before do
        [500].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to change { machine.drinks[:quantity] }
          .from(machine.drinks[:quantity]).to(machine.drinks[:quantity] - 1)
        expect(machine.pay_back).to eq(380)
        expect(machine.sales).to eq(120)
      end
    end

    context "1000円を投入した時" do
      before do
        [1000].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to change { machine.drinks[:quantity] }
          .from(machine.drinks[:quantity]).to(machine.drinks[:quantity] - 1)
        expect(machine.pay_back).to eq(880)
        expect(machine.sales).to eq(120)
      end
    end

    context "110円を投入した時" do
      before do
        [100, 10].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(110)
        expect(machine.sales).to eq(0)
      end
    end
  end

  context "コーラの在庫がない場合" do
    let(:machine) do
      described_class.new(name: 'コーラ', price: 120, quantity: 0)
    end

    context "120円を投入した時" do
      before do
        [100, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(120)
        expect(machine.sales).to eq(0)
      end
    end

    context "130円を投入した時" do
      before do
        [100, 10, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(130)
        expect(machine.sales).to eq(0)
      end
    end

    context "150円を投入した時" do
      before do
        [100, 50].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(150)
        expect(machine.sales).to eq(0)
      end
    end

    context "500円を投入した時" do
      before do
        [500].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(500)
        expect(machine.sales).to eq(0)
      end
    end

    context "1000円を投入した時" do
      before do
        [1000].each {|m| machine.receive_money(m) }
      end

      it do
        expect { subject }.to_not change { machine.drinks[:quantity] }
        expect(machine.pay_back).to eq(1000)
        expect(machine.sales).to eq(0)
      end
    end
  end
end
