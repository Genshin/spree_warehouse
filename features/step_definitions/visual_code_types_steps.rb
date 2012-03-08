When 'I visit visual code types listing' do
  click_link "Visual Code Types"
end

When 'I start creating a visual code type' do
  click_link "admin_new_visual_code_type"
end

When 'I fill the visual code type form' do 
  fill_in "visual_code_type_name" , :with => "QR"
  click_button "Create"
end

When 'I edit the visual code type' do 
  fill_in "visual_code_type_name" , :with => "123456"
  click_button "Update"
end

When 'I enter the edit url for barcode manually' do
  barcode = Spree::VisualCodeType.barcode
  visit spree.edit_admin_visual_code_type_path(barcode.id)
end


Then 'we should have $count visual code types' do |count|
  Spree::VisualCodeType.count.should == count.to_i
end

Then 'we should see the new visual code type' do 
  within('#visual_code_types') { page.should have_content("QR") }
end

Then 'we should see the editted visual code type' do 
  within('#visual_code_types') { page.should have_content("123456") }
end

Then 'we should have a message saying it is forbidden' do 
  page.should have_content 'Cannot edit system visual code type!'
end


