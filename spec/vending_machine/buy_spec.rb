require 'spec_helper'

RSpec.describe VendingMachine do
  let(:machine) do
    described_class.new
  end

  describe "#can_buy?" do
    subject do
      machine.can_buy?
    end

    context "お金を投入していない時" do
      it { is_expected.to be false }
    end

    context "コーラの在庫がある場合" do
      context "110円を投入した時" do
        before do
          [100, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "120円を投入した時" do
        before do
          [100, 10, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be true }
      end

      context "130円を投入した時" do
        before do
          [100, 10, 10, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be true }
      end

      context "150円を投入した時" do
        before do
          [100, 50].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be true }
      end

      context "500円を投入した時" do
        before do
          [500].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be true }
      end

      context "1000円を投入した時" do
        before do
          [1000].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be true }
      end
    end

    context "コーラの在庫がない場合" do
      let(:machine) do
        described_class.new(name: 'コーラ', price: 120, quantity: 0)
      end

      context "110円を投入した時" do
        before do
          [100, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "120円を投入した時" do
        before do
          [100, 10, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "130円を投入した時" do
        before do
          [100, 10, 10, 10].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "150円を投入した時" do
        before do
          [100, 50].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "500円を投入した時" do
        before do
          [500].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end

      context "1000円を投入した時" do
        before do
          [1000].each {|m| machine.receive_money(m) }
        end

        it { is_expected.to be false }
      end
    end
  end
end
