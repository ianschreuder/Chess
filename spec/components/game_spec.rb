require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'
require File.dirname(__FILE__) + '/../../src/components/game'
require File.dirname(__FILE__) + '/../../src/components/player'
require File.dirname(__FILE__) + '/../../src/components/board'

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

end