class Square
  attr_reader :spot
  
  def initialize(spot)
    @spot = spot
  end

  def start_white?
    ["1","2"].include?(@spot.to_s[-1])
  end
  
  def start_black?
    ["7","8"].include?(@spot.to_s[-1])
  end
end