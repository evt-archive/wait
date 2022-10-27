require_relative '../automated_init'

context "Until" do
  context "Result" do
    cycles = nil
    result_cycles = Until.() do |cycle|
      comment "Cycle: #{cycle}"
      cycles = cycle + 1

      if cycle > 0
        true
      end
    end

    comment "Cycles: #{cycles}"
    comment "Result Cycles: #{result_cycles}"

    test "Count of cycles executed" do
      assert(result_cycles == cycles)
    end
  end
end
