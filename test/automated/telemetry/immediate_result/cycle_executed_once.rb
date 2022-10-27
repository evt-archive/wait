require_relative '../../automated_init'

context "Telemetry" do
  context "Action Got Immediate Result" do
    timeout_milliseconds = 0
    cycle = Until.build(timeout_milliseconds: timeout_milliseconds)

    sink = Until.register_telemetry_sink(cycle)

    cycle.() do
      true
    end

    test "Condition satisfied" do
      assert(sink.recorded_condition_satisfied?)
    end

    test "Did not delay" do
      refute(sink.recorded_delayed?)
    end

    test "Did not timeout" do
      refute(sink.recorded_timed_out?)
    end
  end
end
