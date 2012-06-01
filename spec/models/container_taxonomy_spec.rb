require 'spec_helper'

describe Spree::ContainerTaxonomy do

  context "validation" do
    it { should have_valid_factory(:container_taxonomy) }
    it { should have_valid_factory(:container_taxon) }
    it { should have_and_belong_to_many(:warehouses) }
  end

  context "shoulda validations" do
    it { should validate_presence_of(:name) }
  end

  context "#destroy" do
    before do
       @container_taxonomy = Factory(:container_taxonomy)
       @root_taxon = @container_taxonomy.root
       @child_taxon = Factory(:container_taxon, :container_taxonomy_id => @container_taxonomy.id, :parent => @root_taxon)
    end

    it "should destroy all associated taxons" do
      @container_taxonomy.destroy
      expect{ Spree::ContainerTaxon.find(@root_taxon.id) }.to raise_error(ActiveRecord::RecordNotFound)
      expect{ Spree::ContainerTaxon.find(@child_taxon.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end