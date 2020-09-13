Rails.application.routes.draw do

  resources :exhibitions, only: [:new, :create] do
  end


  devise_for :users

  root 'items#index'

  resources :users, only: [:index, :show, :edit, :update] do
  end

  get    'users/:id'   =>  'users#show'
  #devise_for :users, #{
  #   registrations: 'users/registrations',
  #   sessions:      'users/sessions'
  # }
  
  get "exhibitions/confirm"

  devise_scope :users do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :cards, only: [:new, :create] do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end