Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users
  resources :groups, except: :show
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
