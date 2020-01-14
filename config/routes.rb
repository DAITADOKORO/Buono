Rails.application.routes.draw do


  root 'restaurants#index'

namespace :admin do
  root 'users#index'
  resources :restaurants
  resources :users, except: [:new, :create] do
    member do
      patch 'user_restore'
    end
  end
  resources :admins
  resources :genres, only: [:index, :create, :update, :destroy] do
    member do
      patch 'genre_restore'
    end
  end
end


devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}



devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

resources :users, except:[:new, :create, :index]

resources :restaurants, only:[:index, :show] do
  resource :wants, only: [:create, :index, :show, :destroy]
  resource :repeats, only: [:create, :index,:show,:destroy]
  resource :rest_comments, only:[:create, :show, :destroy]
  collection do
    post :search
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
