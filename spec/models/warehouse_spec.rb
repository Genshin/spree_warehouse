require 'spec_helper'

describe Spree::Warehouse do
  
  context "validations" do 
    it { should validate_presence_of(:name) }
    it { Factory(:warehouse).should validate_uniqueness_of(:name) }
    it { should have_valid_factory(:warehouse) }
  end
  
end
