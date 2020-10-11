Rails.application.routes.draw do

  resources :exhibitions do
    collection do
      get 'categories/get_category_children', to: 'exhibitions#get_category_children', defaults: { format: 'json' }
      get 'categories/get_category_grandchildren', to: 'exhibitions#get_category_grandchildren', defaults: { format: 'json' }
    end

    member do
      post 'pay'=>   'exhibitions#pay', as: 'pay'
    end

    resources :purchases, only: [:index] do
    end

  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get "users/sign_in" => "users/sessions#new"
    get "users/sign_out" => "users/sessions#destroy"
    get 'users/purchase' => 'users/registrations#new_purchase'
    post 'users/purchase' => 'users/registrations#create_purchase'
  end

  root 'items#index'

  resources :users, only: [:index, :show, :edit, :update] do
  end

  get    'users/:id'   =>  'users#show'
  #devise_for :users, #{
  #   registrations: 'users/registrations',
  #   sessions:      'users/sessions'
  # }
  resources :categories, only: [:index] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end



  resources :cards, except: [:index, :edit, :update] do
  end

end