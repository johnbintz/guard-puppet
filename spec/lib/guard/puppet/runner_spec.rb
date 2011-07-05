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

    context 'debug' do
      let(:options) { { :debug =>  true} }

      it { should == [ 'apply', %{--confdir="#{Dir.pwd}"}, '-v', '-d', 'manifests/site.pp' ] }
    end
  end

  describe '#run' do
    before do
      ::Puppet::Util::CommandLine.expects(:new).raises(SystemExit.new(return_value))
    end

    context 'returns a non-zero value' do
      let(:return_value) { 10 }

      it 'should return the result of an exit call' do
        runner.run.should == return_value
      end
    end

    context 'returns a zero value' do
      let(:return_value) { 0 }
      let(:messages) do
        messages = stub
        messages.stubs(:has_failed?).returns(true)
        messages
      end

      before do
        Puppet::Util::Log.stubs(:newdestination).returns(messages)
      end

      it 'should check the status of the messages output' do
        runner.run.should == 1
      end
    end
  end
end
