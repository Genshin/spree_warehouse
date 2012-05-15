module Spree
  module Admin
    class StockController < BaseController

      before_filter :load_variant, :only => [:restocking, :destocking]
      
      respond_to :html
      
      def new
        @container_taxons = ContainerTaxon.all
      end

      def products
        if params[:term]
          like= "%".concat(params[:term].concat("%"))
          products = Product.where("name like ?", like).includes([:variants])
        else
          products = Product.all
        end
        list = products.map do |p| 
          Hash[ 
            :id => p.id, 
            :label => p.name,
            :name => p.name,
            :variants => p.variants_including_master.map do |v| 
              { :id => v.id, :sku => v.sku } 
            end
          ] 
        end
        render :json => list
      end
      
      def index 
        @search = Product.search(params[:q])
        @products = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
        respond_with(@products) do |format|
          format.html
        end
      end
      
      def restocked_items
        params[:q] ||= {} 
        params[:q][:s] ||= "created_at.desc"
        @search = StockRecord.restocked.search(params[:q])
        @restocked_items = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
      
      def destocked_items
        params[:q] ||= {} 
        params[:q][:s] ||= "created_at.desc"
        @search = StockRecord.destocked.search(params[:q])
        @destocked_items = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
      
      def restocking
        @container_taxons = ContainerTaxon.all
        @container_taxon_id = params[:container_taxon_id].nil? ? 'nil' : params[:container_taxon_id]
      end
      
      def restock
        @variant = Variant.find(params[:stock_record][:variant_id])
        unless @variant.container_taxons.exists?(:id => params[:stock_record][:container_taxon_id])
          #TODO Clean this ugly check 
          if ContainerTaxon.exists?(params[:stock_record][:container_taxon_id])
            ct = ContainerTaxon.find(params[:stock_record][:container_taxon_id])
            @variant.variant_container_taxons.create(:container_taxon_id => ct.id, :quantity => params[:stock_record][:quantity])
          else
            @variant.variant_container_taxons.create(:quantity => params[:stock_record][:quantity])
          end

        else
          variant_ct = @variant.variant_container_taxons.find_by_container_taxon_id(params[:stock_record][:container_taxon_id])
          unless variant_ct.quantity.nil?
            if variant_ct.quantity == 0  
              variant_ct.activate  #will show
            end
            variant_ct.quantity += params[:stock_record][:quantity].to_i 
          else
            variant_ct.quantity = params[:stock_record][:quantity].to_i 
            variant_ct.activate  #will show
          end 
          
          variant_ct.save
        end
        @variant.save
      
        if @stock_record = StockRecord.create(params[:stock_record])
          flash[:notice] = "#{@variant.name} #{ t(:successfully_restocked) }"
          respond_with { |format| format.html { redirect_to :admin_stock } }
        end
      end
      
      def destocking
        @reasons = DestockingReason.all
        @container_taxon_id = params[:container_taxon_id].nil? ? 'nil' : params[:container_taxon_id]
      end
      
      def destock
        @variant = Variant.find(params[:stock_record][:variant_id])
        if @variant.container_taxons.exists?(:id => params[:stock_record][:container_taxon_id])
          variant_ct = @variant.variant_container_taxons.find_by_container_taxon_id(params[:stock_record][:container_taxon_id])
          unless variant_ct.quantity.nil?
            variant_ct.quantity = variant_ct.quantity - params[:stock_record][:quantity].to_i 
            if variant_ct.quantity == 0
              variant_ct.deactivate # won't show
            end
          else
            #TODO Do we need negative values? 
            variant_ct.quantity = 0 - params[:stock_record][:quantity].to_i 
            variant_ct.deactivate # won't show
          end 
          variant_ct.save
        end
        @variant.save

        if @stock_record = StockRecord.create(params[:stock_record])
          flash[:notice] = "#{@variant.name} #{t(:successfully_destocked) }"
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