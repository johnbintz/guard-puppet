require 'guard/compat/plugin'

module Guard
  class Puppet < Plugin
    class << self
      attr_accessor :is_wrapping_exit
    end

    def initialize(options = {})
      super
      @options = options

      UI.info "Guard::Puppet is watching for changes..."
      run_all if options[:run_on_start]
    end

    def run_all
      UI.info(msg = "Applying Puppet configuration...")
      Notifier.notify msg, :title => "Puppet Config", :image => :pending
      if Runner.new(@options).run != 0
        Notifier.notify(msg = "Puppet config failure!", :title => "Puppet Config", :image => :failed)
      else
        Notifier.notify(msg = "Puppet config reapplied successfully!", :title => "Puppet Config")
      end
      UI.info(msg)
    end

    def run_on_change(files = [])
      run_all
    end
  end
end

require 'guard/puppet/runner'
