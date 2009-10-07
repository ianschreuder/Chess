require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'
require File.dirname(__FILE__) + '/../../src/components/player'

describe "Player" do

  it "should be able to be created if you pass a side" do
    lambda{ Player.new(:white)}.should_not raise_error(ArgumentError)
  end

  it "should create 16 pieces for a new player" do
    p = Player.new(:white)
    p.pieces.length.should == 16
    p = Player.new(:black)
    p.pieces.length.should == 16
  end

  it "should put the pawns for a white player on row '2'" do
    p = Player.new(:white).pawns[0].row.should == 2
  end

end