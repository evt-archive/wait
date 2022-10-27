require_relative '../../interactive_init'

context "Action Got No Result" do
  context "No Timeout" do
    cycle = Wait.build

    result = cycle.() do |i|
      puts i
      nil
    end

    fail "Waiting should never exit"
  end
end
