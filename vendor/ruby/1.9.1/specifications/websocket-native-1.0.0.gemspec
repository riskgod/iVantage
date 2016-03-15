# -*- encoding: utf-8 -*-
# stub: websocket-native 1.0.0 ruby lib
# stub: ext/websocket_native_ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "websocket-native"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bernard Potocki"]
  s.date = "2012-11-19"
  s.description = "Native Extension for WebSocket gem"
  s.email = ["bernard.potocki@imanel.org"]
  s.extensions = ["ext/websocket_native_ext/extconf.rb"]
  s.files = ["ext/websocket_native_ext/extconf.rb"]
  s.homepage = "http://github.com/imanel/websocket-ruby-native"
  s.rubygems_version = "2.4.8"
  s.summary = "Native Extension for WebSocket gem"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.11"])
      s.add_development_dependency(%q<rake-compiler>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.11"])
      s.add_dependency(%q<rake-compiler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.11"])
    s.add_dependency(%q<rake-compiler>, [">= 0"])
  end
end
