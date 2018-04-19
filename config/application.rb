require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module Minibox
  class Application < Rails::Application
  end
end

module Api
  class Application < Rails::Application
    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: [:get,
            :post, :put, :delete, :options]
      end
    end
    config.active_record.raise_in_transactional_callbacks = true
  end
end
