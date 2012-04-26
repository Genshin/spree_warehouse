require 'spec_helper'  
  
describe "change count_on_hand" do 
  
  let(:product) { Factory(:product, :name => 'Subaru Outback') }
  
  context "stock management" do 
    before do 
      Spree::Config.set :track_inventory_levels => true 
    end
    
    it "should increase variants count" do
      product.master.count_on_hand = 200
      product.master.add_count 5
      product.master.count_on_hand.should eql(205)
      product.on_hand.should eql(205)
    end
    
    it "should increase variant count_on_hand after restock" do 
      product.master.count_on_hand = 100
      stock = Factory(:stock_record , :quantity => 100,  :variant => product.master, :direction => 'in') 
      product.master.count_on_hand.should eql(200)
    end

    it "should decrease variant count_on_hand after destock" do 
      product.master.count_on_hand = 100
      stock = Factory(:stock_record , :quantity => 50,  :variant => product.master, :direction => 'out') 
      product.master.count_on_hand.should eql(50)
    end
  end
end