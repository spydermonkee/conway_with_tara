class Grid

  attr_reader :population, :grid_x, :grid_y, :bottom_edge_hash, :top_edge_hash, :left_edge_hash, :right_edge_hash, :corners_hash, :the_chosen_cells_hash

  def initialize(x, y)
    @grid_x = x
    @grid_y = y
    @population = {}
    initialize_hashes
  end

  def initialize_hashes
    @left_edge_hash = {}
    @right_edge_hash = {}
    @top_edge_hash = {}
    @bottom_edge_hash = {}
    @corners_hash = {}
    @the_chosen_cells_hash = {}
  end

  def self.create(x,y)
    new_grid = Grid.new(x,y)
    new_grid.build_population(x,y)
    new_grid.build_unique_hashes
    new_grid
  end

  def build_unique_hashes
    build_left_edge_hash
    build_right_edge_hash
    build_bottom_edge_hash
    build_top_edge_hash
    build_corners_hash
    build_chosen_cells_hash
  end

  def build_population(x,y)
    1.upto(x) do |x_value|
      1.upto(y) do |y_value|
        @population[[x_value, y_value]] = Cell.new()
      end
    end
  end

  def build_chosen_cells_hash
    2.upto(@grid_x-1) do |x_value|
      2.upto(@grid_y-1) do |y_value|
        @the_chosen_cells_hash[[x_value, y_value]] = @population[[x_value, y_value]]
      end
    end
  end

  def build_left_edge_hash
    @population.each_key do |coordinates|
      if coordinates[0] == 1 && (coordinates[1] != 1 || coordinates[1] != @grid_y)
        @left_edge_hash[coordinates] = @population[coordinates]
      end
    end
  end

  def build_right_edge_hash
    @population.each_key do |coordinates|
      if coordinates[0] == @grid_x && (coordinates[1] != 1 || coordinates[1] != @grid_y)
        @right_edge_hash[coordinates] = @population[coordinates]
      end
    end
  end

  def build_bottom_edge_hash
    @population.each_key do |coordinates|
      if coordinates[1] == 1 && (coordinates[0] != 1 || coordinates[0] != @grid_x)
        @bottom_edge_hash[coordinates] = @population[coordinates]
      end
    end
  end

  def build_top_edge_hash
    @population.each_key do |coordinates|
      if coordinates[1] == @grid_y && (coordinates[0] != 1 || coordinates[0] != @grid_x)
        @top_edge_hash[coordinates] = @population[coordinates]
      end
    end
  end

  def build_corners_hash
    @population.each_key do |coordinates|
      if coordinates == [1,1] || coordinates == [1, @grid_y] || coordinates == [@grid_x, 1] || coordinates == [@grid_x, @grid_y]
        @corners_hash[coordinates] = @population[coordinates]
      end
    end
  end

  def change_states
    @population.each_value do |cell|
      cell.set_current_state(cell.future_state)
      cell.set_future_state(nil)
    end
  end


  def the_chosen_future_states
    live_neighbors = 0
    @the_chosen_cells_hash.each_key do |coordinates|
      for i in -1..1
        for j in -1..1
          if @population[[coordinates[0] + i, coordinates[1] + j]].state && (i != 0 && j != 0)
            live_neighbors += 1
          end
        end
      end
      set_future_states(coordinates, live_neighbors)
    end
  end

  def the_top_future_states
    live_neighbors = 0
    @top_edge_hash.each_key do |coordinates|
      for i in -1..1
        for j in -1..0
          if @population[[coordinates[0] + i, coordinates[1] + j]].state && (i != 0 && j != 0)
            live_neighbors += 1
          end
        end
      end
      for k in -1..1
        if @population[[coordinates[0] + k, coordinates[1] - @grid_y + 1 ]].state
            live_neighbors += 1
        end
      end
      set_future_states(coordinates, live_neighbors)
    end
  end

  def the_left_future_states
    live_neighbors = 0
    @left_edge_hash.each_key do |coordinates|
      for i in 0..1
        for j in -1..1
          if @population[[coordinates[0] + i, coordinates[1] + j]].state && (i != 0 && j != 0)
            live_neighbors += 1
          end
        end
      end
      for k in -1..1
        if @population[[coordinates[0] + @grid_x - 1, coordinates[1] + k]].state
            live_neighbors += 1
        end
      end
      set_future_states(coordinates, live_neighbors)
    end
  end

  def the_bottom_future_states
  end


  def set_future_states(cell_coords_set, live_neighbors)
    if @population[cell_coords_set].state
      set_future_for_alive(cell_coords_set, live_neighbors)
    else
      set_future_for_dead(cell_coords_set, live_neighbors)
    end
  end

  def set_future_for_alive(cell_coords_set, live_neighbors)
    if live_neighbors >= 2 && live_neighbors <= 3
      @population[cell_coords_set].set_future_state(true)
    else
      @population[cell_coords_set].set_future_state(false)
    end
  end

  def set_future_for_dead(cell_coords_set, live_neighbors)
    if live_neighbors == 3
      @population[cell_coords_set].set_future_state(true)
    else
      @population[cell_coords_set].set_future_state(false)
    end
  end
end








