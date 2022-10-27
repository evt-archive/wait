require_relative '../automated_init'

context "Wait" do
  context "Defaults" do
    wait = Wait.build(interval_milliseconds: nil, timeout_milliseconds: nil)

    context "Interval Milliseconds" do
      default_interval_milliseconds = Wait::Defaults.interval_milliseconds

      test "#{default_interval_milliseconds}" do
        assert(wait.interval_milliseconds == default_interval_milliseconds)
      end
    end

    context "Timeout Milliseconds" do
      test "nil" do
        assert(wait.timeout_milliseconds == nil)
      end
    end
  end
end
