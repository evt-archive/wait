require_relative '../automated_init'

context "Wait" do
  context "Predicate Produces Immediate Result" do
    cycles = Wait.() do
      true
    end

    detail "Cycles: #{cycles.inspect}"

    test "Cycle is executed once" do
      assert(cycles == 1)
    end
  end
end
