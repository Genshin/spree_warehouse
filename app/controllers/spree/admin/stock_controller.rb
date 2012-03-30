module Spree
  module Admin
    class StockController < ResourceController
      def index 
        @products = Product.all
      end
      
      def out
        
      end
    end
  end
end
