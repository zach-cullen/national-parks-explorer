#command line interface
require_relative 'api-adapter'

class CLI
    attr_accessor :current_state

    def initialize
        puts "Welcome to National Parks Explorer!"
        puts "Enter a two digit state code to see a list of national parks in that state"
        user_input = gets.strip.upcase
        @current_state = user_input
        puts "Looking up parks in #{@current_state}..."
        APIAdapter.list_parks(APIAdapter.get_parks_by_state(@current_state), @current_state)
    end 
end