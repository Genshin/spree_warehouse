Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :warehouses
    resources :visual_codes
    resources :visual_code_types
    resources :container_taxonomies
  end
end

