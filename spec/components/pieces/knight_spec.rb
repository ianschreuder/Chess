require File.dirname(__FILE__) + '/../../spec_helper'

describe "Knight" do

  before :each do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
    @board = Board.new(@p1,@p2)
  end

  before :each do
    @board.reset
  end
  
  it "should list all knight squares on an empty board" do
    piece = @board.occupier(@board.square_at(sym: :b1))
    @board.pieces.each{|p| p.remove unless p == piece}
    piece.move(@board.square_at(sym: :d4))

    piece.legal_moves.length.should == 8
    piece.legal_moves.should include(@board.square_at(sym: :c2))
    piece.legal_moves.should include(@board.square_at(sym: :c6))
  end

  it "should list a square with a opposite-color piece on it as a valid square" do
    piece1 = @board.occupier(@board.square_at(sym: :b1))
    piece2 = @board.occupier(@board.square_at(sym: :b8))
    piece2.move(@board.square_at(sym: :a3))
    @board.pieces.each{|p| p.remove unless p == piece1 || p == piece2}

    piece1.legal_moves.length.should == 3
    piece1.legal_moves.should include(@board.square_at(sym: :a3))
  end
  
  it "should NOT list a square with a same-color piece on it as valid" do
    piece1 = @board.occupier(@board.square_at(sym: :b1))
    piece2 = @board.occupier(@board.square_at(sym: :f1))
    piece2.move(@board.square_at(sym: :a3))
    @board.pieces.each{|p| p.remove unless p == piece1 || p == piece2}

    piece1.legal_moves.length.should == 2
    piece1.legal_moves.should_not include(@board.square_at(sym: :a3))
  end

  it "should not list squares that leave king in check as legal moves" do
    w_knight = @board.occupier(@board.square_at(sym: :b1))
    b_bishop = @board.occupier(@board.square_at(sym: :c8))
    w_king = @board.occupier(@board.square_at(sym: :e1))
    @board.pieces.each{|p| p.remove unless p == w_knight or p == w_king or p == b_bishop }
    b_bishop.move(@board.square_at(sym: :c3))
    w_knight.move(@board.square_at(sym: :d2))

    w_knight.legal_moves.should == []
  end

end