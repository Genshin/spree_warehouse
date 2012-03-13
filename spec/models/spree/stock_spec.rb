require 'spec_helper'

describe Spree::Stock do
  context 'validation' do
    it { should belong_to(:stock_receipt) }
    it { should belong_to(:container_taxon) }
    it { should belong_to(:variant) }
    it { should have_valid_factory(:stock) }
  end
end
