require 'spec_helper'

describe "Variants" do
  context "creating a new variant" do
    
    before :each do 
      sign_in_as!(Factory(:admin_user))
      visit spree.admin_path
      
    end
    
    it "should allow an admin to create a new variant" do
      product = Factory(:product_with_option_types, :visual_code => "654321", :price => "1.99", :cost_price => "1.00", :weight => "2.5", :height => "3.0", :width => "1.0", :depth => "1.5")

      product.options.each do |option|
        Factory(:option_value, :option_type => option.option_type)
      end
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      click_link "Variants"
      click_on "New Variant"
      find('input#variant_visual_code').value.should == "654321"
      find('input#variant_price').value.should == "1.99"
      find('input#variant_cost_price').value.should == "1.00"
      find('input#variant_weight').value.should == "2.50"
      find('input#variant_height').value.should == "3.00"
      find('input#variant_width').value.should == "1.00"
      find('input#variant_depth').value.should == "1.50"
    end
    
    pending "should allow an admin to assign visual code thru variant edit view" do
      product = Factory(:product_with_option_types, :price => "2.99", :cost_price => "1.00", :weight => "2.5", :height => "3.0", :width => "1.0", :depth => "1.5")

      product.options.each do |option|
        Factory(:option_value, :option_type => option.option_type)
      end
      variant = Factory(:variant, :product => product )
      click_link "Products"
      within('table.index tr:nth-child(2)') { click_link "Edit" }
      click_link "Variants"
      #puts page.body
      
      click_link " Edit"
      within('table.index tbody tr td:nth-child(9)') { click_link "Edit" }
      fill_in 'input#variant_visual_code' , :with => "123456"
      click_on "Update"
      page.should have_content("successfully updated!")
      find('input#variant_visual_code').value.should == "123456"
    end
  end
end