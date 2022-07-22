Rails.application.routes.draw do
  resources :memo_files
  resources :memos
  resources :color_files
  resources :users

  # タグ検索
  get 'search', to: 'memos#search'
end
