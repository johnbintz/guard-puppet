# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/puppet/version"

Gem::Specification.new do |s|
  s.name        = "guard-puppet"
  s.version     = Guard::PuppetVersion::VERSION
  s.authors     = ["John Bintz"]
  s.email       = ["john@coswellproductions.com"]
  s.homepage    = ""
  s.summary     = %q{Reapply Puppet configs automatically using Guard.}
  s.description = %q{Reapply Puppet configs automatically using Guard.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'guard', '~> 2.12'
  s.add_dependency 'puppet', '~> 4.1'
end
