Gem::Specification.new do |s|
  s.name    = "snooze"

  # Do not set the version and date field manually, this is done by the release script
  s.version = "1.0.0"
  s.date    = "2013-05-03"

  s.bindir             = 'bin'
  s.executables        = ['snooze']
  s.default_executable = 'snooze'

  s.summary     = "A command line tool to inform the webservice at snooze.io that a job has run."
  s.description = <<-eos
  For devops who run recurring jobs like rake tasks or bas scripts,
  Snooze.io is a notification service that tells you when something is wrong.
  Unlike just alerting when a job breaks, Snooze also alerts when a job did not run at all.
  eos

  s.rdoc_options << '--title' << s.name << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source'
  s.extra_rdoc_files = ['README.rdoc']

  s.add_dependency('faraday')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 2.8')
  s.add_development_dependency('guard-rspec')
  s.add_development_dependency('rb-fsevent')

  s.authors  = ['Bart ten Brinke']
  s.email    = ['contact@snooze.io']
  s.homepage = 'http://snooze.io'

  # The files and test_files directives are set automatically by the release script.
  # Do not change them by hand, but make sure to add the files to the git repository.
  s.files      = %w(.gitignore .travis.yml Gemfile Gemfile.lock Guardfile LICENSE README.rdoc Rakefile bin/snooze lib/snooze.rb lib/snooze/button.rb lib/snooze/connection_error.rb lib/snooze/post.rb snooze.gemspec spec/spec_helper.rb spec/unit/button_spec.rb spec/unit/post_spec.rb tasks/github-gem.rake)
  s.test_files = %w(spec/unit/button_spec.rb spec/unit/post_spec.rb)
end
