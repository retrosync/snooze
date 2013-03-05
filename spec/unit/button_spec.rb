require 'spec_helper'

describe Snooze::Button, 'button' do
  let (:button) { Snooze::Button.new('8765-1234') }

  it "should initialize a dry run correctly" do
    dry_button = Snooze::Button.new('8765-1234', :dry_run => true)
    dry_button.dry_run.should == true
  end

  it "should validate the clock_id"


  it "should support snooze!" do
    button.snooze!
  end

end