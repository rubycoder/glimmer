# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "glimmer".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["AndyMaleh".freeze]
  s.date = "2020-11-28"
  s.description = "Glimmer is a Ruby DSL Framework consisting of a DSL Engine and Observable/Observer/Data-Binding Library. Used in the Glimmer DSL for SWT (JRuby Desktop Development GUI Library), the Glimmer DSL for Tk (Ruby Desktop Development GUI Library), the Glimmer DSL for Opal (Web GUI Adapter for Desktop Apps), the Glimmer DSL for XML (& HTML), and the Glimmer DSL for CSS.".freeze
  s.email = "andy.am@gmail.com".freeze
  s.extra_rdoc_files = [
    "CHANGELOG.md",
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "CHANGELOG.md",
    "CONTRIBUTING.md",
    "LICENSE.txt",
    "PROCESS.md",
    "README.md",
    "VERSION",
    "glimmer.gemspec",
    "lib/glimmer.rb",
    "lib/glimmer/config.rb",
    "lib/glimmer/data_binding/model_binding.rb",
    "lib/glimmer/data_binding/observable.rb",
    "lib/glimmer/data_binding/observable_array.rb",
    "lib/glimmer/data_binding/observable_model.rb",
    "lib/glimmer/data_binding/observer.rb",
    "lib/glimmer/dsl/engine.rb",
    "lib/glimmer/dsl/expression.rb",
    "lib/glimmer/dsl/expression_handler.rb",
    "lib/glimmer/dsl/parent_expression.rb",
    "lib/glimmer/dsl/static_expression.rb",
    "lib/glimmer/dsl/top_level_expression.rb",
    "lib/glimmer/error.rb",
    "lib/glimmer/invalid_keyword_error.rb"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Glimmer Ruby DSL Engine".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<array_include_methods>.freeze, [">= 1.0.4", "< 2.0.0"])
    s.add_runtime_dependency(%q<facets>.freeze, [">= 3.1.0", "< 4.0.0"])
    s.add_development_dependency(%q<rspec-mocks>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<puts_debuggerer>.freeze, ["~> 0.10.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 10.1.0", "< 14.0.0"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 2.0.0", "< 3.0.0"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 6.2.1", "< 7.0.0"])
    s.add_development_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_development_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
    s.add_development_dependency(%q<rake-tui>.freeze, [">= 0"])
  else
    s.add_dependency(%q<array_include_methods>.freeze, [">= 1.0.4", "< 2.0.0"])
    s.add_dependency(%q<facets>.freeze, [">= 3.1.0", "< 4.0.0"])
    s.add_dependency(%q<rspec-mocks>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<puts_debuggerer>.freeze, ["~> 0.10.0"])
    s.add_dependency(%q<rake>.freeze, [">= 10.1.0", "< 14.0.0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 2.0.0", "< 3.0.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 6.2.1", "< 7.0.0"])
    s.add_dependency(%q<coveralls>.freeze, ["= 0.8.23"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.16.1"])
    s.add_dependency(%q<simplecov-lcov>.freeze, ["~> 0.7.0"])
    s.add_dependency(%q<rake-tui>.freeze, [">= 0"])
  end
end

