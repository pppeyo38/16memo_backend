Rails.application.routes.draw do
  resources :users
  resources :memo_files
  resources :memos
  resources :color_files

  # サインアップ
  post 'signup', to: 'auth#signup'

  # ログイン
  get 'login', to: 'auth#login'

  # ユーザー情報
  get 'account', to: 'users#account'

  # タグ検索
  get 'search', to: 'memos#search'
end
