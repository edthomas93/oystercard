require 'oystercard'
require 'station'

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

  describe '#deduct' do
    it 'responds to deduct with one arg' do
      expect(card).to respond_to(:deduct).with(1).argument
    end

    it 'can deduct from the balance' do
      expect(card.deduct 2).to eq -2
    end
  end

  describe '#touch_in(station)' do
    it 'raises an error if touch in with less than minimum fare' do
      expect { card.touch_in(station) }.to raise_error "Minimum fare is £1, please top up your card"
    end

    it 'successfully in_journey balance larger than minimum fare' do
      card.top_up Oystercard::MINIMUM_CHARGE
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    let(:station){ double :station }
    it 'is it expected to remember the station where it was touched in' do
      card.top_up Oystercard::MINIMUM_CHARGE
      card.touch_in(station)
        expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'is no longer in_journey' do
      card.touch_out
      expect(card.in_journey?).to eq false
    end

    it 'deducts fare from balance' do
      card.touch_out
      expect(card.balance).to eq -Oystercard::MINIMUM_CHARGE
    end
  end

  describe '#in_journey?' do
    it 'expects in_journey to be true or false' do
      expect(card.in_journey?).to eq(true).or eq(false)
    end
  end
end
