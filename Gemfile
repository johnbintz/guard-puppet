source "http://rubygems.org"

# Specify your gem's dependencies in guard-puppet.gemspec
gemspec

require 'rbconfig'
if RbConfig::CONFIG['host_os'] =~ /linux/
  gem 'libnotify'
end
