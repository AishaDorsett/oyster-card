class Oystercard 
    attr_reader :balance
    attr_accessor :in_use

    MAX_LIMIT = 90
    MIN_LIMIT = 1

    def initialize
        @balance = 0
        @in_use = nil
    end

    def top_up(value)
      fail "Limit exceeded: £#{MAX_LIMIT}! Cannot top up" if value > MAX_LIMIT
      @balance += value
    end

    def touch_in
      fail "Insufficient funds, you need at least £#{MIN_LIMIT} to touch in" if @balance < MIN_LIMIT
      @in_use = true
    end

    def touch_out
        @in_use = false
    end

    def in_journey?
        @in_use == true
    end

    private

    def deduct(journey=2)
      @balance -= journey
  end
end