require_relative '../automated_init'

context "Until" do
  context "Cycle Executes Until Affirmative Result is Produced" do
    cycles = Until.() do |cycle|
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
