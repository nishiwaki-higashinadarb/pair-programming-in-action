require 'vending_machine'

describe 'VendingMachine' do
  let(:machine) { VendingMachine.new }
  context '#new' do
    it { expect(machine.total).to eq 0 }
  end

  context '#insert' do
    it 'insert 10 yen' do
      machine.insert 10
      expect(machine.total).to eq 10
    end

    it 'insert 2 times' do
      machine.insert 10
      machine.insert 10
      expect(machine.total).to eq 20
    end

    context '#refund' do
      it 'clear' do
        machine.insert 10
        machine.refund
        expect(machine.total).to eq 0
      end

      it 'payback' do
        machine.insert 10
        expect(machine.refund).to eq 10
      end
    end
  end
end
