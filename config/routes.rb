Rails.application.routes.draw do
  # gemのdevise導入
  devise_for :member,controllers: {
    sessions: 'members/sessions',
    registrations: 'members/registrations',
    passwords: 'members/passwords'}
  devise_for :admin,controllers: {
      sessions: 'admins/sessions',
      registrations: 'admins/registrations',
      passwords: 'admins/passwords'}

  # resources :musical_pieces,only: [:index,:show]
  # resources :composers,only: [:index,:show]

  scope module: :member do
    root :to => "homes#top"
    get "home/about" => "homes#about"
    resources :musical_pieces,only: [:index,:show,:new,:create]
    resources :musical_pieces_comments, only: [:create, :destroy]
    resources :composers,only: [:index,:show]

    resources :members,only: [:show,:edit,:update] do
      # フォローフォロワー機能のため追加
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :lists do
      collection do
        delete "destroy_all"
      end
    end
  end

  # 管理者側のルーティング設定
  namespace :admin do
    root :to => "homes#top"
    resources :musical_pieces, :except => [:show]
    resources :composers, :except => [:show]
    resources :members, :except => [:new,:create,:destroy]
  end

end
