Rails.application.routes.draw do
  root to: 'pages#home'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :questions,  only: [:index]
      resources :dashboards, only: [:index]
    end
  end
end
