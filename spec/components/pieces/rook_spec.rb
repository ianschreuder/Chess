require File.dirname(__FILE__) + '/../../spec_helper'

describe "Rook" do
  
  before :each do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
    @board = Board.new(@p1,@p2)
  end

  before :each do
    @board.reset
  end
  
  it "should list all straight squares on an empty board" do
    piece = @board.occupier(@board.square_at(sym: :a1))
    @board.pieces.each{|p| p.remove unless p == piece}

    piece.legal_moves.length.should == 14
    piece.legal_moves.should include(@board.square_at(sym: :a8))
    piece.legal_moves.should include(@board.square_at(sym: :h1))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = @board.occupier(@board.square_at(sym: :a1))
    piece2 = @board.occupier(@board.square_at(sym: :a8))
    @board.pieces.each{|p| p.remove unless p == piece1 || p == piece2 }

    piece1.legal_moves.length.should == 14
    piece1.legal_moves.should include(@board.square_at(sym: :a8))
    piece1.legal_moves.should include(@board.square_at(sym: :h1))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = @board.occupier(@board.square_at(sym: :a1))
    piece2 = @board.occupier(@board.square_at(sym: :h1))
    @board.pieces.each{|p| p.remove unless p == piece1 || p == piece2 }
    piece2.move(@board.square_at(sym: :g1))

    piece1.legal_moves.length.should == 12
    piece1.legal_moves.should include(@board.square_at(sym: :a8))
    piece1.legal_moves.should_not include(@board.square_at(sym: :h1))
  end

  it "should not list squares that leave king in check as legal moves" do
    rook_w = @board.occupier(@board.square_at(sym: :a1))
    king_w = @board.occupier(@board.square_at(sym: :e1))
    bish_b = @board.occupier(@board.square_at(sym: :c8))
    @board.pieces.each{|p| p.remove unless p == rook_w || p == king_w || p == bish_b }
    rook_w.move(@board.square_at(sym: :d2))
    bish_b.move(@board.square_at(sym: :c3))

    rook_w.legal_moves.should == []                  
  end

end