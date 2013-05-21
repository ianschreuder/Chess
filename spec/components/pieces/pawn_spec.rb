require File.dirname(__FILE__) + '/../../spec_helper'

describe "Pawn" do
  before :all do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
  end

  before :each do
    @board = Board.new(@p1,@p2)
  end

  it "should list two forward moves for a non-moved pawn on empty board" do
    square = @board.square_at(sym: :b2)
    piece = @board.occupier(square)
    piece.legal_moves.length.should == 2
    piece.legal_moves.should include(@board.square_at(sym: :b3))
    piece.legal_moves.should include(@board.square_at(sym: :b4))
  end
  
  it "should list 1 forward move for a moved pawn on an empty board" do
    square_b2 = @board.square_at(sym: :b2)
    piece = @board.occupier(square_b2)
    square_b3 = @board.square_at(sym: :b3)
    square_b4 = @board.square_at(sym: :b4)
    piece.move(square_b3)
    piece.legal_moves.should == [square_b4]
  end
  
  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = @board.occupier(@board.square_at(sym: :a2))
    piece2 = @board.occupier(@board.square_at(sym: :a7))
    @board.pieces.each{|p| p.remove unless p == piece1 || p == piece2}

    square_b3 = @board.square_at(sym: :b3)
    piece2.move(square_b3)
    piece1.legal_moves.length.should == 3
    piece1.legal_moves.should include(square_b3)
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    square_a2 = @board.square_at(sym: :a2)
    square_b2 = @board.square_at(sym: :b2)
    square_b3 = @board.square_at(sym: :b3)
    piece1 = @board.occupier(square_a2)
    piece2 = @board.occupier(square_b2)
    piece2.move(square_b3)

    piece1.legal_moves.should_not include(square_b3)
  end
  
  it "should not list a target square blocked by another piece as a valid move" do
    square_c2 = @board.square_at(sym: :c2)
    square_c3 = @board.square_at(sym: :c3)
    square_c4 = @board.square_at(sym: :c4)
    square_c7 = @board.square_at(sym: :c7)

    piece1 = @board.occupier(square_c2)
    piece2 = @board.occupier(square_c7)
    piece1.legal_moves.should include(square_c4)
    piece2.move(square_c3)
    piece1.legal_moves.should_not include(square_c4)
  end
  
  it "should not consider moving straight forward one square as valid if it is occupied (by either color)" do
    square_c2 = @board.square_at(sym: :c2)
    square_c3 = @board.square_at(sym: :c3)
    square_c4 = @board.square_at(sym: :c4)
    square_c7 = @board.square_at(sym: :c7)
    square_d2 = @board.square_at(sym: :d2)

    piece1 = @board.occupier(square_c2)
    piece2 = @board.occupier(square_d2)
    piece3 = @board.occupier(square_c7)

    piece1.legal_moves.should include(square_c4)

    piece2.move(square_c3)
    piece1.legal_moves.should_not include(square_c4)
    @board.reset

    piece3.move(square_c3)
    piece1.legal_moves.should_not include(square_c4)
  end
  
  it "should only list diagonal and en passant moves as legitimate attack squares" do
    white_pawn = @board.occupier(@board.square_at(sym: :c2))
    white_bishop = @board.occupier(@board.square_at(sym: :c1))
    black_pawn = @board.occupier(@board.square_at(sym: :c7))
    black_knight = @board.occupier(@board.square_at(sym: :b8))
    @board.pieces.each{|p| p.remove unless p == white_pawn || p == black_knight || p == white_bishop || p == black_pawn }

    black_knight.move(@board.square_at(sym: :d3))
    white_bishop.move(@board.square_at(sym: :b3))
    white_pawn.legal_moves.length.should == 3
    white_pawn.legal_moves.should include(@board.square_at(sym: :c4))
    white_pawn.legal_moves.should include(@board.square_at(sym: :c3))
    white_pawn.legal_moves.should include(@board.square_at(sym: :d3))

    white_pawn.move(@board.square_at(sym: :b5))
    black_pawn.move(@board.square_at(sym: :c5))

    white_pawn.legal_moves.should include(@board.square_at(sym: :c6))
  end
  
  it "should maintain 'en passant' logic and correctly list a square matching those conditions as a legal move" do
    white_pawn  = @board.occupier(@board.square_at(sym: :c2))
    black_pawn1 = @board.occupier(@board.square_at(sym: :b7))
    black_pawn2 = @board.occupier(@board.square_at(sym: :d7))
    white_pawn.move(@board.square_at(sym: :c5))

    black_pawn1.move(@board.square_at(sym: :b5))
    white_pawn.legal_moves.should include(@board.square_at(sym: :b6))

    black_pawn2.move(@board.square_at(sym: :d5))
    white_pawn.legal_moves.should include(@board.square_at(sym: :d6))

    white_pawn.legal_moves.should_not include(@board.square_at(sym: :a6))
  end

  it "should not list squares that leave king in check as legal moves" do
    king_w = @board.occupier(@board.square_at(sym: :e1))              # 7     . 
    king_w.move(@board.square_at(sym: :f5))                           # 6       
    pawn_w = @board.occupier(@board.square_at(sym: :d2))              # 5 R   P p   k
    pawn_w.move(@board.square_at(sym: :d5))                           # 4
    rook_b = @board.occupier(@board.square_at(sym: :a8))              # 3      
    rook_b.move(@board.square_at(sym: :a5))                           # 2     
    pawn_b = @board.occupier(@board.square_at(sym: :c7))              # 1        
    pawn_b.move(@board.square_at(sym: :c5))                           #   a b c d e f g h
    @board.pieces.each{|p| p.remove unless p == king_w || p == pawn_w || p == rook_b || p == pawn_b }
    pawn_w.legal_moves.should_not include(@board.square_at(sym: :c6)) 
  end

  it "should list the removal of attacking piece via en passant as legal move" do
    king_w = @board.occupier(@board.square_at(sym: :e1))              # 7     . 
    king_w.move(@board.square_at(sym: :d4))                           # 6       
    pawn_w = @board.occupier(@board.square_at(sym: :d2))              # 5     P p  
    pawn_w.move(@board.square_at(sym: :d5))                           # 4       k 
    pawn_b = @board.occupier(@board.square_at(sym: :c7))              # 3     
    pawn_b.move(@board.square_at(sym: :c5))                           #   a b c d e f g h
    @board.pieces.each{|p| p.remove unless [king_w,pawn_w,pawn_b].include?(p)}
    pawn_w.legal_moves.should include(@board.square_at(sym: :c6))     
  end

end