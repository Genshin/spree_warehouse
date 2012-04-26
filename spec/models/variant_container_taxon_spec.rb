require 'spec_helper'

describe Spree::VariantContainerTaxon do
  
  context "validations" do 
    it { should belong_to(:variant) }
    it { should belong_to(:container_taxon) }
    it { should have_valid_factory(:variant_container_taxon) }
  end
end
