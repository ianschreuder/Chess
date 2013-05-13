require File.dirname(__FILE__) + '/../../spec_helper'

describe "Rook" do
  
  it "should list all straight squares on an empty board" do
    piece = Rook.new(:a1, :white)
    piece.legal_moves(Position.new([piece])).length.should == 14
    piece.legal_moves(Position.new([piece])).should include(Square.new(:a8))
    piece.legal_moves(Position.new([piece])).should include(Square.new(:h1))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Rook.new(:a1, :white)
    piece2 = Rook.new(:d1, :black)
    piece1.legal_moves(Position.new([piece1, piece2])).length.should == 10
    piece1.legal_moves(Position.new([piece1, piece2])).should include(Square.new(:d1))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Rook.new(:a1, :white)
    piece2 = Pawn.new(:d1, :white)
    piece1.legal_moves(Position.new([piece1, piece2])).should_not include(Square.new(:d1))
  end

  it "should not list a target square blocked by another piece as a valid move" do
    piece1 = Rook.new(:c1, :white)
    piece2 = Pawn.new(:c2, :white)
    piece1.legal_moves(Position.new([piece1, piece2])).should_not include(Square.new(:c3))
  end

  it "should not list squares that leave king in check as legal moves" do
    king_w = King.new(:a1, :white)                             # 3     b
    rook_w = Rook.new(:b2, :white)                             # 2   r   
    bish_b = Bishop.new(:c3, :black)                           # 1 K             
    position = Position.new([king_w, rook_w, bish_b])          #   a b c d e f g h
    rook_w.legal_moves(position).should == []                  
  end

  it "should recognize when it's own color piece is blocking it from putting a king in check" do
    king_w = King.new(:a1, :white)                             # 3     
    rook_b = Rook.new(:e1, :black)                             # 2      
    bish_b = Bishop.new(:c1, :black)                           # 1 K   b   r           
    position = Position.new([king_w, rook_b, bish_b])          #   a b c d e f g h
    
    position.in_check?(king_w).should == false
  end

end