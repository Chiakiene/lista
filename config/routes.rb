Rails.application.routes.draw do

  devise_for :users, path: ""
  devise_for :views
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'posts#index'
  resources :posts, path: ""

  resources :posts do
    member do
      put 'switch'
    end
  end

end
