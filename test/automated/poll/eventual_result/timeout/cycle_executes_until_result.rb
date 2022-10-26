require_relative '../../../automated_init'

context "Poll" do
  context "Action Got Eventual Result" do
    context "Timeout" do
      cycle = Poll.build(timeout_milliseconds: 11)

      cycles = nil
      cycle.() do |i|
        cycles = i + 1

        if i > 0
          :something
        end
      end

      test "Cycle exits when result is produced (Cycles: #{cycles})" do
        assert(cycles == 2)
      end
    end
  end
end
