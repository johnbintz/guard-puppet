require 'guard/puppet'
require 'puppet/util/command_line'
require 'puppet/application/apply'
require 'guard/puppet/log'

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
        messages = ::Puppet::Util::Log.newdestination(:guard)

        begin
          maybe_bundle_with_env do
            # TODO: hack, untested, needed to avoid:
            #
            #"Error: Could not initialize global default settings:
            #  Attempting to initialize global default settings more than once!"
            ::Puppet.settings.send(:clear_everything_for_tests)

            ::Puppet::Util::CommandLine.new('puppet', command_line_params).execute
          end
          0
        rescue SystemExit => e
          if e.status == 0
            if messages.has_failed?
              1
            else
              0
            end
          else
            e.status
          end
        ensure
          ::Puppet::Util::Log.close(:guard)
        end
      end

      def command_line_params
        command = [ "apply", %{--confdir="#{Dir.pwd}"} ]
        command << "-v" if @options[:verbose]
        command << "-d" if @options[:debug]
        command << @options[:manifest] if @options[:manifest]
        command
      end

      private
      def maybe_bundle_with_env(&block)
        if defined?(::Bundler)
          ::Bundler.with_clean_env(&block)
        else
          yield
        end
      end
    end
  end
end
