# Poll

Generalized implementation of polling with support for timeout and polling interval.

## Example

``` ruby
result = Poll.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  some_request()
end
```

## Overview

- The block is executed in a loop until it returns a value
- Polling will continue indefinitely unless a timeout is specified
- The polling interval avoids flooding the resource with requests

## Usage

### Polling Terminates When the Block Returns a Value

``` ruby
result = Poll.() do
  :something # Polling terminates immediately
end
```

### No Polling Interval

When no polling interval is specified, block re-executes immediately at the conclusion of the previous cycle.

``` ruby
result = Poll.(timeout_milliseconds: 500) do
  nil
end
```

This can have adverse effects if the resource being polled cannot withstand being flooded with such a quick succession of requests.

### With a Polling Interval

When a polling interval is specified, block re-executes once per polling interval rather than executing immediately at the conclusion of the previous cycle.

This can relieve pressure from a resource that might otherwise be flooded with such a quick succession of requests if there were no polling interval specified. The polling interval can provide a pause between executions of the block.

``` ruby
result = Poll.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  nil # Polls for 500 milliseconds, with a 100 millisecond pause between cycles
end
```

If the cycle execution time is greater than the polling interval time, the block is re-executed immediately at the conclusion of the previous cycle.

``` ruby
result = Poll.(interval_milliseconds: 100, timeout_milliseconds: 500) do
  sleep 101/1000.0 # Cycle is longer than the polling interval. No pause between executions
  nil
end
```

### No Timeout

Without specifying a timeout, polling will continue indefinitely while the block returns no result.

``` ruby
result = Poll.() do
  nil # Infinite loop with a no pause between execution cycles
end
```

``` ruby
result = Poll.(interval_milliseconds: 100) do
  nil # Infinite loop with a 100 millisecond pause between execution cycles
end
```

### With a Timeout

When a timeout is specified, polling will continue only as long as the duration of the timeout.

``` ruby
result = Poll.(timeout_milliseconds: 500) do
  nil # Loops for 500 milliseconds
end
```

### Delay Condition

When the _delay condition_ is met at the end of the execution of the block that the poller is given, the poller will delay for `interval_milliseconds`.

The delay condition is based on the value of what is returned from the block.

By default, polling stops when the block returns either `nil` or an object that responds to `empty?`

```ruby
Poll.(interval_milliseconds: 100) do
  nil # Poll loop restarts after 100 milliseconds delay because block returns nil
end
```

The delay condition can varied by specifying a lambda that will be evaluated to determine whether the block should be restarted.

```ruby
delay_condition = -> (result) { result.even?(result) }

Poll.(interval_milliseconds: 100, delay_condition: delay_condition) do
  2 # Result is even, therefore delay 100 milliseconds and re-execute the block
end

Poll.(interval_milliseconds: 100, delay_condition: delay_condition) do
  3 # Result is odd, therefore end the poll loop
end
```

## License

The `poll` library is released under the [MIT License](https://github.com/eventide-project/poll/blob/master/MIT-License.txt).
