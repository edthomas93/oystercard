class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance
  attr_reader :entry_station


  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Minimum fare is £#{MINIMUM_CHARGE}, please top up your card" if @balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  def deduct(amount)
    raise "Not enough money on card" if @balance - amount < -5
    @balance -= amount
  end

  def in_journey?
    !!entry_station
  end
end
