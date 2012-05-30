module Spree
  module Api
    module V1
      BaseController.class_eval do
        append_view_path File.expand_path("../../../app/views", File.dirname(__FILE__))
      end
    end 
  end
end
