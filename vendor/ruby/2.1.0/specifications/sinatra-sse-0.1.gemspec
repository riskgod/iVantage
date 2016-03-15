# -*- encoding: utf-8 -*-
# stub: sinatra-sse 0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sinatra-sse"
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["radiospiel"]
  s.date = "2012-10-21"
  s.description = "Sinatra support for server sent events"
  s.email = "eno@radiospiel.org"
  s.homepage = "http://github.com/radiospiel/sinatra-sse"
  s.rubygems_version = "2.2.2"
  s.summary = "Sinatra support for server sent events"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<expectation>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
    else
      s.add_dependency(%q<expectation>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
    end
  else
    s.add_dependency(%q<expectation>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
  end
end
