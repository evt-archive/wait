ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= 'trace'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'until/controls'

require 'test_bench'; TestBench.activate

require 'pp'

Controls = Until::Controls
