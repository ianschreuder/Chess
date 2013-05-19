class Queen < Piece

  def legal_moves(skip_king_checks=false)
    return [] if removed? 
    squares = @board.straights(@square) + @board.diagonals(@square)
    squares.reject!{|target| @board.blocked?(@square, target)}
    squares.reject!{|target| @board.occupier(target) != nil && @board.occupier(target).color == @color }
    squares = remove_squares_that_place_me_in_check(squares) unless skip_king_checks
    squares
  end

end