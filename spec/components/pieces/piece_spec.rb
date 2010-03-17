require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/../../spec_utils'

describe "Piece" do
  
  it "should determine the color automatically if we don't pass it explicitely" do
    Piece.new(:a4).color.should == :white
    Piece.new(:a5).color.should == :black
  end

end