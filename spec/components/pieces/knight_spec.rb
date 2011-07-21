require File.dirname(__FILE__) + '/../../spec_helper'

describe "Knight" do
  
  it "should list all knight squares on an empty board" do
    piece = Knight.new(:d4, :white)
    piece.legal_moves(Position.new([piece])).length.should == 8
    piece.legal_moves(Position.new([piece])).should include(Square.new(:e2))
    piece.legal_moves(Position.new([piece])).should include(Square.new(:e6))
    piece.legal_moves(Position.new([piece])).should include(Square.new(:b5))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Knight.new(:c2, :black)
    piece1.legal_moves(Position.new([piece1, piece2])).length.should == 2
    piece1.legal_moves(Position.new([piece1, piece2])).should include(Square.new(:c2))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Knight.new(:a1, :white)
    piece2 = Pawn.new(:c2, :white)
    piece1.legal_moves(Position.new([piece1, piece2])).should_not include(Square.new(:d1))
  end

  it "should not list squares that leave king in check as legal moves" do
    king_w = King.new(:d4, :white)
    knight_w = Knight.new(:d2, :white)
    rook_b = Rook.new(:d1, :black)
    position = Position.new([king_w, knight_w, rook_b])
    knight_w.legal_moves(position).should == []
  end

end