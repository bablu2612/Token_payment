Rails.application.routes.draw do
  resources :bankdetails
  resources :tokens
  get '/paid' , to: 'tokens#paid'
  post '/token/payment' , to: 'tokens#payment'
  get '/edit/bank', to: 'tokens#paid'
  root 'tokens#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
