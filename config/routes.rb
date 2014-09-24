Blog::Application.routes.draw do

  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: [:get, :post]
  get "/task/new" do
    erb :form
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :admin do
    post :make_admin, on: :new
    post :remove_admin, on: :new
  end


  resources :sessions, only: [:new, :create, :destroy]
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :microposts, only: [:index, :create, :destroy]
  get '/posts_with_button', to: 'microposts#index_with_button', as: 'posts_with_button'

  resources :relationships, only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]

  # devise_for :users
  match '/help', to: 'welcome#help', via: 'get'

  resources :dragons do
    get :feed
    get :walk
    get :puttobed
    get :toss
    get :rock
    get :passageoftime
  end
  resources :synnipaev

  # resources :articles

  resources :articles do
    resources :comments
  end
  # root to: 'pages#home'
  root to: 'welcome#index'
end