require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Knight" do
  
  it "should list all knight squares on an empty board" do
    piece = Knight.new(:d4, :white)
    piece.legal_moves(Position.new([piece]),nil).length.should == 8
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:e2))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:e6))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:b5))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Knight.new(:c2, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).length.should == 2
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should include(Square.new(:c2))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Pawn.new(:c2, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:d1))
  end

end