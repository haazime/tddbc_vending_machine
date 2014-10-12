require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) { described_class.new }

  subject do
    machine.available_drinks
  end

  context "在庫が何もない場合" do
    it { is_expected.to be_empty }
  end

  context "コーラ:5,レッドブル:5,水:5がある場合" do
    before do
      machine.add_stock(COLA, 5)
      machine.add_stock(REDBULL, 5)
      machine.add_stock(WATER, 5)
    end

    context "お金を投入していない時" do
      it { is_expected.to be_empty }
    end

    context "120円投入した時" do
      before do
        [100, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([COLA, WATER])
      end
    end

    context "100円投入した時" do
      before do
        [100].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([WATER])
      end
    end

    context "150円投入した時" do
      before do
        [100, 50].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([COLA, WATER])
      end
    end

    context "500円投入した時" do
      before do
        [500].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([COLA, REDBULL, WATER])
      end
    end

    context "1000円投入した時" do
      before do
        [1000].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([COLA, REDBULL, WATER])
      end
    end
  end

  context "コーラ:0,レッドブル:5,水:5がある場合" do
    before do
      machine.add_stock(REDBULL, 5)
      machine.add_stock(WATER, 5)
    end

    context "お金を投入していない時" do
      it { is_expected.to be_empty }
    end

    context "120円投入した時" do
      before do
        [100, 10, 10].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([WATER])
      end
    end

    context "100円投入した時" do
      before do
        [100].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([WATER])
      end
    end

    context "150円投入した時" do
      before do
        [100, 50].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([WATER])
      end
    end

    context "500円投入した時" do
      before do
        [500].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([REDBULL, WATER])
      end
    end

    context "1000円投入した時" do
      before do
        [1000].each {|m| machine.receive_money(m) }
      end

      it do
        is_expected.to match([REDBULL, WATER])
      end
    end
  end
end
