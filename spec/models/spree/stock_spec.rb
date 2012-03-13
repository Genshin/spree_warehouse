require 'spec_helper'

describe Spree::Stock do
  context 'validation' do
    let(:stock) {Factory(:stock)}
    it { should belong_to(:stock_receipt) }
    it { should belong_to(:container_taxon) }
    it { should belong_to(:variant) }
  end
end
