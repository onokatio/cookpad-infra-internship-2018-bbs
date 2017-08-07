Rails.application.routes.draw do
  get 'hello/fast'

  get 'hello/slow'

  get 'hello/heavy'

  resources :topics, only: [:show, :new, :create] do
    resources :comments, only: [:new, :create]
  end
  resources :users, only: [:new, :create] do
    collection do
      post 'login'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'topics#index'
end
