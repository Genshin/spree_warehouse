Spree::Core::Engine.routes.prepend do

  #API
  namespace :api do
    scope :module => :v1 do
      
      resources :warehouses

      resources :stock 

      resources :container_taxonomies do
        collection do
          get :search 
        end
        
        resources :container_taxons do
          collection do
            get :search
          end
        end
      end

      resources :products do
        collection do
          get :search
        end

        resources :variants do 
          collection do
            get :search
          end
        end
      end

    end
  end
  
  #CORE
  namespace :admin do
    resources :warehouses
    resources :visual_codes
    resources :visual_code_types
    
    resources :container_taxonomies do
      resources :container_taxons do 
        member do
          get :qr_pdf 
        end
        collection do 
          get :qrs_pdf
        end
      end

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

    match '/stock/:id/reassigning', :to => 'stock#reassigning', :as => :reassigning
    match '/stock/reassign', :to => 'stock#reassign' , :as => :reassign

    match '/stock/new', :to => 'stock#new', :as => :new_stock
    match '/stock/create', :to => 'stock#create', :as => :create_stock

    match '/stock/products', :to => 'stock#products', :as => :products_stock

    resources :users do 
      member do 
        get :qr
      end
    end

    resources :suppliers

    resources :destocking_reasons
    
    resources :orders do
      resources :shipments do
        collection do 
          get :picking_list
          get :picking_pdf
        end
 
        member do
          get :create_package
        end
      end   
    end

  end
end