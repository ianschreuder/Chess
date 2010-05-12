class Position
  
  def initialize(set_pieces=[])
    @white_pieces = set_pieces.select{|pi| pi.color == :white}
    @black_pieces = set_pieces.select{|pi| pi.color == :black}
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
    pieces = (king.color == :white) ? black_pieces : white_pieces
    pieces.detect{|piece| piece.legal_moves(self, {:bypass_king_checks => true}).include?(king.square)} != nil
  end

  def white_pieces
    @white_pieces.reject{|p| p.square.nil?}
  end

  def black_pieces
    @black_pieces.reject{|p| p.square.nil?}
  end

  def pieces(color)
    (color == :white) ? white_pieces : black_pieces
  end

  def all_pieces
    white_pieces + black_pieces
  end
  
  def update_with_move(move)
    move.execute
    @moves << move
  end

  def last_move
    @moves.last
  end

  def king_for_color(color)
    (color == :white) ? white_pieces.detect{|piece| piece.class == King} : black_pieces.detect{|piece| piece.class == King}
  end
  
  def print
    board = "8"+"  "*8+"\n7"+"  "*8+"\n6"+"  "*8+"\n5"+"  "*8+"\n4"+"  "*8+"\n3"+"  "*8+"\n2"+"  "*8+"\n1"+"  "*8+"\n  a b c d e f g h"
    board = black_pieces.inject(board){|board, piece| idx = (((8-piece.square.row)*18)+2*piece.square.col); board = board[0,idx]+piece.letter+board[idx+1,board.length]}
    board = white_pieces.inject(board){|board, piece| idx = (((8-piece.square.row)*18)+2*piece.square.col); board = board[0,idx]+piece.letter+board[idx+1,board.length]}
    puts board
  end
  
end
