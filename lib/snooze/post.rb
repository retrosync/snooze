class Snooze::Post

  # Setup the api host URI for the given action
  def self.generate_uri_from_action(action)
    URI.parse("#{Snooze::API_HOST}/#{Snooze::API_PATH}/#{action}")
  end

  # Setup the connection
  def self.setup_connection(uri)
    ::Faraday.new(:url => uri)
  end

  # Execute an HTTP post
  def self.execute!(action, post_body, retries = 4)
    uri = self.generate_uri_from_action(action)
    response = nil

    begin
      connection = self.setup_connection(uri)

      response = connection.post uri.path do |request|
        request.headers['Content-Type'] = 'application/json'
        request.options[:timeout] = 5
        request.options[:open_timeout] = 2
        request.body = post_body
      end

      raise Faraday::Error::ConnectionFailed.new('') if response.status == 500
    rescue Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ClientError, Faraday::Error => e
      raise Snooze::ConnectionError if retries <= 0
      sleep_for_a_while(5 - retries)
      response = self.execute!(action, post_body, retries-1)
    end

    response
  end

  # Ping Snooze
  def self.ping!(clock_id)
    self.execute!('ping', "{ \"id\":\"#{clock_id}\" }" )
  end

  # Snooze an alarm
  def self.snooze!(clock_id)
    self.execute!('snooze', "{ \"id\":\"#{clock_id}\" }")
  end

  # Pass an exception backtrace to Snooze
  def self.exception!(clock_id, backtrace="")
    self.execute!('exception', "{ \"id\":\"#{clock_id}\", \"backtrace\":\"#{backtrace}\" }")
  end

  private
  def self.sleep_for_a_while(seconds)
    sleep(seconds)
  end

end