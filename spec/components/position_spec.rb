require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Position" do

  it "needs to be created with a set of pieces" do
    p1 = Player.new(:white)
    p2 = Player.new(:black)
    board = Board.new(p1, p2)
    lambda{ Position.new(board.pieces)}.should_not raise_error(ArgumentError)
  end

  it "should be able to determine whether a target square is blocked by another piece" do
    # horizontal
    p = Position.new([Piece.new(:a4)])
    p.blocked?(Square.new(:a2), Square.new(:a5)).should == true
    p = Position.new([Piece.new(:a5)])
    p.blocked?(Square.new(:a2), Square.new(:a5)).should == false
    # diagonal test
    p = Position.new([Piece.new(:b2)])
    p.blocked?(Square.new(:a1), Square.new(:c3)).should == true
    p = Position.new([Piece.new(:h8)])
    p.blocked?(Square.new(:a1), Square.new(:h8)).should == false
  end
  
  it "should return the piece on a square" do
    piece = Piece.new(:a4)
    position = Position.new([piece])
    position.occupier(Square.new(:a4)).should == piece
    position.occupier(Square.new(:a3)).should == nil
  end
  
end