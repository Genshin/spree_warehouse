require 'spec_helper'

describe Spree::Product do
  
  context "validations" do 
    it { should have_valid_factory(:product) }
  end

  context "product instance" do
    let(:product) do
      product = stub_model(Spree::Product)
      product.stub :master => stub_model(Spree::Variant)
      product
    end
    
    context "visual code" do
      it "should save visual code" do
        product.visual_code = "123456"
        product.save
        product.visual_code.should == "123456"
      end
    end

    context "#on_hand" do
      # Regression test for #898
      context 'returns the correct number of products on hand' do
        before do
          Spree::Config.set :track_inventory_levels => true
          product.master.stub :on_hand => 2
        end
        specify { product.on_hand.should == 2 }
      end
    end
    
  end
end
