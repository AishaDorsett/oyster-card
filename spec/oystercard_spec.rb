require "oystercard"

describe Oystercard do
    describe '#initialize' do
        it 'creates each oystercard instance with a default balance' do
            expect(subject.balance).to eq 0
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

    describe '#deduct' do 
        it 'deducts money from the oystercard' do 
            subject.top_up(10)
            subject.deduct(5)
            expect(subject.balance).to eq 5
        end
    end 

    describe '#touch_in' do
        it "can touch in" do
            subject.touch_in
            expect(subject).to be_in_journey
        end
    end

    describe '#touch_out' do
        it 'returns false if oyster is not in journey' do
            subject.touch_out
            expect(subject.in_journey?).to eq false
        end 
    end

    describe '#in_journey?' do 
        it 'oyster card is initially not in journey' do
            oyster = Oystercard.new
            expect(oyster.in_journey?).to eq false
        end
    end

end