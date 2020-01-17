class NPExplorer::CLI
  attr_accessor :current_state
  
  def start
    system('clear') # clears terminal

    puts "Welcome to National Parks Explorer! \n\n"
    NPExplorer::APIAdapter.create_all_states
    main_menu
  end 

  def main_menu
    puts "Enter the name of a US state or territory or its state code to see a list of national parks in that state."
    puts "To see a list of states and territories and their codes enter 'states'"
    puts "To exit this program, enter 'exit'"
    
    main_menu_input
  end

  def main_menu_input
    user_input = gets.strip
    @current_state = user_input.upcase

    if user_input.downcase == "states"
      list_states_and_territories
      puts "\n"
      main_menu
    elsif user_input.downcase == "exit"
      goodbye
    elsif represents_a_state?(user_input)
      load_and_list_parks
      main_menu
    else 
      puts "Sorry, that is not a valid entry. Please follow the instructions below:"
      main_menu
    end
  end

  def represents_a_state?(string)
    state_names = ALL_STATES.map {|state| state[:name]}
    state_codes = ALL_STATES.map {|state| state[:code]}
    
    if state_names.include?(string.split(" ").each{|str| str.capitalize!}.join(" "))
      @current_state = ALL_STATES.find {|state| state[:name] == string.split(" ").each{|str| str.capitalize!}.join(" ")}[:code]
      return true
    elsif state_codes.include?(string.upcase)
      @current_state = string.upcase 
      return true
    else
      return false
    end
  end

  def load_and_list_parks
    puts "Looking up parks in #{@current_state}..."
    NPExplorer::APIAdapter.list_parks(NPExplorer::APIAdapter.make_parks_from_data(@current_state), @current_state)
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