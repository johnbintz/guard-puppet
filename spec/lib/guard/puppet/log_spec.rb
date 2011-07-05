require 'spec_helper'
require 'guard/puppet/log'
require 'puppet/util/log'

describe 'guard logging for puppet' do
  let(:guard) { ::Puppet::Util::Log.destinations[:guard] }

  before do
    ::Puppet::Util::Log.newdestination(:guard)
  end

  it 'should receive a message' do
    guard.handle("test")
    guard.messages.should == [ "test" ]
  end

  it 'should not be a failure' do
    guard.handle(stub(:level => :info))
    guard.should_not have_failed
  end

  it 'should be a failure' do
    guard.handle(stub(:level => :err))
    guard.should have_failed
  end

  after do
    ::Puppet::Util::Log.close(:guard)
  end
end
