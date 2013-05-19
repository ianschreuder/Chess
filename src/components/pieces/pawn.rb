class Pawn < Piece

  def legal_moves(skip_king_checks=false)
    return [] if removed? 
    squares = @board.squares.reject{|s| !forward?(s) }
    squares.reject!{|s| (s.col - @square.col).abs > 1} # can't move sideways more than 1
    squares.reject!{|s| (s.row - @square.row).abs > 2} # can't move forward more than 2
    squares.reject!{|s| (s.col - @square.col).abs > 0 && (s.row - @square.row).abs > 1} # can't move sideways and forward more than 1 
    squares.reject!{|s| (s.row - @square.row).abs > 1} if moved? # can't move forward more than 1 if have moved
    squares.reject!{|s| (s.row - @square.row).abs > 1} if (@square.row != 1 && @square.row != 6) # can't move 2 if not on starting row
    squares.reject!{|s| (s.row - @square.row).abs == 1 && (s.col == @square.col) && @board.occupier(s) != nil} # can't attack straight ahead
    squares.reject!{|s| (s.col - @square.col).abs == 1 && !attackable?(s)} # legitimate diagonal attack?
    squares.reject!{|s| @board.blocked?(@square, s)}

    squares = remove_squares_that_place_me_in_check(squares) unless skip_king_checks
    squares
  end
  
  private

  def attackable?(square)
    return true if @board.en_passant_square == square

    return false unless (square.row - @square.row).abs == 1 && 
                       (square.col - @square.col).abs == 1 &&
                       @board.occupier(square) && 
                       @board.occupier(square).color != @color
    return true
  end

  def forward?(square)
    (@player.position==POSITION_ONE) ? @square.row < square.row : @square.row > square.row
  end
  
end