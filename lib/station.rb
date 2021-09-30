class Station
  attr_reader :station_name, :station_zone, :station_info


  def initialize(name = "waterloo")
    stations = {:kings_cross => 1, :waterloo => 1, :archway => 2}
    zone = stations[name]
    @station_info = {:station_name => name, :station_zone => zone}
  end

end