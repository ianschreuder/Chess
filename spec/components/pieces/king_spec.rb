require File.dirname(__FILE__) + '/../../spec_helper'

describe "King" do

  before :all do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
  end

  before :each do
    @board = Board.new(@p1,@p2)
  end
  
  it "should list eight moves for a king (moved) on an empty board" do
    piece = @board.occupier(@board.square_at(sym: :e1))
    @board.pieces.each{|p| p.remove unless p == piece}
    piece.move(@board.square_at(sym: :d4))

    piece.legal_moves.length.should == 8
  end
  
  it "should list squares with opponents on them as legal moves" do
    king_w = @board.occupier(@board.square_at(sym: :e1))
    rook_b = @board.occupier(@board.square_at(sym: :a8))
    @board.pieces.each{|p| p.remove unless p == king_w or p == rook_b }
    rook_b.move(@board.square_at(sym: :e2))

    king_w.legal_moves.length.should == 3
    king_w.legal_moves.should include(@board.square_at(sym: :e2))
  end
  
  it "should know castling: two spaces left or right ok" do
    king  = @board.occupier(@board.square_at(sym: :e1))
    rook1 = @board.occupier(@board.square_at(sym: :a1))
    rook2 = @board.occupier(@board.square_at(sym: :h1))
    @board.pieces.each{|p| p.remove unless p == king || p == rook1 || p == rook2 }

    king.legal_moves.should include(@board.square_at(sym: :c1))
    king.legal_moves.should include(@board.square_at(sym: :g1))
  end
  
  it "should know castling: can't castle if rook isn't there" do
    king  = @board.occupier(@board.square_at(sym: :e1))
    @board.pieces.each{|p| p.remove unless p == king }

    king.legal_moves.should_not include(@board.square_at(sym: :c1))
    king.legal_moves.should_not include(@board.square_at(sym: :g1))
  end
  
  it "should know castling: can't castle if either piece has moved" do
    king  = @board.occupier(@board.square_at(sym: :e1))
    rook1 = @board.occupier(@board.square_at(sym: :a1))
    rook2 = @board.occupier(@board.square_at(sym: :h1))
    @board.pieces.each{|p| p.remove unless p == king || p == rook1 || p == rook2 }

    rook1.move(@board.square_at(sym: :a1))
    king.legal_moves.should_not include(@board.square_at(sym: :c1))
    king.legal_moves.should include(@board.square_at(sym: :g1))

    king.move(@board.square_at(sym: :e1))
    king.legal_moves.should_not include(@board.square_at(sym: :g1))
  end
  
  it "should know castling: can't castle if path is blocked" do
    king   = @board.occupier(@board.square_at(sym: :e1))
    rook   = @board.occupier(@board.square_at(sym: :a1))
    bishop = @board.occupier(@board.square_at(sym: :c8))
    @board.pieces.each{|p| p.remove unless p == king || p == rook || p == bishop }
    bishop.move(@board.square_at(sym: :c1))

    king.legal_moves.should_not include(@board.square_at(sym: :c1))
  end
  
  it "should know castling: can't castle through, out of or into check" do
    king   = @board.occupier(@board.square_at(sym: :e1))
    rook   = @board.occupier(@board.square_at(sym: :a1))
    b_rook = @board.occupier(@board.square_at(sym: :a8))
    @board.pieces.each{|p| p.remove unless p == king || p == rook || p == b_rook }

    king.legal_moves.should include(@board.square_at(sym: :c1))
    b_rook.move(@board.square_at(sym: :d3))
    king.legal_moves.should_not include(@board.square_at(sym: :c1))

    b_rook.move(@board.square_at(sym: :e3))
    king.legal_moves.should_not include(@board.square_at(sym: :c1))

    b_rook.move(@board.square_at(sym: :c3))
    king.legal_moves.should_not include(@board.square_at(sym: :c1))
  end
  
  it "should correctly identify the legal moves #1" do 
    # simple positioning problem
    king_w = @board.occupier(@board.square_at(sym: :e1))
    king_b = @board.occupier(@board.square_at(sym: :e8))
    @board.pieces.each{|p| p.remove unless p == king_w || p == king_b }
    king_w.move(@board.square_at(sym: :a1))
    king_b.move(@board.square_at(sym: :b3))

    king_w.legal_moves.length.should == 1
    king_w.legal_moves.should == [@board.square_at(sym: :b1)]
  end

  it "should correctly identify the legal moves #2" do 
    king_w = @board.occupier(@board.square_at(sym: :e1))
    king_b = @board.occupier(@board.square_at(sym: :e8))
    rook_b = @board.occupier(@board.square_at(sym: :a8))
    knig_b = @board.occupier(@board.square_at(sym: :b8))
    bish_b = @board.occupier(@board.square_at(sym: :c8))
    pawn_b = @board.occupier(@board.square_at(sym: :a7))
    @board.pieces.each{|p| p.remove unless p == king_w || p == king_b || p == rook_b || p == bish_b || p == pawn_b || p == knig_b }

    king_w.move(@board.square_at(sym: :d4))
    pawn_b.move(@board.square_at(sym: :b5))
    bish_b.move(@board.square_at(sym: :c6))
    rook_b.move(@board.square_at(sym: :g3))
    knig_b.move(@board.square_at(sym: :d3))

    king_w.legal_moves.should == [@board.square_at(sym: :c3)]
  end
  
end
