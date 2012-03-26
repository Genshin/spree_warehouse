#Spree::Core::Engine.routes.append do
Spree::Core::Engine.routes.draw do
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
    
    resources :orders do
      resources :shipments do
        collection do 
          get :picking_list
        end
 
        member do
          get :create_package
        end
      end   
    end

  end
end

