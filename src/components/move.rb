# class Move
#   attr_reader :piece, :piece_square_start, :piece_square_end
# 
#   def initialize(piece, target_square)
#     @piece = piece
#     @piece_square_start = piece.square
#     @piece_square_end = target_square
#   end
#   
#   def set_target_piece(piece)
#     @target = piece
#     @target_square_start = piece.square
#   end
#   
#   def set_ancillary_piece(piece, target_square)
#     @ancillary = piece
#     @ancillary_sqaure_start = piece.square
#     @ancillary_square_end = target_square
#   end
#   
#   def execute
#     @piece.square = @piece_square_end
#     @target.remove if @target
#     @ancillary.square = @ancillary_square_end if @ancillary
#   end
#   
#   def reset
#     @piece.square = @piece_square_start
#     @target.square = @target_square_start if @target
#     @ancillary.square = @ancillary_sqaure_start if @ancillary
#   end
#   
#   def to_s
#     "#{@piece}: #{@piece_square_start} => #{@piece_square_end}"
#   end
#     
# end