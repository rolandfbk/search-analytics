Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'analytics#new'

  resources :analytics, only: [:index, :new, :create] do
    collection do
      get 'user_search'
    end
  end

end
