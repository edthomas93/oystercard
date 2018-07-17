require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'responds to balance' do
      expect(subject.balance).to respond_to
    end
  end

  describe '#top_up' do
    it 'responds to top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change{ subject.balance }.by 1
  end
end
