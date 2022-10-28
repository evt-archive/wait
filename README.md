# Wait

Generalized implementation of execution-until-condition with support for timeout and polling interval.

## Example

``` ruby
cycles = Wait.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  some_request() == "some value"
end
```

## Overview

- The block is executed repeatedly until the block evaluates to `true`
- The block can return a `true`, `false`, or `nil` value
- Polling will continue indefinitely unless a timeout is specified
- The polling will sleep for the amount of interval milliseconds after executing the block if an interval milliseconds is specified
- The count of cycles of block execution is returned

## Usage

``` ruby
Wait.() do
  true # Polling terminates
end
```

``` ruby
Wait.() do
  false # Polling doesn't terminate
end
```

### Timeout

#### With a Timeout

When a timeout is specified, polling will continue only as long as the duration of the timeout.

When the timeout occurs, `Wait::TimeoutError` is raised.

``` ruby
Wait.(timeout_milliseconds: 500) do
  false # Loops for 500 milliseconds, then raises
end
# => Wait::TimeoutError
```

#### No Timeout

Without specifying a timeout, polling will continue indefinitely while the block returns a `false` or `nil` value.

``` ruby
Wait.() do
  false # Infinite loop
end
```

### Polling Interval

#### With a Polling Interval

When a polling interval is specified, block re-executes once per polling interval rather than executing immediately at the conclusion of the previous cycle.

This can relieve pressure from a resource that might otherwise be flooded with such a quick succession of requests if there were no polling interval specified. The polling interval can provide a pause between executions of the block.

``` ruby
Wait.(interval_milliseconds: 100) do
  false
  # 100 millisecond delay between cycles
end
```

If the cycle execution time is greater than the polling interval time, the block is re-executed immediately at the conclusion of the previous cycle.

``` ruby
Wait.(interval_milliseconds: 100) do
  sleep 101/1000.0 # Cycle is longer than the polling interval. No pause between executions
  false
end
```

#### No Polling Interval

When no polling interval is specified, the condition block re-executes immediately at the conclusion of the previous cycle.

``` ruby
Wait.() do
  false
  # No delay between cycles
end
```

## License

The `Wait` library is released under the [MIT License](https://github.com/eventide-project/wait/blob/master/MIT-License.txt).
