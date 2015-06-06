source "http://rubygems.org"

# Specify your gem's dependencies in guard-puppet.gemspec
gemspec development_group: :gem_build_tools

group :development do
  gem 'guard', '~> 2.12'
  gem 'guard-rspec', '~> 4.5'

  require 'rbconfig'
  if RbConfig::CONFIG['host_os'] =~ /linux/
    gem 'libnotify'
  end
end

group :test do
  gem 'rspec', '~> 2.99'
  gem 'mocha'
end

group :gem_build_tools do
end
