require File.dirname(__FILE__) + '/../spec_helper'

describe "Move" do

  it "should be able to move pieces and reset them" do
    p1 = Player.new(WHITE)
    p2 = Player.new(BLACK)
    board = Board.new(p1,p2)


    # basic move
    pawn = board.occupier(board.square_at(sym: :a2))
    move = Move.new(pawn, board.square_at(sym: :a4))
    move.execute
    pawn.square.to_sym.should == :a4
    move.reset
    pawn.square.to_sym.should == :a2

    # attack other piece
    bishop = board.occupier(board.square_at(sym: :b8))
    bishop.move(board.square_at(sym: :b3))
    move = Move.new(pawn, board.square_at(sym: :b3))
    move.set_target_piece(bishop)
    move.execute
    pawn.square.to_sym.should == :b3
    bishop.square.should == nil
    move.reset
    pawn.square.to_sym.should == :a2
    bishop.square.to_sym.should == :b3

    # attack via 'en passant'
    pawn1 = board.occupier(board.square_at(sym: :e7))
    pawn2 = board.occupier(board.square_at(sym: :e2))
    pawn2.move(board.square_at(sym: :d5))
    pawn1.move(board.square_at(sym: :e5))

    move = Move.new(pawn2, board.square_at(sym: :e6))
    move.set_target_piece(pawn1)
    move.execute
    pawn2.square.to_sym.should == :e6
    pawn1.square.should == nil
    move.reset
    pawn2.square.to_sym.should == :d5
    pawn1.square.to_sym.should == :e5
  end
  
end