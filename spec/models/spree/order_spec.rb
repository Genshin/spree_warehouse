require 'spec_helper'

describe Spree::Order do 
  context 'validation' do 
    it { should have_many(:packages) }
    it { should have_valid_factory(:order) }
  end
end
