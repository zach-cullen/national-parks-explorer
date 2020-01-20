class NPExplorer::CLI
  attr_accessor :current_state, :current_park

  def start
    system('clear') # clears terminal
    puts "\n"
    print_welcome_screen
    puts "Welcome to National Parks Explorer!"
    NPExplorer::State.create_all_states
    main_menu
  end 

  def main_menu
    puts "\nEnter a STATE name or code to see a list of parks in that state or territory (e.g. 'Alaska' or 'AK')"
    puts "'STATES' - See a list of states and territories"
    puts "'EXIT' - Exit this program"

    
    main_menu_input
  end

  def main_menu_input
    user_input = gets.strip

    if user_input.downcase == "states"
      list_states_and_territories
      main_menu
    elsif user_input.downcase == "exit"
      goodbye
    elsif is_a_state_code?(user_input)
      reformatted = user_input.upcase #turns ny or Ny into NY
      @current_state = NPExplorer::State.find_state_by_code(reformatted)
      load_parks_by_state(@current_state) if @current_state.parks.length == 0
      list_parks_in_state(@current_state)
      sub_menu_parks
    elsif is_a_state_name?(user_input)
      reformatted = user_input.split(" ").each{|str| str.capitalize!}.join(" ") #turns new york or New york into New York
      @current_state = NPExplorer::State.find_state_by_name(reformatted)
      load_parks_by_state(@current_state) if @current_state.parks.length == 0
      list_parks_in_state(@current_state)
      sub_menu_parks
    else 
      puts "Sorry, that is not a valid entry. Please follow the instructions below:"
      main_menu
    end
  end


  def sub_menu_parks
    puts "\n\n"
    puts "Enter the NUMBER of a park above for more information"
    puts "Enter a STATE NAME or code to see a list of National Parks in that state"
    puts "'TOUR' - See descriptions of all national parks in #{@current_state.name}"
    puts "'STATES' - See a list of states and territories"
    puts "'EXIT' - Exit this program"

    sub_menu_parks_input
  end

  def sub_menu_park_details
    puts "\n\n"
    puts "Enter a STATE NAME or code to see a list of National Parks in that state"
    puts "'LIST' - to go back to the list of parks in #{@current_state.name}\n"
    puts "'STATES' - See a list of states and territories"
    puts "'EXIT' - Exit this program"

    sub_menu_parks_input
  end

  def sub_menu_parks_input
    user_input = gets.strip

    if user_input.to_i > 0 && user_input.to_i <= @current_state.parks.length
      park = @current_state.parks[user_input.to_i - 1]
      display_park_information(park)
      sub_menu_park_details
    elsif user_input.downcase == "tour"
      tour_of_state
      sub_menu_parks
    elsif user_input.downcase == "list"
      list_parks_in_state(@current_state)
      sub_menu_parks
    elsif user_input.downcase == "states"
      list_states_and_territories
      main_menu
    elsif user_input.downcase == "exit"
      goodbye
    elsif is_a_state_code?(user_input)
      reformatted = user_input.upcase #turns ny or Ny into NY
      @current_state = NPExplorer::State.find_state_by_code(reformatted)
      load_parks_by_state(@current_state) if @current_state.parks.length == 0
      list_parks_in_state(@current_state)
      sub_menu_parks
    elsif is_a_state_name?(user_input)
      reformatted = user_input.split(" ").each{|str| str.capitalize!}.join(" ") #turns new york or New york into New York
      @current_state = NPExplorer::State.find_state_by_name(reformatted)
      load_parks_by_state(@current_state) if @current_state.parks.length == 0
      list_parks_in_state(@current_state)
      sub_menu_parks
    else 
      puts "Sorry, that is not a valid entry. Please follow the instructions below:"
      sub_menu_parks
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

  def load_parks_by_state(state)
    puts "Looking up National Parks in #{state.name}...\n\n"
    NPExplorer::APIAdapter.make_parks_from_data(state.code)
  end

  def list_parks_in_state(state)
    system('clear')
    puts "National Parks in #{state.name}:"
    state.parks.each.with_index(1) {|park, index| puts "#{index}. #{park.name}"}
  end

  def list_states_and_territories
    puts "\nStates & Territories: "
    NPExplorer::State.all.each {|state| puts "#{state.code} - #{state.name}" ; sleep(0.02)}
  end

  def tour_of_state
    @current_state.parks.each.with_index(1) do |park, index|
      puts "\n#{index}. #{park.name.upcase}"
      puts "\n#{park.description}\n\n"
      sleep(0.05)
    end 
  end

  def display_park_information(park)
    system('clear')
    puts "\n#{park.name.upcase}\n"
    puts "Designation: #{park.designation}"
    puts "\nDescription:\n"
    puts "#{park.description}"
    puts "\nDirections:\n"
    puts "#{park.directions}"
    puts "\nWeather Info:\n"
    puts "#{park.weather}"
  end

  def goodbye
    puts "Thank you for using National Parks Explorer. Goodbye!"
  end

  def print_welcome_screen
    WELCOME_SCREEN.each{|str| puts str}
    puts "\n\n"
  end
end