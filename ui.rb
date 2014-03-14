require './lib/grid'
require './lib/cell'

@current_grid

def start_menu
  system('clear')
  puts "Hello and welcom to Ben and Spyder's Game of Life! What dimension grid would you like to create?"
  puts "Enter your x dimension:"
  x_dim = gets.chomp.to_i
  puts "Enter your y dimension:"
  y_dim = gets.chomp.to_i
  @current_grid = Grid.new(x_dim, y_dim)
  main_menu
end

def main_menu
  system('clear')
  display_grid
  puts "\nPress enter to show the next generation or 'x' to exit."
  choice = gets.chomp
  if choice == 'x'
    puts "Goodbye, friend."
    exit
  else
    @current_grid.set_future_states
    @current_grid.change_states
    main_menu
  end
end

def display_grid
  grid_width = @current_grid.grid_x
  grid_counter = 0
  @current_grid.population.each_value do |cell|
    if cell.state
      print "A "
    else
      print "d "
    end
    if grid_counter == grid_width
      print "\n"
      grid_counter = 0
    else
      grid_counter += 1
    end
  end
end

start_menu




