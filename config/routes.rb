SampleApp::Application.routes.draw do
  root "static_pages#home"

  get "/signup"  => "users#new"
  get "/help"    => "static_pages#help"
  get "/about"   => "static_pages#about"
  get "/contact" => "static_pages#contact"
  get "/signin"  => "sessions#new"
  get "/signout"  => "sessions#destroy"

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

end
