def sign_in_as!(user)
  visit '/login'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => 'secret'
  click_button 'Login'
end

Given 'I am admin' do
  sign_in_as!(Factory(:admin_user))
end

Given 'I am at warehouses menu' do
  visit spree.admin_path
  click_link  "Warehouses"
end