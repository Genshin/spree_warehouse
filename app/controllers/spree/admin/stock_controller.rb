module Spree
  module Admin
    class StockController < BaseController

      before_filter :load_variant, :only => [:restocking, :destocking]
      
      respond_to :html
      
      def search
        index
        render :index
      end
      
      def index 
        @search = Spree::Product.metasearch(params[:search])
        @products = @search.relation.page(params[:page]).per(Spree::Config[:admin_products_per_page])
        respond_with(@products) do |format|
          format.html
        end
      end
      
      def restocked_items
        @restocked_items = StockRecord.restocked
      end
      
      def destocked_items
        @destocked_items = StockRecord.destocked
      end
      
      def restocking
        @container_taxons = ContainerTaxon.all
      end
      
      def restock
        @variant = Variant.find(params[:stock_record][:variant_id])
        unless @variant.container_taxons.exists?(:id => params[:stock_record][:container_taxon_id])
          @variant.container_taxons << ContainerTaxon.find(params[:stock_record][:container_taxon_id])
        else
          variant_ct = @variant.variant_container_taxons.find_by_container_taxon_id(params[:stock_record][:container_taxon_id])
          unless variant_ct.quantity.nil?
            variant_ct.quantity += params[:stock_record][:quantity].to_i 
          else
            variant_ct.quantity = params[:stock_record][:quantity].to_i 
          end 
          variant_ct.save
        end
        @variant.save
      
        if @stock_record = StockRecord.create(params[:stock_record])
          flash[:notice] = "#{@variant.name} successfully_restocked"
          respond_with { |format| format.html { redirect_to :admin_stock } }
        end
      end
      
      def destocking
        @reasons = DestockingReason.all
        @container_taxon_id = params[:container_taxon_id]
      end
      
      def destock
        @variant = Variant.find(params[:stock_record][:variant_id])
        if @variant.container_taxons.exists?(:id => params[:stock_record][:container_taxon_id])
          variant_ct = @variant.variant_container_taxons.find_by_container_taxon_id(params[:stock_record][:container_taxon_id])
          unless variant_ct.quantity.nil?
            variant_ct.quantity = variant_ct.quantity - params[:stock_record][:quantity].to_i 
          else
            variant_ct.quantity = 0 - params[:stock_record][:quantity].to_i 
          end 
          variant_ct.save
        end
        @variant.save

        if @stock_record = StockRecord.create(params[:stock_record])
          flash[:notice] = "#{@variant.name} successfully_destocked"
          respond_with { |format| format.html { redirect_to :admin_stock } }
        end
      end
      
      private 
      
      def load_variant
        @variant = Variant.find(params[:id])
      end 

    end
  end
end