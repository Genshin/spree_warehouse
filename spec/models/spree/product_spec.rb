require 'spec_helper'

describe Spree::Product do

  context "class" do
    describe "visual_code" do
      it "should return the visual code for this Product" do
        #relation_type = Spree::RelationType.create!(:name => "Related Products", :applies_to => "Spree::Product")
        #Spree::Product.relation_types.should include(relation_type)
      end
    end
  end
end
