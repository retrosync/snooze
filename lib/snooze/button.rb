class Snooze::Button

  attr_reader :dry_run, :clock_id, :method, :verbose

  def initialize(clock_id, options = {})
    @clock_id = clock_id
    @dry_run = options[:dry_run] || false
    @method = @dry_run ? :ping! : :snooze!
    @verbose = options[:verbose] || false
  end

  # Send snooze! or ping! to Snooze
  def snooze!
    log "Sending #{@method} to Snooze.io"
    handle_post_response { Snooze::Post.send(@method, @clock_id) }
  end

  # With backtrace capturing do
  def with_backtrace(&block)
    begin
      log "Yielding backtrace block"
      yield if block_given?
      Snooze::Post.snooze!
    rescue Exception => detail
      handle_post_response { Snooze::Post.exception!(@clock_id, detail.backtrace.join("\n  ")) }
    end
  end

  private
  # Handle a post response
  # The block given should be a Snooze::Post class function.
  def handle_post_response(&block)
    exit_code = 1
    begin
      response = yield
      exit_code = 0 if response.success?
      log "Error: Snooze returned status error #{response.status}" unless response.success?
    rescue Snooze::ConnectionError
      log "Error: Snooze server is unreachable"
    end
    exit_code
  end

  def log(msg)
    puts msg if @verbose
  end
end