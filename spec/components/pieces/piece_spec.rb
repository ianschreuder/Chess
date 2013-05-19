require File.dirname(__FILE__) + '/../../spec_helper'

describe "Piece" do
  
  before :each do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
    @board = Board.new(@p1,@p2)
  end

  before :each do
    @board.reset
  end

  it "should list a newly created piece as not having moved" do
    @board.occupier(@board.square_at(sym: :a2)).moved?.should == false
  end
  
  it "should list a moved piece as having moved" do
    piece = @board.occupier(@board.square_at(sym: :a2))
    piece.move(@board.square_at(sym: :a4))

    piece.moved?.should == true
  end
  
  it "should be able to be removed" do
    piece = @board.occupier(@board.square_at(sym: :a2))
    piece.remove
    piece.removed?.should be_true
    piece.square.should == nil
  end
  

end