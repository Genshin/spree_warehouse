require 'spec_helper'

describe Spree::Stock do
  context 'validation' do
    let(:stock) {Factory(:stock)}
    it { should belong_to(:stock_receipt) }
  end
end
