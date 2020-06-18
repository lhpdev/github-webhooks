Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000', '127.0.0.1:3000'
    resource '/issues/*', headers: :any, methods: [:get]
    resource '/api/v1/*',
      headers: :any,
      methods: :get
  end
end