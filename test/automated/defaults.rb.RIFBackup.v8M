require_relative 'automated_init'

context "Poll" do
  context "Defaults" do
    cycle = Poll.build(interval_milliseconds: nil, timeout_milliseconds: nil, delay_condition: nil)

    context "Interval Milliseconds" do
      default_interval_milliseconds = Poll::Defaults.interval_milliseconds

      test "#{default_interval_milliseconds}" do
        assert(cycle.interval_milliseconds == default_interval_milliseconds)
      end
    end

    context "Timeout Milliseconds" do
      test "nil" do
        assert(cycle.timeout_milliseconds == nil)
      end
    end

    context "Delay Condition" do
      default_delay_condition = Poll::Defaults.delay_condition

      test "#{default_delay_condition}" do
        refute(cycle.delay_condition.nil?)
      end
    end
  end
end
