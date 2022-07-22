Rails.application.routes.draw do
  resources :memo_files
  resources :memos
  resources :color_files
  resources :users

  # ファイルを指定してその中にあるメモを返す
  get 'files/:id', to: 'memos#show_inFile'

  # タグ検索
  get 'search', to: 'memos#search'
end
