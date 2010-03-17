require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Rook" do
  
  it "should list all horizontal squares on an empty board" do
    piece = Rook.new(:a1, :white)
    piece.legal_moves(Position.new([piece]),nil).length.should == 14
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:a8))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:h1))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Rook.new(:a1, :white)
    piece2 = Rook.new(:d1, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).length.should == 10
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should include(Square.new(:d1))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Rook.new(:a1, :white)
    piece2 = Pawn.new(:d1, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:d1))
  end

  it "should not list a target square blocked by another piece as a valid move" do
    piece1 = Rook.new(:c1, :white)
    piece2 = Pawn.new(:c2, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c3))
  end

end