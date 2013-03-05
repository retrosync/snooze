require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'snooze'

# Include all files in the spec_helper directory
Dir[File.dirname(__FILE__) + "/lib/**/*.rb"].each do |file|
  require file
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered                = true
  config.color_enabled = true
  config.filter_run :focus
  config.order = 'random'
end