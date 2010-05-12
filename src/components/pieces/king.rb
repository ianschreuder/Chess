class King < Piece

  def legal_moves(position, options={})
    squares = Board.squares.reject{|s| (s.row - @square.row).abs > 1} # can't move more than 1 in vertical direction
    squares.reject!{|s| (s.col - @square.col).abs > 2} # can't move more than 2 sideways, ever
    squares.reject!{|s| (s.col - @square.col).abs > 1} if moved? # can't move more than 1 if already had move
    squares.reject!{|s| (s.col - @square.col).abs > 1 && (s.row - @square.row).abs > 1} # can't move more than 1 diagonally
    squares.reject!{|s| position.occupier(s) != nil && position.occupier(s).color == @color}
    squares.reject!{|s| (s.col - @square.col).abs == 2 && !legal_castle?(position, s)}

    squares.reject!{|s| places_in_check?(position, s)} unless (options && options[:bypass_king_checks]==true)

    squares
  end

  private
  
  def legal_castle?(position, target)
    return false if moved? || target.row != @square.row || (target.col - @square.col).abs != 2
    rook = (@square.col > target.col) ? position.occupier(Square.new("a#{@square.row}")) : position.occupier(Square.new("h#{@square.row}"))
    return false if rook.nil? || rook.moved?
    return false if position.blocked?(@square,rook.square)
    return false if places_in_check?(position, @square)
    return false if places_in_check?(position, Board.path(@square,target)[0])
    return true
  end
  
end