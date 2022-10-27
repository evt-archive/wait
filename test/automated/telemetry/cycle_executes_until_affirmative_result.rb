require_relative '../automated_init'

context "Wait" do
  context "Cycle Executes Wait Affirmative Result is Produced" do
    cycle = Wait.build

    sink = Wait.register_telemetry_sink(cycle)

    cycle_limit = 1

    cycles = cycle.() do |i|
      if i == cycle_limit
        true
      end
    end

    test "Condition was satisfied" do
      assert(sink.recorded_condition_satisfied?)
    end

    test "Recorded cycle" do
      recorded_cycle = sink.recorded_cycle? do |record|
        record.data == 0
      end

      assert(recorded_cycle)
    end

    test "Did not time out" do
      refute(sink.recorded_timed_out?)
    end

    test "Did not delay" do
      refute(sink.recorded_delayed?)
    end
  end
end
