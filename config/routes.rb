SpreeWarehouse::Engine.routes.draw do
  namespace :admin do
    resources :warehouses
  end
end

Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :warehouses
  end
end
