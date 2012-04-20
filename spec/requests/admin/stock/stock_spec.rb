require 'spec_helper'

describe "Stock" do
  before(:each) do
    sign_in_as!(Factory(:admin_user))
    visit spree.admin_path
  end

  context "listing stock" do
    it "should list existing stock with correct sorting" do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-06 18:21:13:', :count_on_hand => '0')
      Factory(:product, :name => 'zomg shirt', :available_on => '2125-01-06 18:21:13', :count_on_hand => '5')

      click_link "Stock"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      within('table.index tr:nth-child(3)') { page.should have_content("zomg shirt") }

      #click_link "admin_stock_listing_name_title"
      #save_and_open_page
      #within('table.index tr:nth-child(2)') { page.should have_content("zomg shirt") }
      #within('table.index tr:nth-child(3)') { page.should have_content("apache baseball cap") }
    end
  end

  context "searching stock" do
    it "should be able to search stock by product name, sku and container taxon " do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-01 01:01:01', :sku => "A100")
      Factory(:product, :name => 'apache baseball cap2', :available_on => '2011-01-01 01:01:01', :sku => "B100")
      @product = Factory(:product, :name => 'zomg shirt', :available_on => '2011-01-01 01:01:01', :sku => "Z100")
      #@ct = Factory(:container_taxon, :name => 'A#1')
      #Factory(:stock_record, :variant => @product.master, :container_taxon => @ct)

      Spree::Product.update_all :count_on_hand => 10

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
    it "should allow to restock a product" , :js => true do
      Factory(:product, :name => 'apache baseball cap', :available_on => '2011-01-06 18:21:13:', :count_on_hand => '0')
      Factory(:product, :name => 'zomg shirt', :available_on => '2125-01-06 18:21:13', :count_on_hand => '5')
      Factory(:container_taxon, :name => 'A#1')

      click_link "Stock"
      within('table.index tr:nth-child(2)') { page.should have_content("apache baseball cap") }
      sleep 2 
      within('table.index tr:nth-child(2)') { click_link "Restock" }
      within('table.index tr:nth-child(2)') { click_link "Restock" }
      puts page.find("table.index:last-child").text
      wait_until { page.find("#restocking_fieldset") }

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