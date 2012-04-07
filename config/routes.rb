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
    
    resources :inventory_units do
      member do
        put :fire
        get :fire
      end
    end
    
    match '/stock', :to => 'stock#index', :as => :stock
    match '/stock/restocked_items', :to => 'stock#restocked_items', :as => :restocked_items
    match '/stock/destocked_items', :to => 'stock#destocked_items', :as => :destocked_items
    match '/stock/:id/restocking', :to => 'stock#restocking', :as => :restocking
    match '/stock/restock', :to => 'stock#restock' , :as => :restock
    match '/stock/:id/destocking', :to => 'stock#destocking', :as => :destocking
    match '/stock/destock', :to => 'stock#destock' , :as => :destock

    resources :destocking_reasons
    
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

