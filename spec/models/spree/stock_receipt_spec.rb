require 'spec_helper'

describe Spree::StockReceipt do
  context 'validation' do
    let(:stock_receipt) {Factory(:stock_receipt)}
    it { should have_many(:stock) }
  end
end
