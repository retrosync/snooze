require 'spec_helper'

describe Snooze::Button, 'button' do
  let (:button) { Snooze::Button.new('8765-1234') }
  let (:response) { Faraday::Response.new(:status => 200)}

  it "should initialize a dry run correctly" do
    dry_button = Snooze::Button.new('8765-1234', :dry_run => true)
    dry_button.dry_run.should == true
  end

  it "should capture the clock id" do
    button.clock_id.should == '8765-1234'
  end

  it "should call ping! if dry run" do
    button = Snooze::Button.new('8765-1234', :dry_run => true)
    Snooze::Post.should_receive(:ping!).once.and_return(response)
    button.snooze!
  end

  it "should support with_backtrace_do" do
    Snooze::Post.should_receive(:exception!).once.and_return(response)
    button.with_backtrace do
      raise 'terrible exception!'
    end
  end

  describe "snooze! status code handling" do
    it "should support 200" do
      Snooze::Post.should_receive(:snooze!).once.and_return(response)
      button.snooze!.should == 0
    end

    [500,404,403,100].each do |status_code|
      it "should support #{status_code}" do
        Snooze::Post.should_receive(:snooze!).once.and_return( Faraday::Response.new(:status => status_code) )
        button.snooze!.should == 1
      end
    end

  end

end