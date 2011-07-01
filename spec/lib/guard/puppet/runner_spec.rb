require 'spec_helper'
require 'guard/puppet/runner'

describe Guard::Puppet::Runner do
  let(:options) { {} }
  let(:runner) { described_class.new(options) }

  describe '#command_line_params' do
    subject { runner.command_line_params }

    context 'default' do
      it { should == [ 'apply', %{--confdir="#{Dir.pwd}"}, '-v', 'manifests/site.pp' ] }
    end

    context 'not verbose' do
      let(:options) { { :verbose => false } }

      it { should == [ 'apply', %{--confdir="#{Dir.pwd}"}, 'manifests/site.pp' ] }
    end

    context 'manifest' do
      let(:options) { { :manifest => '123' } }

      it { should == [ 'apply', %{--confdir="#{Dir.pwd}"}, '-v', '123' ] }
    end
  end

  describe '#run' do
    it 'should return the result of an exit call' do
      ::Puppet::Util::CommandLine.expects(:new).raises(SystemExit.new(10))

      runner.run.should == 10
    end
  end
end
