class Oystercard 
    attr_reader :balance, :entry_station, :exit_station, :journeys

    MAX_LIMIT = 90
    MIN_LIMIT = 1
    MIN_CHARGE = 2

    def initialize
        @balance = 0
        @entry_station = entry_station
        @exit_station = exit_station
        @journeys = []
    end

    def top_up(value)
      fail "Limit exceeded: £#{MAX_LIMIT}! Cannot top up." if value > MAX_LIMIT
      @balance += value
    end

    def touch_in(entry_station)
      fail "Insufficient funds. £#{MIN_LIMIT} minimum balance." if @balance < MIN_LIMIT
      @entry_station = entry_station
    end

    def touch_out(exit_station)
        deduct(MIN_CHARGE)
        # @entry_station = nil
        @exit_station = exit_station
    end

    def in_journey?
        !!@entry_station
    end

    def collect_journeys
      @journeys.push(entry_station: @entry_station, exit_station: @exit_station)
    end

    private

    def deduct(journey)
      @balance -= journey
    end
end