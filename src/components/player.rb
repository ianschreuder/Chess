# class Player
#   attr_reader :color
# 
#   def initialize(color)
#     @color = color
#   end
# 
#   def next_move(position)
#     valid_pieces = position.pieces(@color).reject{|piece| piece.legal_moves(position).empty? }
#     piece = valid_pieces[rand(valid_pieces.length)]
#     square = piece.legal_moves(position)[rand(piece.legal_moves(position).length)] if piece
#     Move.new(piece, square)
#   end
# 
#   private
# 
# end