require File.dirname(__FILE__) + '/../spec_helper'

describe "Square" do
  before :all do
    @p1 = Player.new(WHITE)
    @p2 = Player.new(BLACK)
    @board = Board.new(@p1,@p2)
  end

  it "should correctly determine whether two squares are in a straight line to each other" do
    s1 = @board.square_at(3,3)
    @board.square_at(3,4).straight?(s1).should == true
    @board.square_at(3,2).straight?(s1).should == true
    @board.square_at(2,3).straight?(s1).should == true
    @board.square_at(4,3).straight?(s1).should == true
    @board.square_at(2,2).straight?(s1).should == false
    @board.square_at(4,4).straight?(s1).should == false
    @board.square_at(4,2).straight?(s1).should == false
    @board.square_at(2,4).straight?(s1).should == false
  end
  
  it "should correctly determine whether two squares are diagonally aligned to each other" do
    s1 = @board.square_at(3,3)
    @board.square_at(3,4).diagonal?(s1).should == false
    @board.square_at(3,2).diagonal?(s1).should == false
    @board.square_at(2,3).diagonal?(s1).should == false
    @board.square_at(4,3).diagonal?(s1).should == false
    @board.square_at(2,2).diagonal?(s1).should == true
    @board.square_at(4,4).diagonal?(s1).should == true
    @board.square_at(4,2).diagonal?(s1).should == true
    @board.square_at(2,4).diagonal?(s1).should == true
  end
  
  it "should reject itself as diagonal or straight with itself" do
    s1 = @board.square_at(3,3)
    @board.square_at(3,3).straight?(s1).should == false
    @board.square_at(3,3).diagonal?(s1).should == false
  end
  
  
end

