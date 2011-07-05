module Puppet; end

require 'puppet/util'
require 'puppet/util/log'

::Puppet::Util::Log.newdesttype :guard do
  attr_reader :messages

  def initialize
    close
  end

  def handle(msg)
    @messages << msg
  end

  def close
    @messages = []
  end

  def has_failed?
    messages.find { |msg| (::Puppet::Util::Log.levels.index(msg.level)) >= 4 }
  end
end
