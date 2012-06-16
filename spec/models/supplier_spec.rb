require 'spec_helper'

describe Spree::Supplier do

  context 'validation' do
    it { should have_valid_factory(:supplier) }
    it { should have_many(:stock_records) }
  end

end