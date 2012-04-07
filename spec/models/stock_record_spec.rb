require 'spec_helper'

describe Spree::StockRecord do
  context 'validation' do
    it { should have_valid_factory(:stock_record) }
    it { should belong_to(:variant) }
    it { should belong_to(:container_taxon) }
    it { should belong_to(:destocking_reason) }
  end
end
