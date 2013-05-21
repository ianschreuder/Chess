class Board
  attr_reader :squares, :p1, :p2
  attr_reader :moves, :pieces
  
  def initialize(p1,p2)
    @squares = create_all_squares
    @p1, @p2 = p1, p2
    @p1.place_on_board(self,POSITION_ONE)
    @p2.place_on_board(self,POSITION_TW0)
    @moves = []
    init_position
  end
  def square_at(x=nil, y=nil, sym: nil)
    x,y = parse_symbol(sym) if sym
    return @squares.detect{|s| s.at?(x,y) }
  end
  def diagonals(sqr); @squares.select{|s| s.diagonal?(sqr)}; end
  def straights(sqr); @squares.select{|s| s.straight?(sqr)}; end
  def knight_squares(sqr); @squares.select{|s| ((s.x - sqr.x).abs == 1 && (s.y - sqr.y).abs == 2) || ((s.x - sqr.x).abs == 2 && (s.y - sqr.y).abs == 1) }; end
  def path(s1, s2)
    return [] if ((s1.x != s2.x && s1.y != s2.y) && (s1.x-s2.x).abs != (s1.y-s2.y).abs)
    return straight_path(s1,s2) if (s1.x == s2.x || s1.y == s2.y)
    return diagonal_path(s1,s2) if (s1.x - s2.x).abs == (s1.y - s2.y).abs
  end
  def straight_path(s1, s2)
    return false unless s1.x == s2.x || s1.y == s2.y
    return @squares.select{|s| s.x == s1.x && s.y < [s1.y,s2.y].max && s.y > [s1.y,s2.y].min} if (s1.x == s2.x)
    return @squares.select{|s| s.y == s1.y && s.x < [s1.x,s2.x].max && s.x > [s1.x,s2.x].min} if (s1.y == s2.y)
  end
  def diagonal_path(s1, s2)
    return false unless (s1.x - s2.x).abs == (s1.y - s2.y).abs
    return @squares.select{|s| s.x < [s1.x,s2.x].max && s.x > [s1.x,s2.x].min && 
                                     s.y < [s1.y,s2.y].max && s.y > [s1.y,s2.y].min &&
                                     (s1.x - s.x).abs == (s1.y - s.y).abs}
  end
  def occupier(square)
    piece = @pieces.detect{|piece| piece.square == square}
    piece = last_move.piece if piece.nil? && square == en_passant_square
    piece
  end
  def blocked?(source, target)
    squares = path(source,target)
    squares.detect{|sq| @pieces.detect{|p| p.square == sq}} != nil
  end
  def in_check?(king)
    pieces = (king.color == @p1.color) ? @p2.pieces : @p1.pieces
    pieces.detect{|piece| piece.legal_moves(true).include?(king.square)} != nil
  end
  def king_for_color(color)
    pieces = p1.color == color ? p1.pieces : p2.pieces
    pieces.detect{|piece| piece.is_a?(King) }
  end
  def en_passant_square
    return nil unless (last_move) && (last_move.piece.class == Pawn) && (last_move.piece_square_start.row - last_move.piece_square_end.row).abs == 2
    return path(last_move.piece_square_start, last_move.piece_square_end).first
  end

  def last_move; @moves.last; end

  def print
    board = 8.times.inject(""){|str,i| str << "#{8-i}|                \n"; str}
    board += "   a b c d e f g h \n"
    @pieces.each{|piece| idx= 19*(7-piece.square.y) + (2*piece.square.x) + 3; board[(idx..idx)]=piece.letter }
    puts board
  end

  def reset
    @moves.reverse.each{|m| m.reset }
  end

  def remove(piece)
    @pieces -= [piece]
    p1.pieces -= [piece]
    p2.pieces -= [piece]
  end
  def unremove(piece)
    @pieces += [piece]
    p1.pieces += [piece] if piece.color == @p1.color
    p2.pieces += [piece] if piece.color == @p2.color
  end
  def checkmate?(player)
    in_check?(player.king) && player.pieces.detect{|p| p.legal_moves.length > 0}.nil?
  end
  def stalemate?(player)
    (player.pieces.detect{|p| p.legal_moves.length > 0}.nil? && !in_check?(player.king)) ||
    stalemate_by_fifty_move_rule? ||
    stalemate_by_threefold_repetition?
  end

private

  def parse_symbol(sym)
    col = ('a'..'h').to_a.index(sym.to_s.slice(0,1).downcase)
    row = sym.to_s.slice(1,1).to_i-1
    [col,row]
  end

  def stalemate_by_fifty_move_rule?
    @moves.length >= 50 &&
    @moves.reverse[(0..49)].detect{|move| move.piece.is_a?(Pawn) || move.target != nil }.nil?
  end

  def stalemate_by_threefold_repetition?
    return false
  end

  def init_position
    @p1.pieces, @p2.pieces = [],[]
    (0..7).each{|col| @p1.pieces << Pawn.new(@p1, square_at(col,1)) }
    (0..7).each{|col| @p2.pieces << Pawn.new(@p2, square_at(col,6)) }
    [0,7].each{|col|  @p1.pieces << Rook.new(@p1, square_at(col,0)) }
    [0,7].each{|col|  @p2.pieces << Rook.new(@p2, square_at(col,7)) }
    [1,6].each{|col|  @p1.pieces << Knight.new(@p1, square_at(col,0)) }
    [1,6].each{|col|  @p2.pieces << Knight.new(@p2, square_at(col,7)) }
    [2,5].each{|col|  @p1.pieces << Bishop.new(@p1, square_at(col,0)) }
    [2,5].each{|col|  @p2.pieces << Bishop.new(@p2, square_at(col,7)) }
    @p1.pieces << Queen.new(@p1, square_at(3,0))
    @p2.pieces << Queen.new(@p2, square_at(3,7))
    @p1.pieces << King.new(@p1, square_at(4,0))
    @p2.pieces << King.new(@p2, square_at(4,7))
    @pieces = @p1.pieces + @p2.pieces
  end

  def create_all_squares
    (0..7).inject([]){|arr, i| (0..7).each{|j| arr << Square.new(self,i,j)}; arr}
  end

end
