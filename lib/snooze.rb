module Snooze
  # The current version of snooze.
  # Do not change the value by hand; it will be updated automatically by the gem release script.
  VERSION = "0.2.0"

  API_HOST = 'http://api.snooze.io'
  API_PATH = 'api'
end

require 'faraday'
require 'uri'
require 'snooze/connection_error'
require 'snooze/button'
require 'snooze/post'