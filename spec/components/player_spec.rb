require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'

describe "Player" do

  it "should be able to be created if you pass a side" do
    lambda{ Player.new(:white)}.should_not raise_error(ArgumentError)
  end

  it "should generate a move given a current position" do
    pawn = Pawn.new(:a2)
    p1 = Player.new(:white)
    p1.move(Position.new([pawn])).should_not == nil
  end

end