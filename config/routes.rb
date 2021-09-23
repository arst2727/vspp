Rails.application.routes.draw do
  # gemのdevise導入
  devise_for :member, controllers: {
    sessions: 'members/sessions',
    registrations: 'members/registrations',
    passwords: 'members/passwords',
  }
  devise_for :admin, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
  }

  scope module: :member do
    root :to => "homes#top"
    get "home/about" => "homes#about"
    get '/search', to: 'searches#search'

    resources :musical_pieces, only: [:index, :show, :new, :create] do
      resources :musical_pieces_comments, only: [:create, :destroy]
    end
    resources :composers, only: [:index, :show] do
      collection do
        get "chronology", to: 'composers#chronology', as: :chronology
      end
    end

    resources :musical_piece_lists, only: [:create, :destroy]
    resources :members, only: [:show, :edit, :update] do
      # フォローフォロワー機能のため追加
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: :followings
      get 'followers' => 'relationships#followers', as: :followers
      collection do
        get "my_page", to: 'members#my_page', as: :my_page
        get "timeline", to: 'members#timeline', as: :timeline
      end
    end

    resources :lists
  end

  # 管理者側のルーティング設定
  namespace :admin do
    root :to => "homes#top"
    resources :musical_pieces, :except => [:show]
    resources :composers, :except => [:show]
    resources :members, :except => [:new, :create, :destroy]
  end
end
