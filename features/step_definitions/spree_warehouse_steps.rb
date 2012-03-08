def sign_in_as!(user)
  visit '/login'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => 'secret'
  click_button 'Login'
end

def current_path
  URI.parse(current_url).path
end

Given 'I am admin' do
  sign_in_as!(Factory(:wh_admin_user))
end

Given 'I am at warehouses menu' do
  visit spree.admin_path
  click_link "Warehouses"
end

Given 'a visual code type exists' do 
  @visual_code_type_barcode = Factory(:visual_code_type, :name => "BarCode")
end

Given 'a barcode exists' do 
  @barcode = Factory(:barcode)
end

When 'I click edit button' do 
  click_link "Edit"
end

Then 'we should not have a "$link" link' do |link|
  page.should_not have_content(link)
end

Then 'we should have a "$link" link' do |link|
  page.should have_content(link)
end

Then 'we should be redirected to "$path"' do |path|
  current_path.should == path
end

