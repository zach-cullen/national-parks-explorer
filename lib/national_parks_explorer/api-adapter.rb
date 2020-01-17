# service class that gets information from national parks api

class NPExplorer::APIAdapter
  BASE_URL = "https://developer.nps.gov/api/v1/" 

  #uses hard-coded list of states and territories to create state objects
  def self.create_all_states
    ALL_STATES.each do |state| 
      NPExplorer::State.new(state[:name], state[:code])
    end
  end

  #gets data about parks from the api one state at a time and returns a hash
  def self.get_parks_by_state(state_code)
    response = RestClient.get("#{BASE_URL}parks?stateCode=#{state_code}&api_key=#{ENV['NPS_API_KEY']}")
    JSON.parse(response.body)["data"] # returns array of hashes containing info about each park
  end
  
  #creates all park objects for a particular state
  def self.make_parks_from_data(state_code)
    #needs to check if data is already there

    park_info = get_parks_by_state(state_code)
    park_info.each do |park|
      NPExplorer::Park.new(name: park["fullName"], park_code: park["parkCode"], states: park["states"], description: park["description"] )
    end

    binding.pry #check to see if there are parks
  end

  def self.list_parks(array, state_code)
    puts "Here are all of the national parks in #{state_code}:"
    array.each.with_index(1) {|park, index| puts "#{index}. #{park["fullName"]}"}
  end

  # UNUSED - loads all 674 parks one state at a time
  def self.load_parks_by_state
    NPExplorer::State.all.each do |state|
      park_info = get_parks_by_state(state.code)
      park_info.each do |park|
        NPExplorer::Park.new(name: park["fullName"], park_code: park["parkCode"], states: park["states"], description: park["description"] )
      end
    end
  end

end
