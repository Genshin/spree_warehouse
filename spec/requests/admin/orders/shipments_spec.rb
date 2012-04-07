

require 'spec_helper'

describe "Shipments" do
  
  before(:each) do
    Spree::Zone.delete_all
    Spree::ShippingMethod.delete_all
    shipping_method = Factory(:shipping_method, :zone => Factory(:zone, :name => 'North America')) 
    @order = Factory(:completed_order_with_totals, :number => "R100", :state => "complete",  :shipping_method => shipping_method) 
    reset_spree_preferences do |config|
      config.allow_backorders = true
    end
    
    @order.inventory_units.each do |iu|
      iu.update_attribute_without_callbacks('state', 'sold')
    end
    
    visit spree.admin_path
    sign_in_as!(Factory(:admin_user))
    click_link "Orders"
    within('table#listing_orders tbody tr:nth-child(1)') { click_link "R100" }
    
  end
  context "shipments" do
    it "should be able to create and list shipments for an order", :js => true do
  
      click_link "Shipments"
      
      click_on "New Shipment"
      check "inventory_units_ids_1"
      click_button "Create"
      page.should have_content("successfully created!")
      @order.reload
      @order.shipments.count.should == 1
      
      click_link "Shipments"
      find('table.index tbody tr:nth-child(2) td:nth-child(1)').text.should == @order.shipment.number
      find('table.index tbody tr:nth-child(2) td:nth-child(5)').text.should == "Pending"
      
      within('table.index tbody tr:nth-child(2) td:nth-child(7)') { click_link "Edit" }
      page.should have_content("Shipment ##{@order.shipment.number}")
      #save_and_open_page
      #click_button "Update"
      #page.should have_content("successfully updated!")
      
    end
  end
  
  context "package" do
    
    it "should be able to create a new package for a shipment", :js => true do
      
      click_link "Shipments"
      click_on "New Shipment"

      page.has_select?("inventory_units_packages_1").should == true
      check "inventory_units_ids_1"
      
      click_button "Create"
      page.should have_content("successfully created!")
      @order.reload

      @order.shipment.packages.count.should == 1
    end
    
  end

end