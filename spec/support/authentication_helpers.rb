module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/login'
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => 'secret'
    click_button 'Login'
  end

end

RSpec.configure do |c|
  c.include AuthenticationHelpers, :type => :request
end
