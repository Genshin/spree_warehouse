require "rqrcode"

module Spree
  module Admin
    UsersController.class_eval do 

      def qr
        user = User.find(params[:id])
        code = { :profile => { :name => user.email, :server => request.host, :port => request.port, :key => user.spree_api_key } }
        @qr = RQRCode::QRCode.new(code.to_json, :size => 12, :level => :l)

        respond_with { |format| format.html }
      end

  	end
  end
end
