class NPExplorer::State
  attr_reader :name, :code, :parks

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

end