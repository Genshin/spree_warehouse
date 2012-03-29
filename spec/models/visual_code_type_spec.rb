require 'spec_helper'

describe Spree::VisualCodeType do
  context "validations" do 
    it { should validate_presence_of(:name) }
    it { Factory(:visual_code_type).should validate_uniqueness_of(:name) }
    it { should have_valid_factory(:visual_code_type) }
  end
end
