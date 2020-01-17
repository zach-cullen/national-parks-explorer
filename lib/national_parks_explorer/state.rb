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

end