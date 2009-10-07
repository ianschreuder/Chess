require File.dirname(__FILE__) + '/piece'

class Player
  attr_reader :side, :pieces

  def initialize(side)
    @side = side
    initialize_pieces
  end

  private

  def initialize_pieces
    @pieces = []
    r1 = (@side == :white) ? "2" : "7"
    r2 = (@side == :white) ? "1" : "8"
    [:a, :b, :c, :d, :e, :f, :g, :h].each{|spot| @pieces << Piece.new(:pawn, "#{spot}#{r1}".to_sym) }
    [:a, :h].each{|spot| @pieces << Piece.new(:rook, "#{spot}#{r2}".to_sym) }
    [:b, :g].each{|spot| @pieces << Piece.new(:knight, "#{spot}#{r2}".to_sym) }
    [:c, :f].each{|spot| @pieces << Piece.new(:bishop, "#{spot}#{r2}".to_sym) }
    @pieces << Piece.new(:queen, "d#{r1}".to_sym)
    @pieces << Piece.new(:king, "e{r1}".to_sym)
  end

end