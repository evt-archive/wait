require_relative '../automated_init'

context "Until" do
  context "Predicate Produces Immediate Result" do
    cycles = Until.() do
      true
    end

    detail "Cycles: #{cycles.inspect}"

    test "Cycle is executed once" do
      assert(cycles == 1)
    end
  end
end
