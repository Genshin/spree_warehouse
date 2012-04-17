module Spree
  module Admin
    module StockHelper
      def odd_or_even?(id)
        id % 2 == 0 ? "odd" : "even"
      end
    end
  end
end
