require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Knight" do
  
  it "should list all knight squares on an empty board" do
    piece = Knight.new(:d4, :white)
    piece.legal_moves(Position.new([piece]),nil).length.should == 8
    
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:a8))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:h1))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:h8))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Knight.new(:d1, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).length.should == 17
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should include(Square.new(:d1))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Pawn.new(:d1, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:d1))
  end

  it "should not list a target square blocked by another piece as a valid move" do
    piece1 = Knight.new(:c1, :white)
    piece2 = Pawn.new(:c2, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c3))
  end

end