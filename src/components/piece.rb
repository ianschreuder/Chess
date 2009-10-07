require File.dirname(__FILE__) + '/square'

class Piece
  Type = [:king, :queen, :rook, :bishop, :knight, :pawn]
  Side = [:black, :white]

  def initialize(type, spot)
    @type = Type.detect{|t| t == type}
    @square = Square.new(spot)
    @side = (@square.start_white?) ? :white : :black
  end
end