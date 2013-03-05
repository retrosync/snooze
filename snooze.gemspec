Gem::Specification.new do |s|
  s.name    = "Snooze"

  # Do not set the version and date field manually, this is done by the release script
  s.version = "0.1.0"
  s.date    = "2013-03-05"

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

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 2.8')

  s.authors  = ['Bart ten Brinke']
  s.email    = ['contact@snooze.io']
  s.homepage = 'http://snooze.io'

  # The files and test_files directives are set automatically by the release script.
  # Do not change them by hand, but make sure to add the files to the git repository.
  s.files      = %w(.gitignore Gemfile Gemfile.lock LICENSE README.rdoc Rakefile bin/snooze lib/snooze.rb snooze.gemspec spec/spec_helper.rb tasks/github-gem.rake)
  s.test_files = %w()
end
