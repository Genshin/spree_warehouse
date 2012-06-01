require 'spec_helper'

describe Spree::Warehouse do
  
  context "validations" do 
    it { should validate_presence_of(:name) }
    it { Factory(:warehouse).should validate_uniqueness_of(:name) }
    it { should have_valid_factory(:warehouse) }
    it { should have_and_belong_to_many(:container_taxonomies) }
  end
  
end