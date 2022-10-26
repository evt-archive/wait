require_relative 'automated_init'

context "Poll" do
  context "Actuate Without Block" do
    cycle = Poll.build

    test "Is an error" do
      assert_raises(Poll::Error) do
        cycle.()
      end
    end
  end
end
