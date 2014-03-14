class Cell
  attr_reader :state, :future_state

  def initialize
    starting_state
  end

  def starting_state
    if rand(2) == 0
      @state = false
    else
      @state = true
    end
  end

  def set_future_state(new_state)
    @future_state = new_state
  end

  def set_current_state(new_state)
    @future_state = new_state
  end
end
