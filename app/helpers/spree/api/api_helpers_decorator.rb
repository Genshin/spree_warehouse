module Spree
  module Api
    ApiHelpers.module_eval do

      def product_attributes
        [:id, :name, :visual_code, :description, :price,
         :available_on, :permalink, :count_on_hand, :meta_description, :meta_keywords]
      end

      def variant_attributes
        [:id, :name, :count_on_hand, :visual_code, :sku, :price, :weight, :height, :width, :depth, :is_master, :cost_price, :permalink]
      end

      def stock_attributes
        [:id, :quantity]
      end

    end
  end
end