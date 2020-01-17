class NPExplorer::Park
  attr_accessor :name, :park_code, :states, :description

  @@all = []

  def initialize(name:, park_code:, state_code_array:, description:)
    @name = name
    @park_code = park_code
    @description = description
    @states = []
    state_code_array.split(',').each {|code| @states << NPExplorer::CLI.find_state_by_code(code)}
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