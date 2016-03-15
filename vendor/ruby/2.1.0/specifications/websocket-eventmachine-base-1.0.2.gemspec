# -*- encoding: utf-8 -*-
# stub: websocket-eventmachine-base 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "websocket-eventmachine-base"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bernard Potocki"]
  s.date = "2012-12-21"
  s.description = "WebSocket base for Ruby client and server"
  s.email = ["bernard.potocki@imanel.org"]
  s.homepage = "http://github.com/imanel/websocket-eventmachine-base"
  s.rubygems_version = "2.2.2"
  s.summary = "WebSocket base for Ruby client and server"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<websocket>, ["~> 1.0"])
      s.add_runtime_dependency(%q<websocket-native>, ["~> 1.0"])
      s.add_runtime_dependency(%q<eventmachine>, ["~> 1.0"])
    else
      s.add_dependency(%q<websocket>, ["~> 1.0"])
      s.add_dependency(%q<websocket-native>, ["~> 1.0"])
      s.add_dependency(%q<eventmachine>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<websocket>, ["~> 1.0"])
    s.add_dependency(%q<websocket-native>, ["~> 1.0"])
    s.add_dependency(%q<eventmachine>, ["~> 1.0"])
  end
end
