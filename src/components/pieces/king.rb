# class King < Piece
# 
#   def legal_moves(position, options={})
#     squares = Board.squares.reject{|s| (s.row - @square.row).abs > 1} # can't move more than 1 in vertical direction
#     squares.reject!{|s| (s.col - @square.col).abs > 2} # can't move more than 2 sideways, ever
#     squares.reject!{|s| (s.col - @square.col).abs > 1} if moved? # can't move more than 1 if already had move
#     squares.reject!{|s| (s.col - @square.col).abs > 1 && (s.row - @square.row).abs > 1} # can't move more than 1 diagonally
#     squares.reject!{|s| position.occupier(s) != nil && position.occupier(s).color == @color}
#     squares.reject!{|s| (s.col - @square.col).abs == 2 && !legal_castle?(position, s)}
# 
#     squares = remove_squares_that_place_me_in_check(position, squares) unless options[:bypass_king_checks]==true
# 
#     squares
#   end
# 
#   private
#   
#   def legal_castle?(position, target)
#     return false if moved? || target.row != @square.row || (target.col - @square.col).abs != 2
#     rook = (@square.col > target.col) ? position.occupier(Square.new("a#{@square.row}")) : position.occupier(Square.new("h#{@square.row}"))
#     return false if rook.nil? || rook.moved?
#     return false if position.blocked?(@square,rook.square)
# 
#     return false if position.in_check?(self)
#     return false if castle_through_check?(position, rook)
#     return false if castle_into_check?(position, rook)
#     return true
#   end
#   
#   def castle_through_check?(position, rook)
#     col = self.square.col+(rook.square.col-self.square.col).abs/(rook.square.col-self.square.col)
#     square = Square.new("#{Square.to_letter(col)}#{rook.square.row}")
#     move = Move.new(self, square)
#     return places_in_check?(position, move)
#   end
#   
#   def castle_into_check?(position, rook)
#     move = Move.new(self, rook.square)
#     move.set_ancillary_piece(rook, @square)
#     return places_in_check?(position, move)
#   end
#   
# end