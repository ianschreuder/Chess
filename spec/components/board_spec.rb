require File.dirname(__FILE__) + '/../spec_helper'

describe "Board" do

  it "should return all squares on the board" do
    Board.new.squares.length.should == 64
  end
  
  it "should return all squares diagonal to a passed square" do
    board = Board.new
    s1 = board.square_at(0,0)
    valids = [[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]].map{|val| board.square_at(val[0], val[1])}
    board.diagonals(s1).each{|sqr| valids.should include(sqr) }

    s2 = board.square_at(2,3)
    valids = [[0,1], [1,2], [3,4], [4,5], [5,6], [6,7], [0,5], [1,4], [3,2], [4,1], [5,0]].map{|val| board.square_at(val[0], val[1])}
    board.diagonals(s2).each{|sqr| valids.should include(sqr) }
  end
  
  it "should return all squares in a straight line to a passed square" do
    board = Board.new
    s1 = board.square_at(1,1)
    valids = [[0,1], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [1,0], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7]].map{|val| board.square_at(val[0], val[1])}
    board.straights(s1).each{|sqr| valids.should include(sqr) }
  end
  
  it "should return all squares that match a knight maneuver to a passed square" do
    board = Board.new
    s1 = board.square_at(1,1)
    valids = [[0,3], [2,3], [3,2], [3,0]].map{|val| board.square_at(val[0], val[1])}
    board.knight_squares(s1).each{|sqr| valids.should include(sqr) }

    s2 = board.square_at(3,3)
    valids = [[1,2], [1,4], [2,1], [2,5], [4,1], [4,5], [5,2], [5,4]].map{|val| board.square_at(val[0], val[1])}
    board.knight_squares(s2).each{|sqr| valids.should include(sqr)}
  end
  
  it "should return an empty array if we try to evaluate the path between two invalid path-related squares" do
    board = Board.new
    s1 = board.square_at(0,0)
    s2 = board.square_at(3,4)
    board.path(s1, s2).should == []
  end

  it "should determine the squares on a diagonal path between a start and end square, not including the ending square" do
    board = Board.new
    square1 = board.square_at(1,0)
    square2 = board.square_at(3,2)
    valids = [[2,1]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = board.square_at(0,0)
    square2 = board.square_at(7,7)
    valids = [[1,1], [2,2], [3,3], [4,4], [5,5], [6,6]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = board.square_at(4,7)
    square2 = board.square_at(0,3)
    valids = [[3,6], [2,5], [1,4]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1, square2).each{|square| valids.should include(square)}
  end
  
  it "should determine the squares on a straight path between a start and end square, not including the ending square" do
    board = Board.new
    square1 = board.square_at(1,0)
    square2 = board.square_at(4,0)
    valids = [[2,0], [3,0]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1, square2).each{|square| valids.should include(square)}
  
    square1 = board.square_at(1,0)
    square2 = board.square_at(1,4)
    valids = [[1,1], [1,2], [1,3]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1,square2).each{|square| valids.should include(square)}
  
    square1 = board.square_at(0,3)
    square2 = board.square_at(0,0)
    valids = [[0,1], [0,2]].map{|val| board.square_at(val[0], val[1])}
    board.path(square1, square2).each{|square| valids.should include(square)}
  end
  
  it "should find the square related to the passed coordinate key" do
    board = Board.new
    square = board.square_at(2,6)
    square.x.should == 2
    square.y.should == 6
  end


end