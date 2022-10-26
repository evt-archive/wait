require_relative '../automated_init'

context "Substitute" do
  cycle = Poll::Substitute.build

  test "Timeout time is 0" do
    assert(cycle.timeout_milliseconds == 0)
  end

  test "Telemetry sink is activated" do
    refute(cycle.telemetry_sink.nil?)
  end
end
