require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Move" do

  it "should be able to move pieces and reset them" do
    # basic move
    pawn = Pawn.new(:a2, :white)
    position = Position.new([pawn])
    move = Move.new(position, pawn,Square.new(:a4))
    move.execute
    pawn.square.to_s.should == ":a4"
    move.reset
    pawn.square.to_s.should == ":a2"

    # attack other piece
    pawn = Pawn.new(:a2, :white)
    bishop = Bishop.new(:b3, :black)
    position = Position.new([pawn, bishop])
    move = Move.new(position, pawn,Square.new(:b3))
    move.execute
    pawn.square.to_s.should == ":b3"
    bishop.square.should == nil
    move.reset
    pawn.square.to_s.should == ":a2"
    bishop.square.to_s.should == ":b3"

    # attack via 'en passant'
    pawn1 = Pawn.new(:d5, :white)
    pawn2 = Pawn.new(:e6, :black)
    position = Position.new([pawn, bishop])
    move = Move.new(position, pawn,Square.new(:b3))
    move.execute
    pawn.square.to_s.should == ":b3"
    bishop.square.should == nil
    move.reset
    pawn.square.to_s.should == ":a2"
    bishop.square.to_s.should == ":b3"
  end
  
  it "should know whether it created an 'en passant' situation" do
    pawn = Pawn.new(:a2)
    position = Position.new([pawn])
    move = Move.new(position, pawn, Square.new(:a4))
    move.creates_en_passant?.should == true

    pawn = Pawn.new(:a2)
    position = Position.new([pawn])
    move = Move.new(position, pawn, Square.new(:a3))
    move.creates_en_passant?.should == false
  end
  
  it "should know what square is the legitimate 'en passant' target square" do
    pawn = Pawn.new(:a2)
    position = Position.new([pawn])
    move = Move.new(position, pawn, Square.new(:a4))
    move.en_passant_square.should == Square.new(:a3)
  end

end