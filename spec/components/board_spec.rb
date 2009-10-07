require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../spec_utils'
require File.dirname(__FILE__) + '/../../src/components/board'

describe "Board" do

  it "should be able to be instantiated" do
    lambda{ Board.new()}.should_not raise_error(ArgumentError)
  end
end