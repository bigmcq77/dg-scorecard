Rails.application.routes.draw do
  resources :courses do
    resources :holes
  end

  resources :users do
    resources :rounds do
      resources :scores
    end
  end

  post 'user_token' => 'user_token#create'
end
