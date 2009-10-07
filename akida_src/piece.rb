=begin
 A piece is a representation of all the squares that a particular piece
 occupies for a given position - for example all the the white pawns
=end

require 'squares'
require 'bitboard'

class Piece

  Type = [:king, :queen, :rook, :bishop, :knight, :pawn]
  Side = [:black, :white]

  attr_reader :bitboard

  # Create a new Piece with an optional initial array of occupied bitboard
  def initialize(occupied=[])
    @bitboard = Bitboard.new
    occupied.each{|p| set!(p)}
  end

  # Test equality against other
  #   - other is a Piece
  def ==(other)
    @bitboard == other.bitboard
  end

  
  # Bitwise and with other returns a new Piece
  def &(other)
    make_piece @bitboard & other.bitboard
  end
 
  # Bitwise or with other returns a new Piece
  def |(other)
    make_piece @bitboard | other.bitboard
  end
  
  # Bitwise not 
  def ~()
    Bitboard.new(~@bitboard)
  end
  
  # Bitwise xor with other returns a new Piece
  def ^(other)
    make_piece @bitboard ^ other.bitboard
  end
  
  # Set a specific square: 
  #   - square can be expressed as a symbol (:a1,..,:h1,...,:h8)
  #     or as a string 'a1',..,'h1',...,'h8' (case - insensitive)
  def set!(square)
    @bitboard.set!(Squares.position(square))
  end
  
  # Clear a specific square: 
  #   - square can be expressed as a symbol (:a1,..,:h1,...,:h8)
  #     or as a string 'a1',..,'h1',...,'h8' (case - insensitive)
  def clear!(square)
    @bitboard.clear!(Squares.position(square))
  end
  
  # Check if a specific square is occupied
  #   - square can be expressed as a symbol (:a1,..,:h1,...,:h8)
  #     or as a string 'a1',..,'h1',...,'h8' (case - insensitive)
  def set?(square)
    @bitboard.set?(Squares.position(square))
  end

  # Check if a specific square is not occupied
  #   - square can be expressed as a symbol (:a1,..,:h1,...,:h8)
  #     or as a string 'a1',..,'h1',...,'h8' (case - insensitive)
  def clear?(square)
    @bitboard.clear?(Squares.position(square))
  end

  # array of bit-index for bits that are set
  def set_bits
    @bitboard.set_bits 
  end
  
  private
  def make_piece(bitboard)
    new_piece = Piece.new
    Squares.each_value{|pos| new_piece.set!(Squares.index(pos)) if bitboard.set?(pos)}
    new_piece
  end
end