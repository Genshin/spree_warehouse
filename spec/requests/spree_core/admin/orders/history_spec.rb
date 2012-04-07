require 'spec_helper'

describe "Admin visiting history" do
  it "should display order history", :js => true do
    order = Factory(:order)
    order.finalize!

    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
    click_link "Orders"
    within(:css, 'table#listing_orders tbody tr:nth-child(1)') { click_link "Edit" }
    click_link "History"

    find('table.index tbody tr:nth-child(2) td:nth-child(1)').text.should == "Order"
    find('table.index tbody tr:nth-child(2) td:nth-child(2)').text.should == "cart"
    find('table.index tbody tr:nth-child(2) td:nth-child(3)').text.should == "complete"
  end
end