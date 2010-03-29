require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Pawn" do

  it "should list two forward moves for a non-moved pawn on empty board" do
    piece = Pawn.new(:b2, :white)
    piece.legal_moves(Position.new([piece]),nil).length.should == 2
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:b3))
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:b4))
  end
  
  it "should list 1 forward move for a moved pawn on an empty board" do
    piece = Pawn.new(:b2, :white)
    piece.move(Square.new(:b3))
    piece.legal_moves(Position.new([piece]),nil).length.should == 1
    piece.legal_moves(Position.new([piece]),nil).should include(Square.new(:b4))
  end
  
  it "should not consider off the board a legal move" do
    piece = Pawn.new(:a8, :white)
    piece.move(Square.new(:a9))
    piece.legal_moves(Position.new([piece]),nil).length.should == 0
    piece.legal_moves(Position.new([piece]),nil).should_not include(Square.new(:a4))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = Pawn.new(:a2, :white)
    piece2 = Pawn.new(:b3, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).length.should == 3
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should include(Square.new(:b3))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = Pawn.new(:a2, :white)
    piece2 = Pawn.new(:c3, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c3))
  end
  
  it "should not list a target square blocked by another piece as a valid move" do
    piece1 = Pawn.new(:c2, :white)
    piece2 = Pawn.new(:c3, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c4))
  end
  
  it "should not consider moving straight forward one square as valid if it is occupied (by either color)" do
    piece1 = Pawn.new(:c2, :white)
    piece2 = Pawn.new(:c3, :white)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c3))
    piece1 = Pawn.new(:c2, :white)
    piece2 = Pawn.new(:c3, :black)
    piece1.legal_moves(Position.new([piece1, piece2]),nil).should_not include(Square.new(:c3))
  end
  
  it "should only list diagonal and en passant moves as legitimate attack squares" do
    p1 = Pawn.new(:c2, :white)
    p2 = Knight.new(:d3, :black)
    p3 = Bishop.new(:b3, :white)
    valid_squares = %w(c4 c3 d3).map{|coord| Square.new(coord)}
    p1.legal_moves(Position.new([p1,p2,p3])).each{|square| valid_squares.should include(square)}

    p1 = Pawn.new(:d3, :black)
    p2 = Knight.new(:d2, :black)
    p3 = Bishop.new(:c3, :white)
    move = Move.new(Pawn.new(:e2),Square.new(:e4))
    valid_squares = %w(c3 e3).map{|coord| Square.new(coord)}
    p1.legal_moves(Position.new([p1,p2,p3]),move).each{|square| valid_squares.should include(square)}
    
  end

  it "should maintain 'en passant' logic and correctly list a square matching those conditions as a legal move" do
    p1 = Pawn.new(:b5, :white)
    p2 = Pawn.new(:c7, :black)
    position = Position.new([p1,p2])
    move = Move.new(p2, Square.new(:c5))
    p1.attackable?(Square.new(:c6), position, move).should == true

    p1 = Pawn.new(:b5, :white)
    p2 = Pawn.new(:a7, :black)
    position = Position.new([p1,p2])
    move = Move.new(p2, Square.new(:a5))
    p1.attackable?(Square.new(:a6), position, move).should == true

    p1 = Pawn.new(:c5, :white)
    p2 = Pawn.new(:a7, :black)
    position = Position.new([p1,p2])
    move = Move.new(p2, Square.new(:a5))
    p1.attackable?(Square.new(:a6), position, move).should == false
  end

end