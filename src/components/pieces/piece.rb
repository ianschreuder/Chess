class Piece
  attr_reader :square, :color

  def initialize(square, color=nil)
    @square = Square.new(square)
    @color = (!color.nil?) ? color : (@square.row < 5) ? :white : :black
    @moves = []
  end

  def moved?
    !@moves.empty?
  end
  
  def move(new_square)
    move = Move.new(self,new_square)
    @last_square = @square.clone
    @square = new_square
    @moves << move
  end
  
  def set_square(square)
    @square = square
  end
  
end