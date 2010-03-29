require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Board" do

  it "should return all squares on the board" do
    Board.squares.length.should == 64
    Board.squares[20].is_a?(Square).should == true
  end
  
  it "should return all squares diagonal to a passed square" do
    s1 = Square.new(:a1)
    valids = %w(b2 c3 d4 e5 f6 g7 h8).map{|val| Square.new(val.to_sym)}
    Board.diagonals(s1).each{|sqr| valids.should include(sqr)}
    s2 = Square.new(:c4)
    valids = %w(a2 b3 d5 e6 f7 g8 a6 b5 d3 e2 f1).map{|val| Square.new(val.to_sym)}
    Board.diagonals(s2).each{|sqr| valids.should include(sqr)}
  end
  
  it "should return all squares horizontal to a passed square" do
    s1 = Square.new(:b2)
    valids = %w(a2 c2 d2 e2 f2 g2 h2 b1 b3 b4 b5 b6 b7 b8).map{|val| Square.new(val.to_sym)}
    Board.horizontals(s1).each{|sqr| valids.should include(sqr)}
  end
  
  it "should return all squares that match a knight maneuver to a passed square" do
    s1 = Square.new(:b2)
    valids = %w(a4 c4 d3 d1).map{|val| Square.new(val.to_sym)}
    Board.knight_squares(s1).each{|sqr| valids.should include(sqr)}
    s2 = Square.new(:d4)
    valids = %w(b3 b5 c2 c6 e2 e6 f3 f5).map{|val| Square.new(val.to_sym)}
    Board.knight_squares(s2).each{|sqr| valids.should include(sqr)}
  end
  
  it "should return an empty array if we try to evaluate the path between two invalid path-related squares" do
    square1 = Square.new(:a1)
    square2 = Square.new(:d5)
    Board.path(square1, square2).should == []
  end

  it "should determine the squares on a diagonal path between a start and end square, not including the ending square" do
    square1 = Square.new(:b1)
    square2 = Square.new(:d3)
    valids = %w(c2).map{|val| Square.new(val.to_sym)}
    Board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:a1)
    square2 = Square.new(:h8)
    valids = %w(b2 c3 d4 e5 f6 g7).map{|val| Square.new(val.to_sym)}
    Board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:e8)
    square2 = Square.new(:a4)
    valids = %w(d7 c6 b5).map{|val| Square.new(val.to_sym)}
    Board.path(square1, square2).each{|square| valids.should include(square)}
  end
  
  it "should determine the squares on a straight path between a start and end square, not including the ending square" do
    square1 = Square.new(:b1)
    square2 = Square.new(:e1)
    valids = %w(c1 d1).map{|val| Square.new(val.to_sym)}
    Board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:b1)
    square2 = Square.new(:b5)
    valids = %w(b2 b3 b4).map{|val| Square.new(val.to_sym)}
    Board.path(square1,square2).each{|square| valids.should include(square)}
  
    square1 = Square.new(:a4)
    square2 = Square.new(:a1)
    valids = %w(a2 a3).map{|val| Square.new(val.to_sym)}
    Board.path(square1, square2).each{|square| valids.should include(square)}
  end
  
  it "should only create the squares once" do
    Board.squares.object_id.should == Board.squares.object_id
  end
  
  it "should find the square related to the passed coordinate key" do
    square = Square.new(:c7)
    Board.square_at(square.coord_key).coord_key.should == :c7
  end


end