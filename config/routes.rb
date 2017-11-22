Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions , only: [:create,:destroy]
  resources :registrations , only: [:create,:destroy] do
    collection do
      post :confirmation
      post :password_reset
      post :validate_token
      post :password_reset_form
    end
  end

end
