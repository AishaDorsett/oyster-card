require "oystercard"

describe Oystercard do

	let(:station){ double :station}

	describe '#initialize' do
		it 'creates each oystercard instance with a default balance' do
				expect(subject.balance).to eq 0
		end

		it 'stores the entry station' do
			subject.top_up(2)
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
			expect{ subject.top_up(91) }.to raise_error "Limit exceeded: £#{maximum}! Cannot top up."
		end
	end

	describe '#touch_in' do
		it "allows the oyster card touch in" do
			subject.top_up(1)
			subject.touch_in(station)
			expect(subject).to be_in_journey
		end

		it "raises an error if oyster has insufficient funds" do
			minimum = Oystercard::MIN_LIMIT
			expect{ subject.touch_in(station) }.to raise_error "Insufficient funds. £#{minimum} minimum balance."
		end
	end

	describe '#touch_out' do
		it 'returns false if oyster is not in journey so you cannot touch out' do
			subject.touch_out
			expect(subject.in_journey?).to eq false
		end 

		it 'deducts the cost of the journey from the card when touching out' do
			subject.top_up(5)
			subject.touch_in(station)
			expect { subject.touch_out }.to change{ subject.balance }.by(-2) 
		end
	end

	describe '#in_journey?' do 
		it 'oyster card is initially not in journey' do
				expect(subject.in_journey?).to eq false
		end
	end

end 