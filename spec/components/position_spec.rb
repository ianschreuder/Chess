require File.dirname(__FILE__) + '/../spec_helper'

describe "Position" do

  it "can be created with a set of pieces" do
    p1 = Player.new(:white)
    p2 = Player.new(:black)
    lambda{ Position.new([p1,p2])}.should_not raise_error(ArgumentError)
  end
  
  it "should provide an initial start position with 32 pieces; 16 white, 16 black" do
    p1 = Player.new(:white)
    p2 = Player.new(:black)
    position = Position.new
    position.new_game_setup
    position.black_pieces.length.should == 16
    position.white_pieces.length.should == 16
  end
  
  it "should provide 20 moves for white from a starting position" do
    position = Position.new
    position.new_game_setup
    position.white_pieces.map{|piece| piece.legal_moves(position)}.flatten.length.should == 20
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
  
  it "should identify whether the king is in check" do
    king = King.new(:d4, :white)
    bishop = Bishop.new(:b2, :black)
    position = Position.new([king,bishop])
    position.in_check?(king).should == true
  
    bishop = Bishop.new(:c2, :black)
    position = Position.new([king,bishop])
    position.in_check?(king).should == false
  end
  
  it "should update itself with an executable move" do
    pawn = Pawn.new(:d7, :black)
    position = Position.new([pawn])
    last_move = Move.new(pawn, Square.new(:d5))
    position.update_with_move(last_move)
    position.all_pieces.first.square.to_s.should == ":d5"
    position.last_move.should == last_move
  end
  
  it "should return the king for a side" do
   king_b = King.new(:a1, :black)
   king_w = King.new(:h8, :white)
   position = Position.new([king_b, king_w])
   position.king_for_color(:white).should == king_w 
   position.king_for_color(:black).should == king_b
  end
  
end