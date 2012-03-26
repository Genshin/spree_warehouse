module Spree
  InventoryUnit.class_eval do
    belongs_to :package
    
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
    end
    
    
  end
end