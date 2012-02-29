Given 'a visual code type exists' do 
  @visual_code_type_barcode = Factory(:visual_code_type, :name => "BarCode")
end

Given 'a visual code exists' do 
  @visual_code = Factory(:visual_code, :code => "654321" , :visual_code_type => @visual_code_type_barcode)
end

Given /^I am at visual codes sub menu$/ do
  visit spree.admin_visual_codes_path
end

When /^I visit visual code listing$/ do
  click_link "Visual Codes"
end

When 'I start creating a visual code' do
  click_link "admin_new_visual_code"
end

When 'I click edit' do 
 click_link "Edit"
end


Then 'we should have $count visual codes' do |count|
  Spree::VisualCode.count.should == count.to_i
end

When 'I fill the visual code form' do 
  fill_in "visual_code_code" , :with => "123456"
  select "BarCode", :from => "visual_code_visual_code_type_id"
  click_button "Create"
end

When 'I edit the visual code' do 
  fill_in "visual_code_code" , :with => "123456"
  click_button "Update"
end

Then 'we should see the new visual code' do 
  within('#visual_codes') { page.should have_content("123456") }
  within('#visual_codes') { page.should have_content("BarCode") }
end

Then 'we should see the editted visual code' do 
  within('#visual_codes') { page.should have_content("123456") }
end




