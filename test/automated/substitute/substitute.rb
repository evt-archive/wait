require_relative '../automated_init'

context "Substitute" do
  wait = Wait::Substitute.build

  test "Telemetry sink is activated" do
    refute(wait.telemetry_sink.nil?)
  end
end
