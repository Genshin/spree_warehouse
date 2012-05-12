module Spree
  module Api
    module V1
      class StockController < Spree::Api::V1::BaseController

        def index
          @stock_records = StockRecord.all
        end

        def show
          @stock_records = StockRecord.all
        end

      end
    end
  end
end