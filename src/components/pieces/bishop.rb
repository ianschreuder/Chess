# class Bishop < Piece
# 
#   def legal_moves(position, options={})
#     squares = Board.diagonals(@square)
#     squares.reject!{|target| position.blocked?(@square, target)}
#     squares.reject!{|target| position.occupier(target) != nil && position.occupier(target).color == @color }
# 
#     squares = remove_squares_that_place_me_in_check(position, squares) unless options[:bypass_king_checks]==true
# 
#     squares
#   end
# 
# end