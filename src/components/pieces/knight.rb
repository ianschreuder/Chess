class Knight < Piece

  def legal_moves(position, options={})
    squares = Board.knight_squares(@square)
    squares.reject!{|target| position.blocked?(@square, target)}
    squares.reject!{|target| position.occupier(target) != nil && position.occupier(target).color == @color }
    squares = remove_squares_that_place_me_in_check(position, squares)
    
    squares
  end

end