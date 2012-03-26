module Spree
  Shipment.class_eval do 
    has_many :packages
    has_one :master_package, :class_name => 'Spree::Package'
    
    accepts_nested_attributes_for :packages
    
    scope :picked, where(:state => 'picked')
    scope :packed, where(:state => 'packed')
    
    StateMachine::Machine.ignore_method_conflicts = true 
    state_machines.clear
    
    state_machine :initial => 'not_picked', :use_transactions => false do
      
      event :picked do 
        transition :from => 'not_picked' , :to => 'picked'
      end 
      
      event :packed do
        transition :from => 'picked', :to => 'packed'
      end
      
      event :pending do
        transition :from => 'packed', :to => 'pending'
      end
      
      event :ready do
        transition :from => 'pending', :to => 'ready'
      end
      
      event :pend do
        transition :from => 'ready', :to => 'pending'
      end
      
      event :ship do
        transition :from => 'ready', :to => 'shipped'
      end

      after_transition :to => 'shipped', :do => :after_ship
    end

        
    def package
      @package ||= self.packages.last
    end
    
    
    
  end
end