Rails.application.routes.draw do
  get "compare/index"
  get "compare/add"
  get "compare/remove"
  get "compare/clear"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
  
  # 브랜드 및 모델 라우트
  resources :brands, only: [:index, :show]
  resources :models, only: [:index, :show]
  
  # 비교 기능 라우트
  get 'compare', to: 'compare#index'
  post 'compare/add/:id', to: 'compare#add', as: :add_to_compare
  delete 'compare/remove/:id', to: 'compare#remove', as: :remove_from_compare
  delete 'compare/clear', to: 'compare#clear', as: :clear_compare
end
