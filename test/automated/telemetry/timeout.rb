require_relative '../automated_init'

context "Telemetry" do
  context "Timeout" do
    timeout_milliseconds = 0
    wait = Wait.build(timeout_milliseconds: timeout_milliseconds)

    sink = Wait.register_telemetry_sink(wait)

    wait.() do
    end

    test "Timed out" do
      assert(sink.recorded_timed_out?)
    end

    test "Recorded cycle" do
      recorded_cycle = sink.recorded_cycle? do |record|
        record.data == 0
      end

      assert(recorded_cycle)
    end

    test "Condition was not satisfied" do
      refute(sink.recorded_condition_satisfied?)
    end

    test "Did not delay" do
      refute(sink.recorded_delayed?)
    end
  end
end
