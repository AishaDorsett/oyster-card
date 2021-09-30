require 'station'

RSpec.describe Station do
  describe 'initialize' do
      before do
        @new_station = Station.new(:kings_cross)
      end
    it 'initializes new stations with a name and zone' do
      expect(@new_station.station_info).to include(:station_name => :kings_cross, :station_zone => 1)
    end
  end
end