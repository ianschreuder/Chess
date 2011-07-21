require File.dirname(__FILE__) + '/../spec_helper'

describe "Square" do

  it "should be able to be created if you pass a row,col" do
    lambda{ Square.new(0,0)}.should_not raise_error(ArgumentError)
  end
  
  it "should correctly determine whether two squares are in a straight line to each other" do
    s1 = Square.new(3,3)
    Square.new(3,4).straight?(s1).should == true
    Square.new(3,2).straight?(s1).should == true
    Square.new(2,3).straight?(s1).should == true
    Square.new(4,3).straight?(s1).should == true
    Square.new(2,2).straight?(s1).should == false
    Square.new(4,4).straight?(s1).should == false
    Square.new(4,2).straight?(s1).should == false
    Square.new(2,4).straight?(s1).should == false
  end
  
  it "should correctly determine whether two squares are diagonally aligned to each other" do
    s1 = Square.new(3,3)
    Square.new(3,4).diagonal?(s1).should == false
    Square.new(3,2).diagonal?(s1).should == false
    Square.new(2,3).diagonal?(s1).should == false
    Square.new(4,3).diagonal?(s1).should == false
    Square.new(2,2).diagonal?(s1).should == true
    Square.new(4,4).diagonal?(s1).should == true
    Square.new(4,2).diagonal?(s1).should == true
    Square.new(2,4).diagonal?(s1).should == true
  end
  
  it "should reject itself as diagonal or straight with itself" do
    s1 = Square.new(3,3)
    Square.new(3,3).straight?(s1).should == false
    Square.new(3,3).diagonal?(s1).should == false
  end
  
  
end

