require_relative 'automated_init'

context "Until" do
  context "Defaults" do
    cycle = Until.build(interval_milliseconds: nil, timeout_milliseconds: nil)

    context "Interval Milliseconds" do
      default_interval_milliseconds = Until::Defaults.interval_milliseconds

      test "#{default_interval_milliseconds}" do
        assert(cycle.interval_milliseconds == default_interval_milliseconds)
      end
    end

    context "Timeout Milliseconds" do
      test "nil" do
        assert(cycle.timeout_milliseconds == nil)
      end
    end
  end
end
