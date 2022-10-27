# Until

Generalized implementation of execution-until-condition with support for timeout and polling interval.

## Example

``` ruby
result = Until.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  some_request() == "some value"
end
```

## Overview

- The block is executed repeatedly until the block evaluates to `true`
- Polling will continue indefinitely unless a timeout is specified
- The polling will sleep for the amount of interval milliseconds after executing the block if an interval milliseconds is specified

## Usage

### Polling Terminates When the Block Returns True

``` ruby
result = Until.() do
  true # Polling terminates immediately
end
```

### No Polling Interval

When no polling interval is specified, block re-executes immediately at the conclusion of the previous cycle.

``` ruby
Until.(timeout_milliseconds: 500) do
  false
end
```

### With a Polling Interval

When a polling interval is specified, block re-executes once per polling interval rather than executing immediately at the conclusion of the previous cycle.

This can relieve pressure from a resource that might otherwise be flooded with such a quick succession of requests if there were no polling interval specified. The polling interval can provide a pause between executions of the block.

``` ruby
Until.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  false # Polls for 500 milliseconds, with a 100 millisecond pause between cycles
end
```

If the cycle execution time is greater than the polling interval time, the block is re-executed immediately at the conclusion of the previous cycle.

``` ruby
Until.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  sleep 101/1000.0 # Cycle is longer than the polling interval. No pause between executions
  false
end
```

### No Timeout

Without specifying a timeout, polling will continue indefinitely while the block returns no result.

``` ruby
Until.() do
  false # Infinite loop with a no pause between execution cycles
end
```

``` ruby
Until.(interval_milliseconds: 100) do
  false # Infinite loop with a 100 millisecond pause between execution cycles
end
```

### With a Timeout

When a timeout is specified, polling will continue only as long as the duration of the timeout.

When the timeout occurs, `Until::TimeoutError` is raised.

``` ruby
result = Until.(timeout_milliseconds: 500) do
  false # Loops for 500 milliseconds, then raises
end
# => Until::TimeoutError
```

## License

The `Until` library is released under the [MIT License](https://github.com/eventide-project/Until/blob/master/MIT-License.txt).
