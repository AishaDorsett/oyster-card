require "oystercard"

describe Oystercard do
    describe '#initialize' do

        let(:station){ double :waterloo}

        it 'creates each oystercard instance with a default balance' do
            expect(subject.balance).to eq 0
        end
    
        it 'stores the entry station' do
            subject.touch_in(station)
            expect(subject.entry_station).to eq station
        end
    end

    describe '#top_up' do
        it 'allows oyster card to be topped up' do
            subject.top_up(5)
            expect(subject.balance).to eq 5
        end
        it "raises error if balance is higher than 90" do
           maximum = Oystercard::MAX_LIMIT 
           expect{ subject.top_up(91) }.to raise_error "Limit exceeded: £#{maximum}! Cannot top up"
        end
    end

    # describe '#deduct' do 
    #     it 'deducts money from the oystercard' do 
    #         subject.top_up(10)
    #         subject.deduct(5)
    #         expect(subject.balance).to eq 5
    #     end
    # end 

    describe '#touch_in' do
        it "can touch in" do
            subject.top_up(1)
            subject.touch_in
            expect(subject).to be_in_journey
        end

        it "raises an error if oyster has insufficient funds" do
          minimum = Oystercard::MIN_LIMIT
          expect{ subject.touch_in }.to raise_error "Insufficient funds, you need at least £#{minimum} to touch in"
        end
    end

    describe '#touch_out' do
        it 'returns false if oyster is not in journey' do
            subject.touch_out
            expect(subject.in_journey?).to eq false
        end 

        it 'deducts the cost of the journey from the card when touching out' do
          subject.top_up(5)
          subject.touch_in
          expect { subject.touch_out }.to change{ subject.balance }.by(-2) 
        end
    end

    describe '#in_journey?' do 
        it 'oyster card is initially not in journey' do
            oyster = Oystercard.new
            expect(oyster.in_journey?).to eq false
        end
    end

end