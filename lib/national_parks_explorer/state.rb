class NPExplorer::State
  attr_accessor :parks
  attr_reader :name, :code

  @@all = []

  def initialize(state_name, state_code)
    @name = state_name
    @code = state_code
    @parks = []
    self.save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.all_state_codes
    self.all.map {|state| state.code}
  end

  def self.all_state_names
    self.all.map {|state| state.name}
  end

  def self.find_state_by_code(state_code)
    self.all.find {|state| state.code == state_code}
  end

  def self.find_state_by_name(state_name)
    self.all.find {|state| state.name == state_name}
  end

  #uses hard-coded list of states and territories to create state objects
  def self.create_all_states
    ALL_STATES.each do |state| 
      self.new(state[:name], state[:code])
    end
  end

end