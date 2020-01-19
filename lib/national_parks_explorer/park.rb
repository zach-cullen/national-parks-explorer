class NPExplorer::Park
  attr_accessor :name, :park_code, :states, :description, :location, :weather, :visitor_center, :campgrounds

  @@all = []

  def initialize(name:, park_code:, state_code_array:, description:, location:, weather:)
    @name = name
    @park_code = park_code
    @description = description
    @weather = weather
    @location = location
    @states = []
    state_code_array.split(',').each {|code| @states << NPExplorer::State.find_state_by_code(code)}
    @states.each {|state| self.save_to_state(state)}
    self.save
  end

  def save
    @@all << self
  end

  def save_to_state(state)
    state.parks << self
  end

  def self.all
    @@all
  end

end