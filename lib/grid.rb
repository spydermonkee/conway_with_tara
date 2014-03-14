class Grid

  attr_reader :population, :grid_x, :grid_y

  def initialize(x, y)
    @grid_x = x
    @grid_y = y
    @population = {}
    1.upto(x) do |x_value|
      1.upto(y) do |y_value|
        coordinates = [x_value, y_value]
        @population[coordinates] = Cell.new()
      end
    end
  end

  def change_states
    @population.each_value do |cell|
      cell.set_current_state(cell.future_state)
      cell.set_future_state(nil)
    end
  end

  def live_neighbors(coordinates)
    current_cell = @population[coordinates]
    live_neighbors = 0
    if coordinates[0] == 1 && coordinates[1] == 1
      (coordinates[0]).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1]).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[0] == 1 && coordinates[1] == @grid_y
      (coordinates[0]).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1]) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[0] == @grid_x && coordinates[1] == 1
      (coordinates[0] - 1).upto(coordinates[0]) do |x_coordinate|
        (coordinates[1]).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[0] == @grid_x && coordinates[1] == @grid_y
      (coordinates[0] - 1).upto(coordinates[0]) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1]) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[0] == 1
      (coordinates[0]).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[1] == 1
      (coordinates[0] - 1).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1]).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates[0] == @grid_x
      (coordinates[0] - 1).upto(coordinates[0]) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    elsif coordinates [1] == @grid_y
      (coordinates[0] - 1).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1]) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    else
      (coordinates[0] - 1).upto(coordinates[0] + 1) do |x_coordinate|
        (coordinates[1] - 1).upto(coordinates[1] + 1) do |y_coordinate|
          neighbor_coordinates = [x_coordinate, y_coordinate]
          if @population[neighbor_coordinates].state && !neighbor_coordinates.eql?(coordinates)
            live_neighbors += 1
          end
        end
      end
    end
    live_neighbors
  end

  def set_future_states
    @population.each_key do |cell_coords_set|
      if @population[cell_coords_set].state
        if live_neighbors(cell_coords_set) >= 2 && live_neighbors(cell_coords_set) <= 3
          @population[cell_coords_set].set_future_state(true)
        else
          @population[cell_coords_set].set_future_state(false)
        end
      else
        if live_neighbors(cell_coords_set) == 3
          @population[cell_coords_set].set_future_state(true)
        else
          @population[cell_coords_set].set_future_state(false)
        end
      end
    end
  end


end








