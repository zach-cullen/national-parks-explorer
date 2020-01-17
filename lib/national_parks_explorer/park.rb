class NPExplorer::Park
  attr_accessor :name, :park_code, :states, :description

  @@all = []

  def initialize(name:, park_code:, states:, description:)
    @name = name
    @park_code = park_code
    @states = states
    @description = description
    self.save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

end