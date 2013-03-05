# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec' do
  # Files that affect global scope -> run all specs when they change
  watch(%r{^lib/snooze.rb$}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
  watch('.rspec') { 'spec' }
  watch('Guardfile.lock') { 'spec' }

  # Specific files -> only run the associated spec file when they change
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/snooze/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
end