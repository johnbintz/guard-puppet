require 'guard/puppet'
require 'puppet/util/command_line'
require 'puppet/application/apply'

module Guard
  class Puppet
    class Runner
      attr_reader :options

      def initialize(options)
        @options = {
          :verbose => true,
          :manifest => 'manifests/site.pp'
        }.merge(options)
      end

      def run
        ::Puppet::Util::CommandLine.new('puppet', command_line_params).execute
        0
      rescue SystemExit => e
        e.status
      end

      def command_line_params
        command = [ "apply", %{--confdir="#{Dir.pwd}"} ]
        command << "-v" if @options[:verbose]
        command << @options[:manifest] if @options[:manifest]
        command
      end
    end
  end
end
