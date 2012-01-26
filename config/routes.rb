Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :warehouses
    resources :visual_codes
    resources :visual_code_types
  end
end

