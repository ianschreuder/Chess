require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Player" do

  it "should be able to be created if you pass a side" do
    lambda{ Player.new(:white)}.should_not raise_error(ArgumentError)
  end

  it "should generate a move given a current position" do
    p1 = Player.new(:white)
    p2 = Player.new(:black)
    game = Game.new(p1,p2)
    p1.move(game.position).should_not == nil
  end

end