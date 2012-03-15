require 'spec_helper'

describe Spree::LineItem do 
  context 'validation' do 
    it { should have_many(:packages) }
  end
end
