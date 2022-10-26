require_relative 'automated_init'

context "Poll's Result" do
  cycle = Poll.build

  result = cycle.() do
    :something
  end

  test "Is the action's result" do
    assert(result == :something)
  end
end
