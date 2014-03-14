require 'rspec'
require 'cell'

describe Cell do
  describe 'initialize' do
    it 'creates a cell' do
      new_cell = Cell.new
      new_cell.should be_an_instance_of Cell
    end

  end

  describe 'starting_state' do
    it 'gives a cell a random alive/dead starting state' do
      new_cell = Cell.new
      new_cell.state.should_not eq nil
    end
  end
end
