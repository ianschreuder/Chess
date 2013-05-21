require File.dirname(__FILE__) + '/../../spec_helper'

describe "Queen" do
  
  before :all do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
  end

  before :each do
    @board = Board.new(@p1,@p2)
  end
  
  it "should list all straight and diagonal squares on an empty board" do
    piece = @board.occupier(@board.square_at(sym: :d1))
    @board.pieces.each{|p| p.remove unless p == piece}
    piece.move(@board.square_at(sym: :a1))

    piece.legal_moves.length.should == 14 + 7
    piece.legal_moves.should include(@board.square_at(sym: :a8))
    piece.legal_moves.should include(@board.square_at(sym: :h1))
    piece.legal_moves.should include(@board.square_at(sym: :h8))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = @board.occupier(@board.square_at(sym: :d1))
    piece2 = @board.occupier(@board.square_at(sym: :d8))
    @board.pieces.each{|p| p.remove unless p == piece1 or p == piece2 }
    piece1.move(@board.square_at(sym: :a1))
    piece2.move(@board.square_at(sym: :h8))

    piece1.legal_moves.length.should == 14 + 7
    piece1.legal_moves.should include(@board.square_at(sym: :h8))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = @board.occupier(@board.square_at(sym: :d1))
    piece2 = @board.occupier(@board.square_at(sym: :d2))
    @board.pieces.each{|p| p.remove unless p == piece1 or p == piece2 }
    piece1.move(@board.square_at(sym: :a1))
    piece2.move(@board.square_at(sym: :h8))

    piece1.legal_moves.length.should == 14 + 6
    piece1.legal_moves.should_not include(@board.square_at(sym: :h8))
  end

  it "should not list squares that leave king in check as legal moves" do
    w_queen = @board.occupier(@board.square_at(sym: :d1))
    b_bishop = @board.occupier(@board.square_at(sym: :c8))
    w_king = @board.occupier(@board.square_at(sym: :e1))
    @board.pieces.each{|p| p.remove unless p == w_queen or p == w_king or p == b_bishop }
    b_bishop.move(@board.square_at(sym: :c3))
    w_queen.move(@board.square_at(sym: :d2))

    w_queen.legal_moves.should == [@board.square_at(sym: :c3)]
  end

end