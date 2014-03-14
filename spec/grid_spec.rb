require 'rspec'
require 'grid'

describe Grid do
  describe 'initialize' do
    it 'creates a grid to hold cells with a width and height' do
      new_grid = Grid.new(20,20)
      new_grid.should be_an_instance_of Grid
    end
  end

  describe '#live_neighbors' do
    it 'tells how many neighbors are living around a given cell' do
      new_grid = Grid.new(20,20)
      new_grid.live_neighbors([3,6]).should >= 0
      new_grid.live_neighbors([3,6]).should < 9
    end
  end

  describe '#set_future_states' do
    it "sets all cells in @population to correct future_state value based on current_state and live_neighbors" do
      new_grid = Grid.new(20,20)
      new_grid.set_future_states
      new_grid.population[[2,3]].future_state.should_not eq nil
    end
  end

  describe '#change_states' do
    it 'sets all cells current_state equal to their current future_state and empties future_state' do
      new_grid = Grid.new(20, 20)
      new_grid.set_future_states
      new_grid.change_states
      new_grid.population[[10,10]].future_state.should eq nil
    end
  end
end
