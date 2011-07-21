require File.dirname(__FILE__) + '/../../spec_helper'

describe "Bishop" do
  
  it "should list all diagonal squares on an empty board" do
    piece = Bishop.new(:a1, :white)
    piece.legal_moves(Position.new([piece])).length.should == 7
    piece.legal_moves(Position.new([piece])).should include(Square.new(:b2))
    piece.legal_moves(Position.new([piece])).should include(Square.new(:h8))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Bishop.new(:a1, :white)
    piece2 = Bishop.new(:d4, :black)
    piece1.legal_moves(Position.new([piece1, piece2])).length.should == 3
    piece1.legal_moves(Position.new([piece1, piece2])).should include(Square.new(:d4))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Bishop.new(:a1, :white)
    piece2 = Pawn.new(:d4, :white)
    piece1.legal_moves(Position.new([piece1, piece2])).should_not include(Square.new(:d4))
  end

  it "should not list a target square blocked by another piece as a valid move" do
    piece1 = Bishop.new(:c1, :white)
    piece2 = Pawn.new(:b2, :white)
    piece3 = Pawn.new(:d2, :white)
    piece1.legal_moves(Position.new([piece1, piece2, piece3])).should_not include(Square.new(:e3))
  end
  
  it "should not list squares that leave king in check as legal moves" do
    king_w = King.new(:a1, :white)
    bish_w = Bishop.new(:c1, :white)
    rook_b = Rook.new(:f1, :black)
    position = Position.new([king_w, bish_w, rook_b])
    bish_w.legal_moves(position).should == []
  end

end