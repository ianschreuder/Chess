require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "King" do

  it "should list eight moves for a king (moved) on an empty board" do
    piece = King.new(:c4, :white)
    piece.legal_moves(Position.new([piece]), nil).length.should == 8
  end
  
  it "should list squares with opponents on them as legal moves" do
    king = King.new(:c4, :white)
    p1 = Bishop.new(:d3, :black)
    p2 = Rook.new(:c2,:white)
    king.legal_moves(Position.new([king, p1, p2]),nil).length.should == 7
  end
  
  it "should know castling: two spaces left or right ok" do
    king = King.new(:d1)
    rook1 = Rook.new(:a1)
    rook2 = Rook.new(:h1)
    king.legal_moves(Position.new([king, rook1, rook2])).should include(Square.new(:b1))
    king.legal_moves(Position.new([king, rook1, rook2])).should include(Square.new(:f1))
  end
  
  it "should know castling: can't castle if rook isn't there" do
    king = King.new(:d1)
    king.legal_moves(Position.new([king])).should_not include(Square.new(:b1))
    king.legal_moves(Position.new([king])).should_not include(Square.new(:f1))
  end
  
  it "should know castling: can't castle if either piece has moved" do
    king = King.new(:d1); king.move(Square.new(:d1))
    rook1 = Rook.new(:a1)
    king.legal_moves(Position.new([king, rook1])).should_not include(Square.new(:b1))
    king = King.new(:d1)
    rook2 = Rook.new(:h1); rook2.move(:h1) 
    king.legal_moves(Position.new([king, rook2])).should_not include(Square.new(:f1))
  end
  
  it "should know castling: can't castle if path is blocked" do
    king = King.new(:d1)
    rook1 = Rook.new(:e1)
    rook2 = Rook.new(:h1)
    king.legal_moves(Position.new([king, rook1, rook2])).should_not include(Square.new(:f1))
  end
  
  it "should know castling: can't castle through, out of or into check" do
    king = King.new(:d1, :white)
    rook1 = Rook.new(:a1, :white)
    rook2 = Rook.new(:h1, :white)
    bishop = Bishop.new(:a4, :black)
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should_not include(Square.new(:b1))
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should_not include(Square.new(:f1))
  
    bishop = Bishop.new(:a3, :black)
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should_not include(Square.new(:b1))
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should include(Square.new(:f1))

    bishop = Bishop.new(:a2, :black)
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should_not include(Square.new(:b1))
    king.legal_moves(Position.new([king, rook1, rook2, bishop])).should include(Square.new(:f1))
  end
  
  it "should correctly identify the legal moves" do 
    # simple positioning problem
    king_w = King.new(:a1, :white)
    king_b = King.new(:b3, :black)
    king_w.legal_moves(Position.new([king_w, king_b])).length.should == 1
    king_w.legal_moves(Position.new([king_w, king_b])).should == [Square.new(:b1)]

    # more complex positioning
    king_w = King.new(:d4, :white)
    pawn_b = Pawn.new(:b5, :black)
    bish_b = Bishop.new(:c6, :black)
    rook_b = Rook.new(:g3, :black)
    knig_b = Knight.new(:d3, :black)
    position = Position.new([king_w, pawn_b, bish_b, rook_b, knig_b])
    king_w.legal_moves(position).should == [Square.new(:c3)]
  end
  
end
