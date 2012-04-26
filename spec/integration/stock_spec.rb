require 'spec_helper'  
  
describe "change count_on_hand" do 
  
  let(:product) { Factory(:product, :name => 'Subaru Outback') }
  
  context "count_on_hand" do 
    before do 
      Spree::Config.set :track_inventory_levels => true 
    end
    
    it "should increase variants count" do
      product.master.count_on_hand = 200
      product.master.add_count 5
      product.master.count_on_hand.should eql(205)
      product.on_hand.should eql(205)
    end
  end
end