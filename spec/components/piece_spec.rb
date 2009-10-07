require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'
require File.dirname(__FILE__) + '/../../src/components/piece'

describe "Piece" do

  it "should be instantiated with a type and square" do
    lambda{ Piece.new(:pawn, :a2)}.should_not raise_error(ArgumentError)
  end

  it "should know what row and column it is on" do
    pi = Piece.new(:pawn, :d2)
    pi.row.should == "d"
    pi.col.should == 2
  end
end