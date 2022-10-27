require_relative 'interactive_init'

context "Cycle never stops" do
  wait = Wait.build

  result = wait.() do |cycle|
    puts cycle
  end

  fail "Waiting should never exit"
end
