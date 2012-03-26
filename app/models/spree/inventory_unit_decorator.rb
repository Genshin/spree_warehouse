module Spree
  InventoryUnit.class_eval do
    
    belongs_to :package
    has_many :state_changes, :as => :stateful
    
    scope :picked, where(:state => 'picked')
    
    StateMachine::Machine.ignore_method_conflicts = true 
    state_machines.clear
    
    state_machine :initial => 'on_hand' do
      event :fill_backorder do
        transition :to => 'sold', :from => 'backordered'
      end
      event :ship do
        transition :to => 'shipped', :if => :allow_ship?
      end
      event :return do
        transition :to => 'returned', :from => 'shipped'
      end
      event :pick do
        transition :to => 'picked', :from => 'sold'
      end

      after_transition :on => :fill_backorder, :do => :update_order
      after_transition :to => 'returned', :do => :restock_variant
      after_transition :to => 'picked', :do => :after_picked
    end
    
    def after_picked
      update_shipment_state
    end
    
    def update_shipment_state
      if shipment.inventory_units.count == shipment.inventory_units.picked.count
        self.shipment.update_attribute_without_callbacks('state', 'picked')
      end

     # self.shipment.update_attribute_without_callbacks('state', @shipment_state)
      
     # self.state_changes.create({
     #     :previous_state => 'not_picked',
     #     :next_state     => @shipment_state,
     #     :name           => 'shipment',
     #     :user_id        => (User.respond_to?(:current) && User.current && User.current.id) || self.user_id
     # })
    end
    
    def not_packed?
      return true unless self.state == 'packed'
    end
   
  end
end