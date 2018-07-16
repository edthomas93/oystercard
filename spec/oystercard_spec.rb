require 'oystercard'

describe Oystercard do
  it 'responds to balance' do
    expect(subject.balance).to be_a(Float)
  end
end
