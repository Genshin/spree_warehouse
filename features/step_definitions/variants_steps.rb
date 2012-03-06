Given 'a product and variant exist' do 
  product = Factory(:product_with_option_types, :price => "1.99", :cost_price => "1.00", :weight => "2.5", :height => "3.0", :width => "1.0", :depth => "1.5")
  product.options.each do |option|
    Factory(:option_value, :option_type => option.option_type)
  end
  variant = Factory(:variant, :product => product )
end


Given 'I am at products edit view' do 
  visit spree.admin_path
  click_link "Products"
  within('table.index tr:nth-child(2)') { click_link "Edit" }
end

When 'I click variants button' do 
  click_link "Variants"
end


When 'I start creating a variant' do
  click_on "New Variant"
  #puts page.body
end

Then 'we should have $count variants' do |count|
  Spree::Variant.count.should == count.to_i
end

When 'I fill the variant form' do 
  sleep 1
  puts page.body

find('input#variant_price').value.should == "1.99"
  find('input#variant_cost_price').value.should == "1.00"
  find('input#variant_weight').value.should == "2.50"
  find('input#variant_height').value.should == "3.00"
  find('input#variant_width').value.should == "1.00"
  find('input#variant_depth').value.should == "1.50"
  fill_in "variant_visual_code_attributes_code" , :with => "123456"
  click_button "Create"
end

Then 'we should see the new variant'  do 

end
