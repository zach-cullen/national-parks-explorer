class NationalParksExplorer::Park
  attr_accessor :name, :states, :description, :weather

  def initialize(name, states, description, weather)
    @name = name
    @states = []
    @description = description
    @weather = weather
  end

end