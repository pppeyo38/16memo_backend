Rails.application.routes.draw do
  resources :users
  resources :memo_files
  resources :memos
  resources :color_files

  # サインアップ
  get 'signup', to: 'auth#signup'

  # タグ検索
  get 'search', to: 'memos#search'
end
