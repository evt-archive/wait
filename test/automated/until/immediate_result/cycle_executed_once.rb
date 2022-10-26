require_relative '../../automated_init'

context "Until" do
  context "Action Got Immediate Result" do
    cycle = Until.build

    cycles = nil
    cycle.() do |i|
      cycles = i + 1

      :something
    end

    test "Cycle is executed once and then exits (Cycles: #{cycles})" do
      assert(cycles == 1)
    end
  end
end
