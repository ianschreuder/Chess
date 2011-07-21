require 'rubygems'
require 'rspec'
require 'rspec/core/rake_task'

task :default => [:spec]

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = '--format progress'
end

namespace :cover_me do
  task :report do
    require 'cover_me'
    CoverMe.complete!
  end
end
task :spec do
  Rake::Task['cover_me:report'].invoke
end