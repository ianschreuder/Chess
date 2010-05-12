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
    position.update_with_move(move)
    p1.legal_moves(position).should include(Square.new(:c6))
  
    p1 = Pawn.new(:b5, :white)
    p2 = Pawn.new(:a7, :black)
    position = Position.new([p1,p2])
    move = Move.new(p2, Square.new(:a5))
    position.update_with_move(move)
    p1.legal_moves(position).should include(Square.new(:a6))
    
    p1 = Pawn.new(:c5, :white)
    p2 = Pawn.new(:a7, :black)
    position = Position.new([p1,p2])
    move = Move.new(p2, Square.new(:a5))
    p1.legal_moves(position).should_not include(Square.new(:a6))
  end

  it "should not list squares that leave king in check as legal moves" do
    king_w = King.new(:d1, :white)
    pawn_w = Pawn.new(:c2, :white)
    bish_b = Bishop.new(:b3, :black)
    position = Position.new([king_w, pawn_w, bish_b])
    pawn_w.legal_moves(position).should == [Square.new(:b3)]
    
    # test en passant                                              # 8      
    king_w = King.new(:f5, :white)                                 # 7     . 
    pawn_w = Pawn.new(:d5, :white)                                 # 6       
    pawn_b = Pawn.new(:c7, :black)                                 # 5 R   P p   k
    rook_b = Rook.new(:a5, :black)                                 # 4
    last_move = Move.new(pawn_b, Square.new(:c5))                  # 3      
    position = Position.new([king_w, pawn_w, pawn_b, rook_b])      # 2     
    position.update_with_move(last_move)                           # 1       
    pawn_w.legal_moves(position).should == [Square.new(:d6)]       #   a b c d e f g h

    # test en passant x2                                           # 8      
    king_w = King.new(:d4, :white)                                 # 7     . 
    pawn_w = Pawn.new(:d5, :white)                                 # 6       
    pawn_b = Pawn.new(:c7, :black)                                 # 5     P p   
    last_move = Move.new(pawn_b, Square.new(:c5))                  # 4       k
    position = Position.new([king_w, pawn_w, pawn_b])              # 3     
    position.update_with_move(last_move)                           # 2       
    pawn_w.legal_moves(position).should == [Square.new(:c6)]       #   a b c d e f g h

  end

end