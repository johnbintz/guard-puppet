require 'guard/guard'

module ::Guard
  class Puppet < ::Guard::Guard
    class << self
      attr_accessor :is_wrapping_exit
    end

    def initialize(watchers = [], options = {})
      super
      @options = options
    end

    def run_all
      UI.info(msg = "Applying Puppet configuration...")
      Notifier.notify msg, :title => "Puppet Config", :image => :pending
      if Runner.new(@options).run != 0
        Notifier.notify "Puppet config failure!", :title => "Puppet Config", :image => :failed
      else
        Notifier.notify "Puppet config reapplied successfully!", :title => "Puppet Config"
      end
    end

    def run_on_change(files = [])
      run_all
    end
  end
end

require 'guard/puppet/runner'
