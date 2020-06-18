Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'issues/:id/events', to: 'events#index'
    end
  end

  post 'webhooks/payload', to: 'webhooks#payload'
end
