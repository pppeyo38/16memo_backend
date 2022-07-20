Rails.application.routes.draw do
  resources :memo_files
  resources :memos
  resources :color_files
  resources :users

  get 'files/:id', to: 'memos#show_inFile'
end
