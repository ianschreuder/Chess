class Rook < Piece

  def legal_moves(position, last_move)
    squares = @square.horizontals
    squares.reject!{|target| position.blocked?(@square, target)}
    squares.reject!{|target| position.occupier(target) != nil && position.occupier(target).color == @color }
    squares
  end

end