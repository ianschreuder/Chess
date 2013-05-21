require File.dirname(__FILE__) + '/../../spec_helper'

describe "Bishop" do
  
  before :all do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
  end

  before :each do
    @board = Board.new(@p1,@p2)
  end
  
  it "should list all diagonal squares on an empty board" do
    piece = @board.occupier(@board.square_at(sym: :c1))
    @board.pieces.each{|p| p.remove unless p == piece}
    piece.move(@board.square_at(sym: :a1))

    piece.legal_moves.length.should == 7
    piece.legal_moves.should include(@board.square_at(sym: :h8))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = @board.occupier(@board.square_at(sym: :c1))
    piece2 = @board.occupier(@board.square_at(sym: :c8))
    @board.pieces.each{|p| p.remove unless p == piece1 or p == piece2 }
    piece1.move(@board.square_at(sym: :a1))
    piece2.move(@board.square_at(sym: :b2))

    piece1.legal_moves.length.should == 1
    piece1.legal_moves.should include(@board.square_at(sym: :b2))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = @board.occupier(@board.square_at(sym: :c1))
    piece2 = @board.occupier(@board.square_at(sym: :f1))
    @board.pieces.each{|p| p.remove unless p == piece1 or p == piece2 }
    piece1.move(@board.square_at(sym: :a1))
    piece2.move(@board.square_at(sym: :b2))

    piece1.legal_moves.length.should == 0
  end

  it "should not list squares that leave king in check as legal moves" do
    w_bishop = @board.occupier(@board.square_at(sym: :c1))
    w_king   = @board.occupier(@board.square_at(sym: :e1))
    b_rook   = @board.occupier(@board.square_at(sym: :a8))
    @board.pieces.each{|p| p.remove unless p == w_bishop or p == w_king or p == b_rook }
    w_bishop.move(@board.square_at(sym: :e2))
    b_rook.move(@board.square_at(sym: :e3))

    w_bishop.legal_moves.should == []
  end

end