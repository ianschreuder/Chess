# class Position
#   attr_reader :moves
  
#   def initialize(game)
#     @game = game
#     @board = game.board
#     @white_pieces = []
#     @black_pieces = []
#     @moves = []
#   end

#   def blocked?(source, target)
#     squares = Board.path(source,target)
#     squares.detect{|sq| all_pieces.detect{|p| p.square == sq}} != nil
#   end
  
#   def occupier(square)
#     all_pieces.detect{|piece| piece.square == square}
#   end
  
#   def new_game_setup
#     @white_pieces = []
#     @black_pieces = []
#     (0..7).each{|col| @white_pieces << Pawn.new(Square.new(col,1)); @black_pieces << Pawn.new(Square.new(col,6)) }
#     [0,7].each{|col| @white_pieces << Rook.new(Square.new(col,0)); @black_pieces << Rook.new(Square.new(col,7)) }
#     [1,6].each{|col| @white_pieces << Knight.new(Square.new(col,0)); @black_pieces << Knight.new(Square.new(col,7)) }
#     [2,5].each{|col| @white_pieces << Bishop.new(Square.new(col,0)); @black_pieces << Bishop.new(Square.new(col,7)) }
#     @white_pieces << Queen.new(Square.new(3,0))
#     @black_pieces << Queen.new(Square.new(3,7))
#     @white_pieces << King.new(Square.new(4,0))
#     @black_pieces << King.new(Square.new(4,7))
#   end
  
#   def in_check?(king)
#     pieces = (king.color == :white) ? black_pieces : white_pieces
#     pieces.detect{|piece| piece.legal_moves(self, {:bypass_king_checks => true}).include?(king.square)} != nil
#   end

#   def white_pieces
#     @white_pieces.reject{|p| p.square.nil?}
#   end

#   def black_pieces
#     @black_pieces.reject{|p| p.square.nil?}
#   end

#   def pieces(color)
#     (color == :white) ? white_pieces : black_pieces
#   end

#   def all_pieces
#     white_pieces + black_pieces
#   end
  
#   def update_with_move(move)
#     move.execute
#     move.piece.move(move.piece_square_end)
#     @moves << move
#   end

#   def last_move
#     @moves.last
#   end

#   def king_for_color(color)
#     (color == :white) ? white_pieces.detect{|piece| piece.class == King} : black_pieces.detect{|piece| piece.class == King}
#   end
  
#   def print
#     board = "8"+"  "*8+"\n7"+"  "*8+"\n6"+"  "*8+"\n5"+"  "*8+"\n4"+"  "*8+"\n3"+"  "*8+"\n2"+"  "*8+"\n1"+"  "*8+"\n  a b c d e f g h"
#     board = black_pieces.inject(board){|board, piece| idx = (((8-piece.square.row)*18)+2*piece.square.col); board = board[0,idx]+piece.letter+board[idx+1,board.length]}
#     board = white_pieces.inject(board){|board, piece| idx = (((8-piece.square.row)*18)+2*piece.square.col); board = board[0,idx]+piece.letter+board[idx+1,board.length]}
#     puts board
#   end
  
# end
