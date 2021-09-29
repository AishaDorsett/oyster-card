class Oystercard 
    attr_reader :balance
    attr_reader :entry_station

    MAX_LIMIT = 90
    MIN_LIMIT = 1
    MIN_CHARGE = 2

    def initialize
        @balance = 0
        @entry_station = entry_station
    end

    def top_up(value)
      fail "Limit exceeded: £#{MAX_LIMIT}! Cannot top up." if value > MAX_LIMIT
      @balance += value
    end

    def touch_in(station)
      fail "Insufficient funds. £#{MIN_LIMIT} minimum balance." if @balance < MIN_LIMIT
      @entry_station = station
    end

    def touch_out
        deduct(MIN_CHARGE)
        @entry_station = nil
    end

    def in_journey?
        !!@entry_station
    end

    private

    def deduct(journey)
      @balance -= journey
    end
end