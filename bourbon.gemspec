# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bourbon/version"

Gem::Specification.new do |s|
  s.name        = "bourbon"
  s.version     = Bourbon::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Phil LaPier", "Chad Mazzola", "Mike Burns"]
  s.email       = ["david@typekit.com"]
  s.homepage    = "https://github.com/ddemaree/bourbon"
  s.summary     = "A standard library of SCSS mixins for CSS3 and more"
  s.description = <<-DESC
Bourbon provides a simple yet robust set of Sass mixins (in SCSS syntax) for adding
CSS3 features to web pages while ensuring graceful degradation via browser prefixes.
It also includes some useful functions to aid in developing advanced styles, such as
modular scales based on the golden ratio, and a grid-width calculator.
  DESC

  s.rubyforge_project = "bourbon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('sass', '>= 3.1')
end
