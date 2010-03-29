class Position
  attr_reader :white_pieces, :black_pieces
  
  def initialize(pieces=[])
    @white_pieces = pieces.select{|pi| pi.color == :white}
    @black_pieces = pieces.select{|pi| pi.color == :black}
    @moves = []
  end

  def blocked?(source, target)
    squares = Board.path(source,target)
    squares.detect{|sq| all_pieces.detect{|p| p.square == sq}} != nil
  end
  
  def occupier(square)
    all_pieces.detect{|piece| piece.square == square}
  end
  
  def new_game_setup
    @white_pieces = []
    @black_pieces = []
    %w(a b c d e f g h).each{|ltr| @white_pieces << Pawn.new(ltr+"2".to_sym); @black_pieces << Pawn.new(ltr+"7".to_sym) }
    %w(a h).each{|ltr| @white_pieces << Rook.new(ltr+"1".to_sym); @black_pieces << Rook.new(ltr+"8".to_sym) }
    %w(b g).each{|ltr| @white_pieces << Knight.new(ltr+"1".to_sym); @black_pieces << Knight.new(ltr+"8".to_sym) }
    %w(c f).each{|ltr| @white_pieces << Bishop.new(ltr+"1".to_sym); @black_pieces << Bishop.new(ltr+"8".to_sym) }
    @white_pieces << Queen.new(:d1)
    @black_pieces << Queen.new(:d8)
    @white_pieces << King.new(:e1)
    @black_pieces << King.new(:e8)
  end
  
  def in_check?(king)
    pieces = (king.color == :white) ? @black_pieces : @white_pieces
    pieces.detect{|piece| piece.legal_moves(self).include?(king.square)} != nil
  end

  def all_pieces
    @white_pieces + @black_pieces
  end
  
  def update_with_move(move)
    move.execute
    @moves << move
  end

  def last_move
    @moves.last
  end

  def stalemate?(last_move)
#     pieces = (last_move.piece.color == :white) ? @black_pieces : @white_pieces
#     moves = pieces.map{|piece| piece.legal_moves(self,last_move)}.flatten
# p moves
#     moves.empty? && !pieces.detect{|piece| piece.class==King}.in_check?(self)
  end
  
end