require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Board" do

  it "should be able to be instantiated" do
    lambda{ Board.new(nil, nil)}.should_not raise_error(ArgumentError)
  end
  
  it "should start with 32 pieces; 16 white, 16 black" do
    p1 = Player.new(:white)
    p2 = Player.new(:black)
    board = Board.new(p1, p2)
    board.black_pieces.length.should == 16
    board.white_pieces.length.should == 16
  end
end