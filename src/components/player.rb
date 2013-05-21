class Player
  attr_reader :color, :position
  attr_accessor :pieces

  def initialize(color)
    @color = color
    @pieces = []
  end

  def place_on_board(board,position)
    @board = board
    @position = position
  end

  def next_move
    return pure_random_move
  end

  def king; pieces.detect{|p| p.is_a?(King) }; end

  private

  def pure_random_move
    valid_pieces = @pieces.select{|piece| piece.legal_moves(@board).length > 0 }
    piece = valid_pieces[rand(valid_pieces.length)]
    square = piece.legal_moves(@board)[rand(piece.legal_moves(@board).length)] if piece
    Move.new(piece, square)
  end

end