FactoryGirl.define do
  sequence :wh_user_authentication_token do |n|
    "xxxx#{Time.now.to_i}#{rand(1000)}#{n}xxxxxxxxxxxxx"
  end

  factory :wh_user, :class => Spree::User do
    email { Faker::Internet.email }
    login { email }
    password 'secret'
    password_confirmation 'secret'
    authentication_token { FactoryGirl.generate(:wh_user_authentication_token) } if Spree::User.attribute_method? :authentication_token
  end

  factory :wh_admin_user, :parent => :wh_user do
    roles { [Spree::Role.find_by_name('admin') || Factory(:role, :name => 'admin')]}
  end
end