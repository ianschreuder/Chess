class Pawn < Piece

  def legal_moves(position, last_move=nil)
    squares = Board.squares.reject{|s| !forward?(s) }
    squares.reject!{|s| (s.col - @square.col).abs > 1} # can't move sideways more than 1
    squares.reject!{|s| (s.row - @square.row).abs > 2} # can't move forward more than 2
    squares.reject!{|s| (s.col - @square.col).abs > 0 && (s.row - @square.row).abs > 1} # can't move sideways and forward more than 1 
    squares.reject!{|s| (s.row - @square.row).abs > 1} if moved? # can't move forward more than 1 if have moved
    squares.reject!{|s| (s.row - @square.row).abs == 1 && (s.col == @square.col) && position.occupier(s) != nil} # can't attack straight ahead
    squares.reject!{|s| (s.col - @square.col).abs == 1 && !attackable?(s, position, last_move)} # legitimate diagonal attack?
    squares.reject!{|s| position.blocked?(@square, s)}
    squares
  end
  
  def attackable?(square, position, last_move=nil)
    return true if en_passant_square(last_move) == square
    return false unless (square.row - @square.row).abs == 1 && 
                       (square.col - @square.col).abs == 1 &&
                       position.occupier(square) && 
                       position.occupier(square).color != @color
    return true
  end

  private

  def en_passant_square(last_move)
    return nil unless (last_move) && 
                      (last_move.piece.class == Pawn) && 
                      ((last_move.square_s.row - last_move.square_e.row).abs == 2) && 
                      (last_move.square_e.row == @square.row) && 
                      ((last_move.square_e.col - @square.col).abs == 1)
    row = last_move.square_e.row - ((last_move.square_e.row - last_move.square_s.row) / 2) 
    return Square.new(last_move.square_e.col*10+row)
  end

  def forward?(square)
    (@color == :white) ? @square.row < square.row : @square.row > square.row
  end
  
end