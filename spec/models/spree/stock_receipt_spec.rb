require 'spec_helper'

describe Spree::StockReceipt do
  context 'validation' do
    it { should have_many(:stock) }
    it { should have_valid_factory(:stock_receipt) }
  end
end
