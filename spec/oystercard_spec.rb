require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  describe '#balance' do
    it 'responds to balance' do
      expect(card).to respond_to(:balance)
    end
  end

  describe '#top_up' do
    it 'responds to top_up with one arg' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'can top up the balance' do
      expect { card.top_up 1 }.to change{ card.balance }.by 1
    end

    it 'raises an error if maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect { card.top_up 1 }.to raise_error "Maximum balance of £#{maximum_balance} exceeded"
    end
  end
end
