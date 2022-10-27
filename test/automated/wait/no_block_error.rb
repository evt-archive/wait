require_relative '../automated_init'

context "Wait" do
  context "Actuate Without Block" do
    test "Is an error" do
      assert_raises(Wait::NoBlockError) do
        Wait.()
      end
    end
  end
end
