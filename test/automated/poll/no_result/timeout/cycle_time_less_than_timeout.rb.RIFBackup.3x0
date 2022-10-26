require_relative '../../../automated_init'

context "Poll" do
  context "Action Got No Result" do
    context "Timeout" do
      context "Poll Time is Less than the Timeout Time" do
        timeout_milliseconds = 1
        cycle = Poll.build(timeout_milliseconds: timeout_milliseconds)

        cycles = nil
        cycle.() do |i|
          cycles = i + 1
          nil
        end

        test "Cycle executes until timeout elapses (Timeout Time: #{timeout_milliseconds}, Cycles: #{cycles})" do
          assert(cycles > 1)
        end
      end
    end
  end
end
