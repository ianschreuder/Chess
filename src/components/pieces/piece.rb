class Piece
  attr_reader :color
  attr_accessor :square

  def initialize(player, square)
    @player = player
    @square = square
    @board = square.board
    @color = player.color
    @moves = []
  end

  def moved?
    !@moves.empty?
  end
  
  def move(new_square)
    move = Move.new(self,new_square)
    @last_square = @square
    @square = new_square
    @moves << move
    @board.moves << move
    move.execute
  end
  
  def removed?; @square.nil?; end
  def remove
    @square = nil
  end
  
  def remove_squares_that_place_me_in_check(squares)
    squares.reject! do |target_square| 
      move = Move.new(self, target_square)
      occupier = @board.occupier(target_square)
      move.set_target_piece(occupier) if occupier
      places_in_check?(move)
    end
    squares
  end
  
  def places_in_check?(move)
    king = @board.king_for_color(move.piece.color)
    return false unless king
    move.execute
    is_check = @board.in_check?(king)
    move.reset
    return is_check
  end
  
  def letter
    val = self.class.to_s.slice(0,1) unless self.class == Knight
    val = "N" if self.class == Knight
    val = val.downcase if self.color == WHITE
    return val
  end

  def to_s
    "id: #{object_id}; class: #{self.class}; square: #{@square}; color: #{color}"
  end

end