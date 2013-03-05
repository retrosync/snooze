module Snooze
  # The current version of snooze.
  # Do not change the value by hand; it will be updated automatically by the gem release script.
  VERSION = "0.2.0"

  API_HOST = 'http://api.snooze.io/api'
end

require 'snooze/button'
require 'snooze/post'
require 'snooze/post_snooze'
require 'snooze/post_backtrace'
