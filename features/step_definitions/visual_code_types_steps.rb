Given /^I am at visual code types sub menu$/ do
  click_link "Visual Codes"
  click_link "Visual Code Types"
end

When /^I visit visual code types listing$/ do
  click_link "Visual Codes"
  click_link "Visual Code Types"
end

When 'I start creating a visual code type' do
  click_link "admin_new_visual_code_type"
end

Then 'we should have $count visual code types' do |count|
  Spree::VisualCodeType.count.should == count.to_i
end

When 'I fill the visual code type form' do 
  fill_in "visual_code_type_name" , :with => "QR"
  click_button "Create"
end

When 'I edit the visual code type' do 
  fill_in "visual_code_type_name" , :with => "123456"
  click_button "Update"
end

Then 'we should see the new visual code type' do 
  within('#visual_code_types') { page.should have_content("QR") }
  within('#visual_code_types') { page.should have_content("BarCode") }
end

Then 'we should see the editted visual code type' do 
  within('#visual_code_types') { page.should have_content("123456") }
end


