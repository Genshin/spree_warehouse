module Spree
  class WarehouseAbilityDecorator
    include CanCan::Ability 
  
    def initialize(user) 
      #can :read, Order do |order, token|
      #  order.completed? 
      #end
      #can :update, Order do |order, token|
      # order.user == user || order.token && token == order.token
      #end
      #can :read,   Wholesaler do |resource|
      #  resource.user == user
      #end    
    end
  end
  Ability.register_ability(WarehouseAbilityDecorator)
end