# -*- encoding: utf-8 -*-
# stub: rubillow 0.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "rubillow"
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Matthew Vince"]
  s.date = "2013-06-16"
  s.description = "Ruby library to access the Zillow API"
  s.email = ["rubillow@matthewvince.com"]
  s.homepage = "https://github.com/synewaves/rubillow"
  s.licenses = ["MIT"]
  s.rubyforge_project = "rubillow"
  s.rubygems_version = "2.2.2"
  s.summary = "Ruby library to access the Zillow API"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.12"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<bluecloth>, ["~> 2.2"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.6"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.5.0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 2.12"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<bluecloth>, ["~> 2.2"])
      s.add_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_dependency(%q<coveralls>, ["~> 0.6"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.5.0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 2.12"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<bluecloth>, ["~> 2.2"])
    s.add_dependency(%q<simplecov>, ["~> 0.7"])
    s.add_dependency(%q<coveralls>, ["~> 0.6"])
  end
end
