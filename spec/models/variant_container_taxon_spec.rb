require 'spec_helper'

describe Spree::VariantContainerTaxon do
  
  context "validations" do 
    it { should belong_to(:variant) }
    it { should belong_to(:container_taxon) }
  end
  
end
