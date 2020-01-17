class NPExplorer::CLI
  attr_accessor :current_state
  
  def start
    system('clear') # clears terminal

    puts "Welcome to National Parks Explorer!"
    NPExplorer::APIAdapter.create_all_states
    main_menu
  end 

  def main_menu
    puts "\nEnter the name of a US state or territory or its state code to see a list of national parks in that state."
    puts "To see a list of states and territories and their codes enter 'states'"
    puts "To exit this program, enter 'exit'"
    
    main_menu_input
  end

  def main_menu_input
    user_input = gets.strip
    # @current_state = user_input.upcase

    if user_input.downcase == "states"
      list_states_and_territories
      puts "\n"
      main_menu
    elsif user_input.downcase == "exit"
      goodbye
    elsif is_a_state_code?(user_input)
      reformatted = user_input.upcase #turns ny or Ny into NY
      state = self.class.find_state_by_code(reformatted)
      load_parks_by_state(state)
      list_parks_in_state(state)
      #list_parks_in_state(state)
      main_menu
    elsif is_a_state_name?(user_input)
      reformatted = user_input.split(" ").each{|str| str.capitalize!}.join(" ") #turns new york or New york into New York
      state = self.class.find_state_by_name(reformatted)
      load_parks_by_state(state)
      list_parks_in_state(state)
      #list_parks_in_state(state)
      main_menu
    else 
      puts "Sorry, that is not a valid entry. Please follow the instructions below:"
      main_menu
    end
  end

  def is_a_state_code?(string)
    reformatted = string.upcase #turns ny or Ny into NY
    NPExplorer::State.all_state_codes.include?(reformatted)
  end

  def is_a_state_name?(string)
    reformatted = string.split(" ").each{|str| str.capitalize!}.join(" ") #turns new york or New york into New York
    NPExplorer::State.all_state_names.include?(reformatted)
  end

  def self.find_state_by_code(state_code)
    NPExplorer::State.all.find {|state| state.code == state_code}
  end

  def self.find_state_by_name(state_name)
    NPExplorer::State.all.find {|state| state.name == state_name}
  end

  def load_parks_by_state(state)
    puts "Looking up parks in #{state.name}...\n\n"
    NPExplorer::APIAdapter.make_parks_from_data(state.code)
  end

  def list_parks_in_state(state)
    puts "National Parks in #{state.name}:"
    state.parks.each.with_index(1) {|park, index| puts "#{index}. #{park.name}"}
  end

  def list_states_and_territories
    puts "\nSTATES: "
    ALL_STATES.each {|state| puts "#{state[:code]} - #{state[:name]}"}
    puts "\nTERRITORIES: "
    ALL_TERRITORIES.each {|terr| puts "#{terr[:code]} - #{terr[:name]}"}
  end

  def goodbye
    puts "Thank you for using National Parks Explorer. Goodbye!"
  end
end