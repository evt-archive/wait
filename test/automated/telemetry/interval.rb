require_relative '../automated_init'

context "Telemetry" do
  context "Interval" do
    interval_milliseconds = 11

    wait = Wait.build

    sink = Wait.register_telemetry_sink(wait)

    cycle_limit = 2

    cycles = wait.(interval_milliseconds: interval_milliseconds) do |cycle|
      if cycle == cycle_limit
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
