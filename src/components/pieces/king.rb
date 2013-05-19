class King < Piece

  def legal_moves(skip_king_checks=false)
    return [] if removed? 
    squares = @board.squares.reject{|s| (s.row - @square.row).abs > 1} # can't move more than 1 in vertical direction
    squares.reject!{|s| (s.col - @square.col).abs > 2} # can't move more than 2 sideways, ever
    squares.reject!{|s| (s.col - @square.col).abs > 1} if moved? # can't move more than 1 if already had move
    squares.reject!{|s| (s.col - @square.col).abs > 1 && (s.row - @square.row).abs > 1} # can't move more than 1 diagonally
    squares.reject!{|s| @board.occupier(s) != nil && @board.occupier(s).color == @color}
    squares.reject!{|s| (s.col - @square.col).abs == 2 && !legal_castle?(s)}

    squares = remove_squares_that_place_me_in_check(squares) unless skip_king_checks

    squares
  end

  private
  
  def legal_castle?(target)
    return false if moved? || target.row != @square.row || (target.col - @square.col).abs != 2
    rook = (@square.col > target.col) ? @board.occupier(@board.square_at(0,@square.row)) : @board.occupier(@board.square_at(7,@square.row))
    return false if rook.nil? || rook.moved?
    return false if @board.blocked?(@square,rook.square)

    return false if @board.in_check?(self)
    return false if castle_through_check?(rook)
    return false if castle_into_check?(rook)
    return true
  end
  
  def castle_through_check?(rook)
    change = rook.square.col > @square.col ? 1 : -1
    square = @board.square_at(@square.col + change, @square.row)
    move = Move.new(self, square)
    return places_in_check?(move)
  end
  
  def castle_into_check?(rook)
    change = rook.square.col > @square.col ? 2 : -2
    king_square = @board.square_at(@square.col + change, @square.row)
    rook_square = @board.square_at(rook.square.col - change, rook.square.row)
    move = Move.new(self, king_square)
    move.set_ancillary_piece(rook, rook_square)
    return places_in_check?(move)
  end
  
end