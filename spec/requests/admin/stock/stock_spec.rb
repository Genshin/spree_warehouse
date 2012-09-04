require 'spec_helper'

describe "Stock" do
  before(:each) do
    product1 = Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
    product2 = Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
    product3 = Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "A100")

    c_taxonomy = Factory(:container_taxonomy, :name => 'Rack#1') 
    ct_shelve = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Shelve#1') 
    ct_container = Factory(:container_taxon, :container_taxonomy => c_taxonomy, :name => 'Container#1', :parent_id => ct_shelve) 

    Factory(:stock_record, :variant => product1.master, :container_taxon => ct_shelve, :quantity => 5, :direction => 'in')
    Factory(:stock_record, :variant => product2.master, :container_taxon => ct_container, :quantity => 10, :direction => 'in')

    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
  end

  context "listing stock" do
    pending "should list existing stock with correct sorting" do
      click_link "Stock"
     
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }

      #click_link "admin_stock_listing_name_title"
     
      #within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      #within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
    end
  end

  context "searching stock" do
    pending "should be able to search stock by product name, sku and container taxon " do
      click_link "Stock"

      fill_in "search_name_contains", :with => "ap"
      click_button "Search"

      page.should have_content("apache baseball cap")
      page.should have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")

      fill_in "search_variants_including_master_sku_contains", :with => "A1"
      click_button "Search"
      page.should have_content("apache baseball cap")
      page.should_not have_content("apache baseball cap2")
      page.should_not have_content("zomg shirt")
    end
  end 

  context "restocking" do
    pending "should allow to restock a product" , :js => true do
      click_link "Stock"
      click_link "New Stock"
      click_link "New Stock"

      #within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      #sleep 2 
      #within('table.index tr:nth-child(2)') { click_link "Restock" }
      #within('table.index tr:nth-child(2)') { click_link "Restock" }
      #puts page.find("table.index:last-child").text
      wait_until { page.find("#new_stock_fieldset") }

      #wait_until { page.find("#stock_record_quantity").visible? }
      #wait_until { page.evaluate_script("jQuery.active === 0") }
      #wait_until { page.evaluate_script("$body.addEventListener('DOMNodeInserted', function(){ console.log('new node');}, false);")
      #wait_until(10) { page.has_content?("Quantity") } 
      #wait_until { page.find('html')[:class].include?('ui-loading') }
      within('table.index tr:nth-child(2)') { fill_in "stock_record_quantity", :with => 99 }

      select 'A#1', :from => 'stock_record_container_taxon_id'
      click_button "Restock"

    end
  end
end