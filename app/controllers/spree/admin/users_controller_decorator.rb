require "rqrcode"

module Spree
  module Admin
    UsersController.class_eval do 

      def qr
        user = User.find(params[:id])
        code = { :profile => { :name => user.email, :server => request.host, :port => request.port, :key => user.api_key } }
        @qr = RQRCode::QRCode.new(code.to_json, :size => 8, :level => :m)

        respond_with { |format| format.html }
      end

  	end
  end
end
