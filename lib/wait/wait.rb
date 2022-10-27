class Wait
  Error = Class.new(RuntimeError)
  NoBlockError = Class.new(Error)
  TimeoutError = Class.new(Error)
  ResultTypeError = Class.new(Error)

  include Dependency
  include Log::Dependency

  dependency :clock, Clock::UTC
  dependency :telemetry, Telemetry

  attr_writer :interval_milliseconds
  def interval_milliseconds
    @interval_milliseconds ||= Defaults.interval_milliseconds
  end

  attr_accessor :timeout_milliseconds

  def self.build(interval_milliseconds: nil, timeout_milliseconds: nil)
    instance = new

    instance.interval_milliseconds = interval_milliseconds
    instance.timeout_milliseconds = timeout_milliseconds

    instance.configure

    instance
  end

  def self.configure(receiver, attr_name: nil, interval_milliseconds: nil, timeout_milliseconds: nil, poll: nil)
    attr_name ||= :poll

    if !poll.nil?
      instance = poll
    else
      instance = build(interval_milliseconds: interval_milliseconds, timeout_milliseconds: timeout_milliseconds)
    end

    receiver.public_send "#{attr_name}=", instance
  end

  def self.none
    None.build
  end

  def configure
    Clock::UTC.configure self
    ::Telemetry.configure self
  end

  def self.call(interval_milliseconds: nil, timeout_milliseconds: nil, &condition)
    instance = build(interval_milliseconds: interval_milliseconds, timeout_milliseconds: timeout_milliseconds)
    instance.call(&condition)
  end

  def call(&condition)
    if condition.nil?
      raise NoBlockError, "Wait must be actuated with a block"
    end

    stop_time = nil
    stop_time_iso8601 = nil
    if not timeout_milliseconds.nil?
      stop_time = clock.now + (timeout_milliseconds.to_f / 1000.0)
      stop_time_iso8601 = clock.iso8601(stop_time, precision: 5)
    end

    logger.trace { "Cycling (Interval Milliseconds: #{interval_milliseconds}, Timeout Milliseconds: #{timeout_milliseconds.inspect}, Stop Time: #{stop_time_iso8601.inspect})" }

    cycle = -1
    result = nil
    loop do
      cycle += 1
      telemetry.record :cycle, cycle

      result, elapsed_milliseconds = evaluate_condition(cycle, &condition)

      if result.nil?
        result = false
      end

      if not (result.is_a?(TrueClass) || result.is_a?(FalseClass))
        raise ResultTypeError, "The block result must be boolean (Result: #{result.inspect})"
      end

      if result == true
        logger.debug { "Cycle condition is met (Cycle: #{cycle})" }
        telemetry.record :condition_satisfied
        break
      end

      delay(elapsed_milliseconds)

      if !timeout_milliseconds.nil?
        now = clock.now
        if now >= stop_time
          logger.debug { "Timeout has lapsed (Cycle: #{cycle}, Stop Time: #{stop_time_iso8601}, Timeout Milliseconds: #{timeout_milliseconds})" }
          telemetry.record :timed_out, now
          break
        end
      end
    end

    logger.debug { "Cycled (Cycles: #{cycle + 1}, Interval Milliseconds: #{interval_milliseconds}, Timeout Milliseconds: #{timeout_milliseconds.inspect}, Stop Time: #{stop_time_iso8601})" }

    cycle_count = cycle + 1

    return cycle_count
  end

  def evaluate_condition(cycle, &condition)
    condition_start_time = clock.now

    logger.trace { "Evaluating condition (Cycle: #{cycle}, Start Time: #{clock.iso8601(condition_start_time, precision: 5)})" }

    result = condition.call(cycle)

    condition_end_time = clock.now
    elapsed_milliseconds = clock.elapsed_milliseconds(condition_start_time, condition_end_time)

    logger.debug { "Evaluated condition (Cycle: #{cycle}, Elapsed Milliseconds: #{elapsed_milliseconds}, Start Time: #{clock.iso8601(condition_start_time, precision: 5)}, End Time: #{clock.iso8601(condition_end_time, precision: 5)})" }

    [result, elapsed_milliseconds]
  end

  def delay(elapsed_milliseconds)
    delay_milliseconds = interval_milliseconds - elapsed_milliseconds

    logger.trace { "Delaying (Delay Milliseconds: #{delay_milliseconds}, Interval Milliseconds: #{interval_milliseconds}, Elapsed Milliseconds: #{elapsed_milliseconds})" }

    if delay_milliseconds <= 0
      logger.debug { "Elapsed time exceeds or equals interval. Not delayed. (Delay Milliseconds: #{delay_milliseconds}, Interval Milliseconds: #{interval_milliseconds}, Elapsed Milliseconds: #{elapsed_milliseconds})" }
      return
    end

    delay_seconds = (delay_milliseconds.to_f / 1000.0)

    sleep delay_seconds

    telemetry.record :delayed, delay_milliseconds

    logger.debug { "Finished delaying (Delay Milliseconds: #{delay_milliseconds}, Interval Milliseconds: #{interval_milliseconds}, Elapsed Milliseconds: #{elapsed_milliseconds})" }
  end

  def self.register_telemetry_sink(cycle)
    sink = Telemetry.sink
    cycle.telemetry.register(sink)
    sink
  end

  module Telemetry
    class Sink
      include ::Telemetry::Sink

      record :cycle
      record :condition_satisfied
      record :delayed
      record :timed_out
    end

    def self.sink
      Sink.new
    end
  end

  module Substitute
    def self.build
      instance = Wait.build(timeout_milliseconds: 0)

      sink = Wait.register_telemetry_sink(instance)
      instance.telemetry_sink = sink

      instance.configure

      instance
    end

    class Wait < ::Wait
      attr_accessor :telemetry_sink
    end
  end
end
