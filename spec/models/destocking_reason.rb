require 'spec_helper'

describe Spree::DestockingReason do
  
  context "validations" do 
    it { should have_valid_factory(:destocking_reason) }
    it { should validate_presence_of(:name) }
    it { Factory(:destocking_reason).should validate_uniqueness_of(:name) }
  end
end
