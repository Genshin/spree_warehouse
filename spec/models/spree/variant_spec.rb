require 'spec_helper'

describe Spree::Variant do
  context 'validation' do
    it { should have_many(:stock) }
  end
end
