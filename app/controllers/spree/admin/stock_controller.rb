module Spree
  module Admin
    class StockController < BaseController
      before_filter :load_products, :only => :index
      before_filter :load_variant, :only => [:restocking, :destocking]
      
      respond_to :html
      
      def index 
      
      end
      
      def restocked_items
        @restocked_items = StockRecord.restocked
      end
      
      def restocking
        @container_taxons = ContainerTaxon.all
      end
      
      def restock
        @variant = Variant.find(params[:stock_record][:variant_id])
        
        puts params.to_json
        if @stock_record = StockRecord.create(params[:stock_record])
          flash[:notice] = "#{@variant.name} successfully_restocked"
          respond_with { |format| format.html { redirect_to :admin_stock } }
        end
        
        
      end
      
      
      def destocking
        @reasons = ['destock', 'transfer']
      end
      
      def destock
        @variant = Variant.find(params[:stock_record][:variant_id])
        flash[:notice] = "#{@variant.name} successfully_destocked"
        respond_with { |format| format.html { redirect_to :admin_stock } }
      end
      
      private
      
      def load_products
        @products = Product.all
      end   
      
      def load_variant
        @variant = Variant.find(params[:id])
      end 

    end
  end
end