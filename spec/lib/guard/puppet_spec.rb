require 'spec_helper'
require 'guard/puppet'
require 'guard/ui'
require 'guard/notifier'

describe Guard::Puppet do
  let(:guard) { described_class.new }

  describe '#initialize' do
    before do
      Guard::UI.stubs(:info)
    end

    context 'without :run_on_start' do
      it 'should not run anything' do
        described_class.new
      end
    end

    context 'with :run_on_start' do
      it 'should run Puppet on start' do
        Guard::Puppet.any_instance.expects(:run_all)

        described_class.new([], { :run_on_start => true })
      end
    end
  end

  describe '#run_all' do
    before do
      Guard::UI.stubs(:info)
      Guard::Notifier.expects(:notify).with("Applying Puppet configuration...", { :image => :pending, :title => "Puppet Config" })
      Guard::Puppet::Runner.any_instance.expects(:run).returns(return_value)
    end

    context 'fails' do
      let(:return_value) { 1 }

      it 'should show the failure message' do
        Guard::Notifier.expects(:notify).with("Puppet config failure!", :image => :failed, :title => "Puppet Config")
        guard.run_all
      end
    end

    context 'succeeds' do
      let(:return_value) { 0 }

      it 'should show the success message' do
        Guard::Notifier.expects(:notify).with("Puppet config reapplied successfully!", :title => "Puppet Config")
        guard.run_all
      end
    end
  end
end
