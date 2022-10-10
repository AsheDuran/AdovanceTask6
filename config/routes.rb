Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"#Searchesコントローラーのsearchアクションが実行されるように定義
  #get '/search', to: 'searches#search' でもいける
  #chat機能で追記 get 'chat/:id', to: 'chats#show', as: 'chat' いらんかな
  resources :chats, only: [:show, :create]


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do#userのネストはフォロワー機能
    resource :relationships, only: [:create, :destroy]
    get 'relationships/followings' => 'relationships#followings', as: 'followings'
    get "relationships/followers" => 'relationships#followers', as: 'followers'
  end

  #resources :groups, except: [:destroy]--exceptは省くやつ
  resources :groups, only: [:new, :index, :show, :create, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end