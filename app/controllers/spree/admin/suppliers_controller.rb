module Spree
  module Admin
    class SuppliersController < ResourceController
      
      before_filter :load_data

      def index
        respond_with(@collection) do |format|
          format.html
        end
      end

      protected

        def location_after_save
          admin_suppliers_url
        end

        def collection
          super.order(:name)
        end

        def load_data
          @suppliers = Supplier.order(:name)
        end

    end
  end
end