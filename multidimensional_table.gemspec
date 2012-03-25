# -*- encoding: utf-8 -*-
require File.expand_path('../lib/multidimensional_table/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["drKreso"]
  gem.email         = ["kresimir.bojcic@gmail.com"]
  gem.description   = %q{Describe a multidimensional table in pure Ruby}
  gem.summary       = %q{Attempt to make generic API for describing multidimensional data in Ruby}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "multidimensional_table"
  gem.require_paths = ["lib"]
  gem.version       = MultidimensionalTable::VERSION
end
