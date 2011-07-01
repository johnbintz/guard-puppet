require 'guard/puppet'
require 'puppet/util/command_line'
require 'puppet/application/apply'

module Guard
  class Puppet
    class Runner
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def run
        ::Puppet::Util::CommandLine.new('puppet', command_line_params)
      rescue SystemExit => e
        e.status
      end

      def command_line_params
        command = [ "apply" ]
        command << "-v" if @options[:verbose]
        if @options[:config_dir]
          @options[:config_dir] = Dir.pwd if @options[:config_dir] == true
          command << %{--confdir="#{@options[:config_dir]}"} if @options[:config_dir]
        end
        command << @options[:manifest] if @options[:manifest]
        command
      end
    end
  end
end
