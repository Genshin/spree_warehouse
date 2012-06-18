module Spree
  module Api
    module V1
      class StockController < Spree::Api::V1::BaseController

        def index
          @stock_records = StockRecord.all
        end

        def show
          @stock_record = StockRecord.find(params[:id])
        end

        def new
        end

        def create
          authorize! :create, StockRecord

          if params[:container_taxon]
            ct = ContainerTaxon.find_by_permalink(params[:container_taxon][:permalink])
            params[:stock_record][:container_taxon_id] = ct.id
          end
          
          @stock_record = StockRecord.new(params[:stock_record])
          if @stock_record.save
            render :show, :status => 201
          else
            invalid_resource!(@stock_record)
          end
        end

      end
    end
  end
end