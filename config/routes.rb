Rails.application.routes.draw do
  devise_for :users
  # resources :pets
  # get 'home/index'
  root 'home#index'

  resources :pets do
    resources :seen
  end

  namespace 'api' do
    namespace 'v1' do
      resources :pet
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
