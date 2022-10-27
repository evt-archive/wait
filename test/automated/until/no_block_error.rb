require_relative '../automated_init'

context "Until" do
  context "Actuate Without Block" do
    test "Is an error" do
      assert_raises(Until::NoBlockError) do
        Until.()
      end
    end
  end
end
