require 'oystercard'

describe Oystercard do
  it 'responds to balance' do
    expect(subject.balance).to eq 0
  end
end
