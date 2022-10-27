require_relative '../automated_init'

context "Telemetry" do
  context "Interval" do
    interval_milliseconds = 11

    cycle = Until.build(interval_milliseconds: interval_milliseconds)

    sink = Until.register_telemetry_sink(cycle)

    cycle_limit = 2

    cycles = cycle.() do |i|
      if i == cycle_limit
        true
      end
    end

    test "Delayed" do
      assert(sink.recorded_delayed?)
    end

    test "Recorded cycle" do
      recorded_cycle = sink.recorded_cycle? do |record|
        record.data == 0
      end

      assert(recorded_cycle)
    end

    test "Condition was not satisfied" do
      assert(sink.recorded_condition_satisfied?)
    end

    test "Did not time out" do
      refute(sink.recorded_timed_out?)
    end
  end
end
