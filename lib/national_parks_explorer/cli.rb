class CLI
  attr_accessor :current_state 
  
  def start
    system('clear') # clears terminal
    puts "Welcome to National Parks Explorer! \n\n"

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
    else user_input 
      load_and_list_parks
    end
  end

  def load_and_list_parks
    puts "Looking up parks in #{@current_state}..."
    APIAdapter.list_parks(APIAdapter.get_parks_by_state(@current_state), @current_state)
  end

  def list_states_and_territories
    puts "\nSTATES: "
    ALL_STATES.each {|state| puts "#{state[:code]} - #{state[:name]}"}
    puts "\nTERRITORIES: "
    ALL_TERRITORIES.each {|terr| puts "#{terr[:code]} - #{terr[:name]}"}
  end
end