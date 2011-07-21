# class Pawn < Piece
# 
#   def legal_moves(position, options={})
#     squares = Board.squares.reject{|s| !forward?(s) }
#     squares.reject!{|s| (s.col - @square.col).abs > 1} # can't move sideways more than 1
#     squares.reject!{|s| (s.row - @square.row).abs > 2} # can't move forward more than 2
#     squares.reject!{|s| (s.col - @square.col).abs > 0 && (s.row - @square.row).abs > 1} # can't move sideways and forward more than 1 
#     squares.reject!{|s| (s.row - @square.row).abs > 1} if moved? # can't move forward more than 1 if have moved
#     squares.reject!{|s| (s.row - @square.row).abs > 1} if (@square.row != 2 && @square.row != 7) # can't move 2 if not on starting row
#     squares.reject!{|s| (s.row - @square.row).abs == 1 && (s.col == @square.col) && position.occupier(s) != nil} # can't attack straight ahead
#     squares.reject!{|s| (s.col - @square.col).abs == 1 && !attackable?(s, position)} # legitimate diagonal attack?
#     squares.reject!{|s| position.blocked?(@square, s)}
# 
#     squares = remove_squares_that_place_me_in_check(position, squares) unless options[:bypass_king_checks]==true
#     
#     squares
#   end
#   
#   private
# 
#   # override piece method in order to take en passant into consideration
#   def remove_squares_that_place_me_in_check(position, squares)
#     squares.reject! do |target_square| 
#       move = Move.new(self, target_square)
#       occupier = position.occupier(target_square)
#       occupier = position.last_move.piece if target_square == en_passant_square(position)
#       move.set_target_piece(occupier) if occupier
#       places_in_check?(position, move)
#     end
#     squares
#   end
# 
#   def attackable?(square, position)
#     ep_square = en_passant_square(position)
#     return true if ep_square == square
#     return false unless (square.row - @square.row).abs == 1 && 
#                        (square.col - @square.col).abs == 1 &&
#                        position.occupier(square) && 
#                        position.occupier(square).color != @color
#     return true
#   end
# 
#   def en_passant_square(position)
#     last_move = position.last_move
#     return nil unless (last_move) && (last_move.piece.class == Pawn) && (last_move.piece_square_start.row - last_move.piece_square_end.row).abs == 2
#     return Board.path(last_move.piece_square_start, last_move.piece_square_end)[0]
#   end
# 
#   def forward?(square)
#     (@color == :white) ? @square.row < square.row : @square.row > square.row
#   end
#   
# end