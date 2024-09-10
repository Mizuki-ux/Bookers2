Rails.application.routes.draw do
  devise_for :users
  post 'books' => 'books#create'
  get "/home/about" => "homes#about", as: "about"
  root to: "homes#top"
  resources :books, only: [:new, :create, :index, :show, :destroy, :update, :edit] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
