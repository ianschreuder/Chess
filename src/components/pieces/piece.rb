class Piece
  attr_reader :color
  attr_accessor :square

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
  
  def remove
    self.square = nil
  end
  
  def remove_squares_that_place_me_in_check(position, squares)
    squares.reject! do |target_square| 
      move = Move.new(self, target_square)
      occupier = position.occupier(target_square)
      move.set_target_piece(occupier) if occupier
      places_in_check?(position, move)
    end
    squares
  end
  
  def places_in_check?(position, move)
    king = position.king_for_color(move.piece.color)
    return false unless king
    move.execute
    is_check = position.in_check?(king)
    move.reset
    return is_check
  end
  
  def letter
    val = self.class.to_s.slice(0,1) unless self.class == Knight
    val = "N" if self.class == Knight
    val = val.downcase if self.color == :white
    return val
  end
  
end