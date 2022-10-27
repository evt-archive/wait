require_relative '../automated_init'

context "Wait" do
  context "Timeout" do
    timeout_milliseconds = 11

    start_time = Time.now
    cycles = Wait.(timeout_milliseconds: timeout_milliseconds) do
    end
    end_time = Time.now

    elapsed_milliseconds = (end_time - start_time) * 1000

    comment "Timeout Milliseconds: #{timeout_milliseconds.inspect}"
    comment "Elapsed Milliseconds: #{elapsed_milliseconds.inspect}"
    comment "Cycles: #{cycles.inspect}"

    test "Cycle executes until the timeout has lapsed" do
      assert(elapsed_milliseconds >= timeout_milliseconds)
    end
  end
end
