require 'spec_helper'  
  
describe "change count_on_hand" do 
 
  let(:product) {Factory(:product, :name => 'Subaru Outback')}
   
  context "receiving stock" do 
    before do 
      Spree::Config.set :track_inventory_levels => true 
    end
    
    it "should increase variants count" do
      product.master.count_on_hand = 200
      product.master.add_count 5
      product.master.count_on_hand.should eql(205)
      product.on_hand.should eql(205)
    end
    
    it "should increase variant count_on_hand after creating a stock" do 
      product.master.count_on_hand = 100
      stock = Factory(:stock_record , :quantity => 100,  :variant => product.master) 
      product.master.count_on_hand.should eql(200)
    end
  end
end