require 'spec_helper'

describe "Picking List" do
  
  Spree::Zone.delete_all
  let(:shipping_method) { Factory(:shipping_method, :zone => Spree::Zone.find_by_name('North America') || Factory(:zone, :name => 'North America')) }
  let(:order) { Factory(:completed_order_with_totals, :number => "R100", :state => "complete",  :shipping_method => shipping_method) }

  before(:each) do
    reset_spree_preferences do |config|
      config.allow_backorders = true
    end
    
    order.inventory_units.each do |iu|
      iu.update_attribute_without_callbacks('state', 'sold')
    end
    
    visit spree.admin_path
    sign_in_as!(Factory(:admin_user))

    click_link "Orders"
    within('table#listing_orders tbody tr:nth-child(1)') { click_link "R100" }
    
  end

  it "should allow to pick products and mark shipment as 'Picked' when all products are picked", :js => true do

    click_link "Shipments"
    click_on "New Shipment"
    check "inventory_units_ids_1"
    check "inventory_units_ids_2"
    click_button "Create"
    page.should have_content("successfully created!")
    order.reload
    order.shipments.count.should == 1

    click_link "Shipments"
    find('table.index tbody tr:nth-child(2) td:nth-child(5)').text.should == "Pending"
    
    click_link "Picking List"
    sleep 10
    within('table.index tbody tr:nth-child(2)') { click_button "Pick" }
    page.should have_content("Unit Picked")
    within('table.index tbody tr:nth-child(2)') { page.should have_content "Picked" }

    within('table.index tbody tr:nth-child(3)') { click_button "Pick" }
    page.should have_content("Shipment is Picked")
    within('table.index tbody tr:nth-child(3)') { page.should have_content "Picked" }

    click_link "Shipments"
    find('table.index tbody tr:nth-child(2) td:nth-child(5)').text.should == "Picked"
  end

end