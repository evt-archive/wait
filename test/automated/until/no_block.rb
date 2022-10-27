require_relative '../automated_init'

context "Until" do
  context "Actuate Without Block" do
    cycle = Until.build

    test "Is an error" do
      assert_raises(Until::Error) do
        cycle.()
      end
    end
  end
end
