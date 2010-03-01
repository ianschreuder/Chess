require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Game" do
  
  before(:all) do
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
  end

  it "should run with two players" do
    lambda {Game.new(@player1, @player2)}.should_not raise_error(ArgumentError)
  end

  it "should have a board" do
    g = Game.new(@player1, @player2)
    g.board.class.should == Board
  end

  it "should have 32 pieces on a fresh board" do
    g = Game.new(@player1, @player2)
    g.board.pieces.length.should == 32
  end
  
  it "should know who's turn is next" do
    g = Game.new(@player1, @player2)
    g.current.should == @player1
  end
  
  it "should run to completion and declare a winner or stalemate" do
    g = Game.new(@player1, @player2)
    g.run
    g.complete?.should == true
    [@player1, @player2].should include(g.winner) unless g.stalemate?
  end

end