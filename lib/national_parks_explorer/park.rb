class NPExplorer::Park
  attr_accessor :name, :park_code, :states, :description, :location, :weather, :visitor_center, :campgrounds

  @@all = []

  def initialize(name:, park_code:, state_code_array:, description:, location:, weather:)
    @name = replace_special_characters(name)
    @park_code = park_code
    @description = description
    @weather = weather
    @location = location
    @states = []
    state_code_array.split(',').each {|code| @states << NPExplorer::State.find_state_by_code(code)}
    #@states.each {|state| self.save_to_state(state)}
    self.save
  end

  def save
    @@all << self
  end

  # def save_to_state(state)
  #   state.parks << self
  # end

  def self.all
    @@all
  end

  def replace_special_characters(string)
    if string.include?("&#241;")
      string = string.gsub("&#241;", "ñ")
    elsif string.include?("&#257;")
      string = string.gsub("&#257;", "ā")
    elsif string.include?("&#333;")
      string = string.gsub("&#333;", "ō")
    else 
      string
    end
  end
  

end