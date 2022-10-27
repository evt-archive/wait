require_relative '../automated_init'

context "Until" do
  context "Interval" do
    interval_milliseconds = 11

    cycle_limit = 2

    start_time = Time.now
    cycles = Until.(interval_milliseconds: interval_milliseconds) do |cycle|
      if cycle == cycle_limit
        true
      end
    end
    end_time = Time.now

    elapsed_milliseconds = (end_time - start_time) * 1000

    predicted_wait_milliseconds = cycle_limit * interval_milliseconds

    comment "Interval Milliseconds: #{interval_milliseconds.inspect}"
    comment "Elapsed Milliseconds: #{elapsed_milliseconds.inspect}"
    comment "Cycles: #{cycles.inspect}"
    comment "Predicted Wait Milliseconds: #{predicted_wait_milliseconds.inspect}"

    test "Cycle delays the specified time" do
      assert(elapsed_milliseconds >= predicted_wait_milliseconds)
    end
  end
end
