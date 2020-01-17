# service class that gets information from national parks api

class NationalParksExplorer::APIAdapter
  BASE_URL = "https://developer.nps.gov/api/v1/" 

  def self.load_parks_by_state
    ALL_STATES.each do |state| 
      NationalParksExplorer::State.new(state[:name], state[:code])
    end

    binding.pry
  end

  def self.get_parks_by_state(stateCode)
    response = RestClient.get("#{BASE_URL}parks?stateCode=#{stateCode}&api_key=#{ENV['NPS_API_KEY']}")
    JSON.parse(response.body)["data"] # returns array of hashes containing info about each park
  end

  def self.list_parks(array, stateCode)
    puts "Here are all of the national parks in #{stateCode}:"
    array.each.with_index(1) {|park, index| puts "#{index}. #{park["fullName"]}"}
  end
end
