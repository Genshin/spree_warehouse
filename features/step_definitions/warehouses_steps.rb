Given 'a warehouse "$name" exists' do |name|
  @warehouse = Factory(:warehouse, :name => name, :code => '123456' , :location => 'Japan', :details => 'No Details')
end

When 'I start creating a warehouse' do
  click_link "New Warehouse"
end

When 'I start editing the "$name" warehouse' do |name|
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

When 'I visit the warehouse path' do
  visit spree.admin_warehouse_path(@warehouse)
end

When 'I delete the "$name" warehouse' do |name|
  click_link "Delete"
  click_button "OK"
end

Then 'we should have flash message' do 
  page.should have_content('Warehouse $name has been successfully removed!.')
end

Then 'we should see the "$name" warehouse' do |name|
  page.should have_content(name)
  page.should have_content(@warehouse.code)
  page.should have_content(@warehouse.location)
  page.should have_content(@warehouse.details)
end


Then 'we should have the following warehouse:' do |table|
  attributes = table.rows_hash
  Spree::Warehouse.where(attributes).should have(1).warehouse
end

Then 'we should have $count warehouses' do |count|
  Spree::Warehouse.count.should == count.to_i
end
