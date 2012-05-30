module Spree
  module Api
    module V1
      VariantsController.class_eval do
      	def search
          @variants = Variant.search(params[:q]).result.page(params[:page])
        end
      end
    end
  end
end