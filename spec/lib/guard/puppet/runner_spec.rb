require 'spec_helper'
require 'guard/puppet/runner'

describe Guard::Puppet::Runner do
  let(:options) { {} }
  let(:runner) { described_class.new(options) }

  describe '#command_line_params' do
    subject { runner.command_line_params }

    context 'default' do
      it { should == [ 'apply' ] }
    end

    context 'verbose' do
      let(:options) { { :verbose => true } }

      it { should == [ 'apply', '-v' ] }
    end

    context 'config dir with path' do
      let(:options) { { :config_dir => '/123' } }

      it { should == [ 'apply', '--confdir="/123"' ] }
    end

    context 'config dir with true' do
      let(:options) { { :config_dir => true } }

      it { should == [ 'apply', %{--confdir="#{Dir.pwd}"} ] }
    end

    context 'manifest' do
      let(:options) { { :manifest => '123' } }

      it { should == [ 'apply', '123' ] }
    end
  end

  describe '#run' do
    it 'should return the result of an exit call' do
      ::Puppet::Util::CommandLine.expects(:new).raises(SystemExit.new(10))

      runner.run.should == 10
    end
  end
end
