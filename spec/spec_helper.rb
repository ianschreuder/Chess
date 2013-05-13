require 'rubygems'
require 'rspec'

begin
  require 'spork'
rescue LoadError
  module Spork
    def self.prefork
      yield
    end

    def self.each_run
      yield
    end
  end
end

Spork.prefork do
  require 'rspec/autorun'
  require 'autotest/rspec2'

  require File.dirname(__FILE__) + '/../src/components/pieces/piece.rb'
  Dir['./src/**/*.rb'].map {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
  end

end

Spork.each_run do
end



