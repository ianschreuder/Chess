class Piece
  attr_reader :square, :color

  def initialize(square, color=nil)
    @square = Square.new(square)
    @color = (!color.nil?) ? color : (@square.row < 5) ? :white : :black
  end

  def legal_moves(position, last_move)
    []
  end
  
  
  
end