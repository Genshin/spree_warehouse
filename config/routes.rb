Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :warehouses
    resources :visual_codes
    resources :visual_code_types
    resources :container_taxonomies do
      member do
        get :get_children
      end

      resources :container_taxons
    end
  end
end

