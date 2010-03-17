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
  
  it "should return all squares on the board" do
    Square.squares.length.should == 64
    Square.squares[20].is_a?(Square).should == true
  end
  
  it "should identify a square with the same coords as the same square" do
    Square.new(:c3).should == Square.new(33)
    [Square.new(:c3)].should == [Square.new(33)]
    Square.new(:a3).should == Square.new(:a3)
    Square.new(:a4).should_not == Square.new(:a3)
  end
  
  it "should return all squares diagonal to a passed square" do
    s1 = Square.new(:a1)
    valids = %w(b2 c3 d4 e5 f6 g7 h8).map{|val| Square.new(val.to_sym)}
    s1.diagonals.each{|sqr| valids.should include(sqr)}
    s2 = Square.new(:c4)
    valids = %w(a2 b3 d5 e6 f7 g8 a6 b5 d3 e2 f1).map{|val| Square.new(val.to_sym)}
    s2.diagonals.each{|sqr| valids.should include(sqr)}
  end
  
  it "should return all squares horizontal to a passed square" do
    s1 = Square.new(:b2)
    valids = %w(a2 c2 d2 e2 f2 g2 h2 b1 b3 b4 b5 b6 b7 b8).map{|val| Square.new(val.to_sym)}
    s1.horizontals.each{|sqr| valids.should include(sqr)}
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
  
  it "should return all squares that match a knight maneuver to a passed square" do
    s1 = Square.new(:b2)
    valids = %w(a4 c4 d3 d1).map{|val| Square.new(val.to_sym)}
    s1.knight_squares.each{|sqr| valids.should include(sqr)}
    s2 = Square.new(:d4)
    valids = %w(b3 b5 c2 c6 e2 e6 f3 f5).map{|val| Square.new(val.to_sym)}
    s2.knight_squares.each{|sqr| valids.should include(sqr)}
  end
  
  it "should return an empty array if we try to evaluate the path between two invalid path-related squares" do
    square1 = Square.new(:a1)
    square2 = Square.new(:d5)
    square1.path(square2).should == []
  end

  it "should determine the squares on a diagonal path between a start and end square, not including the ending square" do
    square1 = Square.new(:b1)
    square2 = Square.new(:d3)
    valids = %w(c2).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:a1)
    square2 = Square.new(:h8)
    valids = %w(b2 c3 d4 e5 f6 g7).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:e8)
    square2 = Square.new(:a4)
    valids = %w(d7 c6 b5).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  end
  
  it "should determine the squares on a straight path between a start and end square, not including the ending square" do
    square1 = Square.new(:b1)
    square2 = Square.new(:e1)
    valids = %w(c1 d1).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:b1)
    square2 = Square.new(:b5)
    valids = %w(b2 b3 b4).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:a4)
    square2 = Square.new(:a1)
    valids = %w(a2 a3).map{|val| Square.new(val.to_sym)}
    square1.path(square2).each{|square| valids.should include(square)}
  end
  
end

