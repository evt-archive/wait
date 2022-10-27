require_relative 'automated_init'

context "Result Type" do
  context "Not Boolean" do
    test "Is an error" do
      assert_raises(Until::ResultTypeError) do
        Until.() do
          :some_result
        end
      end
    end
  end

  context "Boolean" do
    context "True" do
      test "Isn't an error" do
        refute_raises(Until::ResultTypeError) do
          Until.() do
            true
          end
        end
      end
    end

    context "False" do
      test "Isn't an error" do
        refute_raises(Until::ResultTypeError) do
          Until.(timeout_milliseconds: 0) do
            false
          end
        end
      end
    end
  end
end