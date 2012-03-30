module Spree
  module Admin
    class StockController < ResourceController
      def index 
        @products = Product.all
      end
    end
  end
end
