require File.dirname(__FILE__) + '/../spec_helper'

describe "Game" do
  
  before(:all) do
    @player1 = Player.new(WHITE)
    @player2 = Player.new(BLACK)
  end

  it "should run with two players" do
    lambda {Game.new(@player1, @player2)}.should_not raise_error(ArgumentError)
  end

  it "should have 32 pieces on a fresh board" do
    g = Game.new(@player1, @player2)
    g.board.pieces.length.should == 32
  end
  
  it "should know who's turn is next" do
    g = Game.new(@player1, @player2)
    g.current_player.should == @player1
  end
  
end