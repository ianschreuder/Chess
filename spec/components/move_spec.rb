require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Move" do

  it "should be able to move pieces and reset them" do
    # basic move
    pawn = Pawn.new(:a2, :white)
    position = Position.new([pawn])
    move = Move.new(pawn, Square.new(:a4))
    move.execute
    pawn.square.to_s.should == ":a4"
    move.reset
    pawn.square.to_s.should == ":a2"

    # attack other piece
    pawn = Pawn.new(:a2, :white)
    bishop = Bishop.new(:b3, :black)
    position = Position.new([pawn, bishop])
    move = Move.new(pawn, Square.new(:b3))
    move.set_target_piece(bishop)
    move.execute
    pawn.square.to_s.should == ":b3"
    bishop.square.should == nil
    move.reset
    pawn.square.to_s.should == ":a2"
    bishop.square.to_s.should == ":b3"

    # attack via 'en passant'
    pawn1 = Pawn.new(:e7, :black)
    pawn2 = Pawn.new(:d5, :white)
    position = Position.new([pawn1, pawn2])
    move = Move.new(pawn1, Square.new(:e5))
    position.update_with_move(move)
    move = Move.new(pawn2, Square.new(:e6))
    move.set_target_piece(pawn1)
    move.execute
    pawn2.square.to_s.should == ":e6"
    pawn1.square.should == nil
    move.reset
    pawn2.square.to_s.should == ":d5"
    pawn1.square.to_s.should == ":e5"
  end
  
end