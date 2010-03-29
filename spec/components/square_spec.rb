require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Square" do

  it "should be able to be created if you pass a row+col" do
    lambda{ Square.new(:d2)}.should_not raise_error(ArgumentError)
  end
  
  it "should create a valid row/col from two notations a1 and 11" do
    Square.new(:b4).row.should == 4
    Square.new(:b4).col.should == 2
    Square.new(35).row.should == 5
    Square.new(35).col.should == 3
  end
  
  it "should identify a square with the same coords as the same square" do
    Square.new(:c3).should == Square.new(33)
    [Square.new(:c3)].should == [Square.new(33)]
    Square.new(:a3).should == Square.new(:a3)
    Square.new(:a4).should_not == Square.new(:a3)
  end
  
  it "should correctly determine whether two squares are horizontally aligned to each other" do
    s1 = Square.new(:c1)
    s2 = Square.new(:c8)
    s3 = Square.new(:a1)
    s4 = Square.new(:d4)
    s1.horizontal?(s2).should == true
    s1.horizontal?(s3).should == true
    s1.horizontal?(s4).should == false
  end
  
  it "should correctly determine whether two squares are diagonally aligned to each other" do
    s1 = Square.new(:c4)
    s2 = Square.new(:f7)
    s3 = Square.new(:a2)
    s4 = Square.new(:d4)
    s1.diagonal?(s2).should == true
    s1.diagonal?(s3).should == true
    s1.diagonal?(s4).should == false
  end
  
  
end

