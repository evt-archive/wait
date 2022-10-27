require_relative '../automated_init'

context "Wait" do
  context "Cycle Executes Wait Affirmative Result is Produced" do
    cycles = Wait.() do |cycle|
      if cycle == 1
        true
      end
    end

    detail "Cycles: #{cycles.inspect}"

    test do
      assert(cycles == 2)
    end
  end
end
