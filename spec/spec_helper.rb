require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'snooze'

# Include all files in the spec_helper directory
Dir[File.dirname(__FILE__) + "/lib/**/*.rb"].each do |file|
  require file
end