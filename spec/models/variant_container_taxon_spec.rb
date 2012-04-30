require 'spec_helper'

describe Spree::VariantContainerTaxon do
  let!(:variant_ct) { Factory(:variant_container_taxon, :quantity => 99) }
  
  context "validations" do 
    it { should belong_to(:variant) }
    it { should belong_to(:container_taxon) }
    it { should have_valid_factory(:variant_container_taxon) }
 

    context "quantity" do
      it "should validate quantity is greater than 0" do
        variant_ct.quantity = -1
        variant_ct.should be_invalid
      end
  
      it "should validate quantity is 0" do
        variant_ct.quantity = 0
        variant_ct.should be_valid
      end
    end

    context "active?" do
      it "should be false when deactivated_at is not 'nil'" do
        variant_ct.stub(:deactivated_at => Time.now)
        variant_ct.active?.should be_false
      end

      it "should be true when deactivated_at is 'nil'" do
        variant_ct.stub(:deactivated_at => nil)
        variant_ct.active?.should be_true
      end
    end

   end
end
