=begin
  A position contains all the pieces present on a board at a particual point in a game
=end

require 'piece'

class Position

  attr_reader :white, :black
  
  # Create a new Position with an optional set of initial white and black squares
  def initialize(white={}, black={})
    @white = white
    @black = black
  end

  # Check what occupies square and return [Piece::Side, Piece::Type] or nil 
  # Raise an ArgumentError if an invalid square is specified
  def [](square)
    raise ArgumentError, "#{square} is not a valid square, :a1,...,:h8 expected" unless Squares.include?(square)
    @white.each { |piece, position| return [:white, piece] if position.set?(square) }
    @black.each { |piece, position| return [:black, piece] if position.set?(square) }
    nil    
  end

  # Check if the square is occupied
  def set?(square)
    self[square]
  end  

  def clear?(square)
    !self[square]
  end

  # Set square to be occupied by piece which is [Piece::Side, Piece::Type] or nil
  # nil will clear the square
  def []=(square, piece)
    raise ArgumentError unless Squares.include?(square) 

    return clear!(square) if piece.nil? 

    raise ArgumentError unless Piece::Side.include?(piece[0])
    raise ArgumentError unless Piece::Type.include?(piece[1])

    if piece[0] == :white 
      @white[piece[1]].set!(square) 
    else
      @black[piece[1]].set!(square) 
    end
    self[square]
  end
  
  # Return a Bitboard containing the positions of all pieces
  def all_pieces
    self.white_pieces | self.black_pieces
  end

  # Return a Bitboard containing the positions of all white pieces
  def white_pieces
    all = Bitboard.new
    @white.each_value{|piece| all |= piece.bitboard }
    all
  end

  # Return a Bitboard containing the positions of all black pieces
  def black_pieces
    all = Bitboard.new
    @black.each_value{|piece| all |= piece.bitboard }
    all
  end
  
  private
  # Clear square
  def clear!(square)
    piece = self[square]
    if piece[0] == :white 
      @white[piece[1]].clear! square
    else
      @black[piece[1]].clear! square
    end
    nil
  end
  
end