class Queen < Piece

  def legal_moves(position, last_move=nil)
    squares = Board.horizontals(@square) + Board.diagonals(@square)
    squares.reject!{|target| position.blocked?(@square, target)}
    squares.reject!{|target| position.occupier(target) != nil && position.occupier(target).color == @color }
    squares
  end

end