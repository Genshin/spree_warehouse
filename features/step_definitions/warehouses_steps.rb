def sign_in_as!(user)
  visit '/login'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => 'secret'
  click_button 'Login'
end


Given 'a warehouse "$name" exists' do |name|
  @warehouse = Factory(:warehouse, :name => name)
end

Given 'I am admin' do
  sign_in_as!(Factory(:admin_user))
end

When 'I start creating a warehouse' do
  visit spree.admin_path
  click_link  "Warehouses"
  click_link "New Warehouse"
end

When 'I start editing the "$name" warehouse' do |name|
  visit spree.admin_warehouses_path
  click_link "Edit '#{name}' warehouse"
end

When 'I submit the following warehouse:' do |table|
  attributes = table.rows_hash
  attributes.each do |field_name, value|
    fill_in field_name, :with => value
  end

  click_button 'Create'
end

When 'I visit warehouses listing' do
  visit spree.admin_warehouses_path
end



When 'I delete the "$name" warehouse' do |name|
  visit spree.admin_warehouses_path
  click_link "Delete"

  page.should have_content('Warehouse was successfully deleted.')
end


Then 'we should have the following warehouse:' do |table|
  attributes = table.rows_hash
  Spree::Warehouse.where(attributes).should have(1).warehouse
end


Then 'we should have $count warehouses' do |count|
  Spree::Warehouse.count.should == count.to_i
end
