require 'rspec'

Dir[File.dirname(__FILE__) + '/../src/**/*.rb'].each {|file| require file }

RSpec.configure do |config|
  config.mock_with :rspec
end




