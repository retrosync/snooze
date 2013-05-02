require 'spec_helper'

describe Snooze::Post do
  let (:test_connection) {
    Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post('api/action') { [200, {}, ''] }
        stub.post('api/ping') { [200, {:id=>"1234-5678"}, ''] }
        stub.post('api/snooze') { [200, {:id=>"1234-5678"}, ''] }
        stub.post('api/exception') { [200, {:id=>"1234-5678", :backtrace => "error\nwith\newlines"}, ''] }
      end
    end
  }

  it "should generate the correct path" do
    Snooze::Post.generate_uri_from_action('test').to_s.should == 'https://api.snooze.io/api/test'
  end

  it "should setup a faraday connection" do
    connection = Snooze::Post.setup_connection('http://www.example.com/')
    connection.is_a?(::Faraday::Connection).should be_true
    connection.url_prefix.to_s.should == 'http://www.example.com/'
  end

  it "should post to an action URL" do
    Snooze::Post.stub!(:setup_connection).and_return(test_connection)

    response = Snooze::Post.execute!('action', {:test_data => true})
    response.status.should == 200
  end

  describe 'ping' do
    it "should post to the ping URL" do
      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.ping!('1234-5678')
      response.status.should == 200
    end

    it "should handle unkown clock_ids" do
      test_connection = Faraday.new do |builder|
        builder.adapter :test do |stub|
          stub.post('api/ping') { [404, {:id=>"1234-5679"}, ''] }
        end
      end

      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.ping!('1234-5679')
      response.status.should == 404
    end
  end

  describe 'snooze' do
    it "should post to the snooze URL" do
      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.snooze!('1234-5678')
      response.status.should == 200
    end

    it "should handle unkown clock_ids" do
      test_connection = Faraday.new do |builder|
        builder.adapter :test do |stub|
          stub.post('api/snooze') { [404, {:id=>"1234-5679"}, ''] }
        end
      end

      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.snooze!('1234-5679')
      response.status.should == 404
    end
  end

  describe 'exception' do
    it "should post a backtrace to the snooze URL" do
      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.exception!('1234-5678', "error\nwith\newlines")
      response.status.should == 200
    end

    it "should handle unkown clock_ids" do
      test_connection = Faraday.new do |builder|
        builder.adapter :test do |stub|
          stub.post('api/exception') { [404, {:id=>"1234-5679", :backtrace => "error\nwith\newlines"}, ''] }
        end
      end

      Snooze::Post.stub!(:setup_connection).and_return(test_connection)
      response = Snooze::Post.exception!('1234-5679', "error\nwith\newlines")
      response.status.should == 404
    end
  end

  describe 'execute!' do
    it "should retry five times" do
      exception = Faraday::Error::TimeoutError.new('')
      Snooze::Post.stub!(:setup_connection).and_raise(exception)
      Snooze::Post.stub!(:sleep_for_a_while).and_return(true)
      Snooze::Post.should_receive(:execute!).exactly(5).times.and_call_original
      expect { Snooze::Post.execute!('noop', {:a => 'b'}) }.to raise_error(Snooze::ConnectionError)
    end

  end
end