# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-wait'
  s.version = '2.0.0.0'
  s.summary = 'Generalized implementation of execution-until-condition with support for timeout and polling interval'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/wait'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'

  s.add_runtime_dependency 'evt-log'
  s.add_runtime_dependency 'evt-telemetry'
  s.add_runtime_dependency 'evt-clock'

  s.add_development_dependency 'test_bench'
end
