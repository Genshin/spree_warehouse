require 'spec_helper'

describe Spree::Package do
  context 'validation' do
    it { should belong_to(:order)} 
    it { should have_valid_factory(:package) }
  end
end
