require_relative '../automated_init'

context "Boolean Block Result Type" do
  context "Not Boolean" do
    test "Is an error" do
      assert_raises(Wait::ResultTypeError) do
        Wait.() do
          :some_result
        end
      end
    end
  end

  context "Boolean" do
    context "True" do
      test "Isn't an error" do
        refute_raises(Wait::ResultTypeError) do
          Wait.() do
            true
          end
        end
      end
    end

    context "False" do
      test "Isn't an error" do
        refute_raises(Wait::ResultTypeError) do
          Wait.(timeout_milliseconds: 0) do
            false
          end
        end
      end
    end
  end

  context "Nil" do
    test "Is considered false" do
      refute_raises(Wait::ResultTypeError) do
        Wait.(timeout_milliseconds: 0) do
          nil
        end
      end
    end
  end
end
