require 'spec_helper'

describe "Orders Listing" do
  before(:each) do
    Factory(:order, :created_at => Time.now + 1.day, :completed_at => Time.now + 1.day, :number => "R100")
    Factory(:order, :created_at => Time.now - 1.day, :completed_at => Time.now - 1.day, :number => "R200")
    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
  end

  context "listing orders" do
    before(:each) do
      click_link "Orders"
    end

    it "should list existing orders" do
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(3)').text.should == "cart"
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R100"
      find('table#listing_orders tbody tr:nth-child(2) td:nth-child(2)').text.should == "R200"
    end

    it "should be able to sort the orders listing" do
      # default is completed_at desc
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R100"
      find('table#listing_orders tbody tr:nth-child(2) td:nth-child(2)').text.should == "R200"

      click_link "Completed At"

      # completed_at asc
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R200"
      find('table#listing_orders tbody tr:nth-child(2) td:nth-child(2)').text.should == "R100"

      within(:css, 'table#listing_orders thead') { click_link "Order" }

      # number asc
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R100"
      find('table#listing_orders tbody tr:nth-child(2) td:nth-child(2)').text.should == "R200"
    end
  end

  context "searching orders" do
    before(:each) do
      click_link "Orders"
    end

    it "should be able to search orders" do
      fill_in "search_number_like", :with => "R200"
      click_button "Search"
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R200"
    end

    it "should be able to search orders using only completed at input" do
      fill_in "search_created_at_greater_than", :with => Date.today
      click_button "Search"
      find('table#listing_orders tbody tr:nth-child(1) td:nth-child(2)').text.should == "R100"
    end
  end
end