require_relative '../../automated_init'

context "Telemetry" do
  context "Action Got No Result" do
    interval_milliseconds = 1
    timeout_milliseconds = 0
    cycle = Until.build(interval_milliseconds: interval_milliseconds, timeout_milliseconds: timeout_milliseconds)

    sink = Until.register_telemetry_sink(cycle)

    cycle.() do
      false
    end

    test "Condition not satisfied" do
      refute(sink.recorded_condition_satisfied?)
    end

    test "Delayed" do
      assert(sink.recorded_delayed? do |record|
        record.data == 1
      end)
    end

    test "Timed out" do
      assert(sink.recorded_timed_out? do |record|
        record.data < Clock::UTC.now
      end)
    end
  end
end
