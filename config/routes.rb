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
  put 'settings_account', to: 'users#settings_account'
  # firebase console上のアカウント取得
  put 'settings_authAccount', to: 'users#settings_authAccount'
  delete 'delete_account', to: 'users#delete_account'

  # タグ検索
  get 'search', to: 'memos#search'
end
