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
    get "home/help" => "homes#help"
    get '/search', to: 'searches#search'
    resources :notifications, only: [:index, :update]

    resources :musical_pieces, only: [:index, :show, :new, :create] do
      resources :musical_pieces_comments, only: [:create, :destroy] do
        resource :favorites, only: [:create, :destroy]
      end
    end

    resources :composers, only: [:index, :show] do
      collection do
        get "chronology", to: 'composers#chronology', as: :chronology
      end
    end

    resources :musical_piece_lists, only: [:create, :destroy]
    resources :members, only: [:index, :show, :edit, :update] do
      # フォローフォロワー機能のため追加
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: :followings
      get 'followers' => 'relationships#followers', as: :followers
      collection do
        get "my_page", to: 'members#my_page', as: :my_page
        get "timeline", to: 'members#timeline', as: :timeline
        get "ff_message", to: 'members#ff_message', as: :ff_message
      end
    end

    resources :lists
    # お問い合わせ
    get   'inquiry'         => 'inquiry#index'     # 入力画面
    post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
    post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

    resources :messages, only: [:create]
    resources :rooms, only: [:create, :show]
  end

  # 管理者側のルーティング設定
  namespace :admin do
    root :to => "homes#top"
    resources :musical_pieces, :except => [:show]
    resources :composers, :except => [:show]
    resources :members, :except => [:new, :create, :show]
  end
end
