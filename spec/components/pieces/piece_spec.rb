require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Piece" do
  
  it "should determine the color automatically if we don't pass it explicitely" do
    Piece.new(:a4).color.should == :white
    Piece.new(:a5).color.should == :black
  end
  
  it "should list a newly created piece as not having moved" do
    Piece.new(:a2).moved?.should == false
  end
  
  it "should list a moved piece as having moved" do
    piece = Piece.new(:a2)
    piece.move(Square.new(:a3))
    piece.moved?.should == true
  end
  
  it "should be able to be removed" do
    piece = Piece.new(:a2)
    piece.remove
    piece.square.should == nil
  end
  

end