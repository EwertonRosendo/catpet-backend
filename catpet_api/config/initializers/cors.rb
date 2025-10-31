Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # ⚠️ Allow all origins (use only for development!)
    origins '*'

    resource '*',
      headers: :any,
      expose: ['Authorization'], # so frontend can read JWT tokens
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
