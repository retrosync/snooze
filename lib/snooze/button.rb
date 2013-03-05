class Snooze::Button

  attr_reader :dry_run
  attr_reader :clock_id

  def initialize(clock_id, options = {})
    @clock_id = clock_id
    @dry_run = options[:dry_run] || false
  end

  def snooze!
  end

end