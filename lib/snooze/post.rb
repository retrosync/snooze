class Snooze::Post

  # Setup a connection to the api host
  def self.generate_uri_from_action(action)
    URI.parse("#{Snooze::API_HOST}/#{Snooze::API_PATH}/#{action}")
  end

  def self.setup_connection(uri)
    ::Faraday.new(:url => uri)
  end

  def self.execute!(action, post_parameters)
    uri = self.generate_uri_from_action(action)
    connection = self.setup_connection(uri)

    connection.send('post', uri.path, post_parameters) do |request|
      request.headers['Content-Type'] = 'application/json'
      request.options[:timeout] = 5
      request.options[:open_timeout] = 2
    end
  end

  def self.ping!(clock_id)
    self.execute!('ping', :id => clock_id)
  end

  def self.snooze!(clock_id)
    self.execute!('snooze', :id => clock_id)
  end

end