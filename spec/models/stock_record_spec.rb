require 'spec_helper'

describe Spree::StockRecord do
  
  before do 
  	product = Factory(:product)
    @stock_record = Factory(:stock_record, :variant => product.master, :quantity => 99 , :direction => 'in')
  end
  

  context 'validations' do
    it { should have_valid_factory(:stock_record) }
    it { should belong_to(:variant) }
    it { should belong_to(:container_taxon) }
    it { should belong_to(:destocking_reason) }
    it { should belong_to(:supplier) }
  end

  context "quantity" do
    it "should validate quantity is greater than 0" do
      @stock_record.quantity = -1
      @stock_record.should be_invalid
    end
  
    it "should validate quantity is 0" do
      @stock_record.quantity = 0
      @stock_record.should be_valid
    end
  end
end