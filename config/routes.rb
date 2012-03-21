Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :warehouses
    resources :visual_codes
    resources :visual_code_types
    
    resources :container_taxonomies do
      resources :container_taxons
      member do
        get :get_children
      end
    end
    
    resources :shipments do
      member do
        get :create_package
      end
    end
  end
end

