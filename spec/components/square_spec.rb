require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'
require File.dirname(__FILE__) + '/../../src/components/square'

describe "Square" do

  it "should be able to be created if you pass a spot" do
    lambda{ Square.new(:d2)}.should_not raise_error(ArgumentError)
  end

  it "should determine if the starting position is white or black" do
    Square.new(:a2).start_white?.should == true
    Square.new(:f1).start_white?.should == true
    Square.new(:f8).start_black?.should == true
    Square.new(:c7).start_black?.should == true
    Square.new(:b3).start_white?.should == false
    Square.new(:b6).start_black?.should == false
  end

end