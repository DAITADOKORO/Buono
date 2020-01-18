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

resources :wants, only:[:index] do
  collection do
    get :tag_cloud
  end
end

resources :repeats, only:[:index] do
  collection do
    get :tag_cloud
  end
end

resources :users, except:[:new, :create, :index] do
  resource :wants, only:[:show]
  resource :repeats, only:[:show]
end

resources :restaurants, only:[:index, :show] do
  resource :wants, only: [:create, :destroy]
  resource :repeats, only: [:create, :destroy]
  resource :rest_comments, only:[:create, :show, :destroy]
  collection do
    get :search
    post :search
    get :tag_cloud
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
