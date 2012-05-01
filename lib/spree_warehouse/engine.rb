module SpreeWarehouse
  class Engine < Rails::Engine
    engine_name 'spree_warehouse'

    config.after_initialize do
      require 'rainbow'
      Sickill::Rainbow.enabled = true
    end

    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
