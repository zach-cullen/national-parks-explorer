# service class that gets information from national parks api

class NPExplorer::APIAdapter
  BASE_URL = "https://developer.nps.gov/api/v1/" 

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
      NPExplorer::Park.new(name: park["fullName"], park_code: park["parkCode"], state_code_array: park["states"], description: park["description"] )
    end
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
