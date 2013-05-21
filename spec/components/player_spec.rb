require File.dirname(__FILE__) + '/../spec_helper'

describe "Player" do

  it "should be able to be created if you pass a side" do
    lambda{ Player.new(WHITE)}.should_not raise_error(ArgumentError)
  end

  it "should generate a move given a current position" do
    @player1 = Player.new(WHITE)
    @player2 = Player.new(BLACK)
    @board = Board.new(@player1, @player2)
    @player1.next_move.class.should == Move
  end

end