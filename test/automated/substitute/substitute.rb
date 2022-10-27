require_relative '../automated_init'

context "Substitute" do
  wait = Wait::Substitute.build

  test "Timeout time is 0" do
    assert(wait.timeout_milliseconds == 0)
  end

  test "Telemetry sink is activated" do
    refute(wait.telemetry_sink.nil?)
  end
end
