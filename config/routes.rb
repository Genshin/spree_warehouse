=begin
SpreeWarehouse::Engine.routes.draw do
  mount Spree::Core::Engine, :at => '/'
  namespace :admin do 
    resources :warehouses
  end
end

Rails.application.routes.draw do
  namespace :admin do
    resources :warehouses
  end
end

=end

Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :warehouses
  end
end

