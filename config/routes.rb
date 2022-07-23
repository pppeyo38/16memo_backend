Rails.application.routes.draw do
  resources :users
  resources :memo_files
  resources :memos
  resources :color_files

  # タグ検索
  get 'search', to: 'memos#search'
end
