Rails.application.routes.draw do
  post '/signup', to: 'registrations#create'
  post '/login', to: 'sessions#create'
  resources :users do
    resources :pets, only: [:index, :create]
  end
  resources :users do
    resources :alimentacoes
    resources :registros
    resources :consultas
  end
  # exemplo de rota protegida
  get '/profile', to: 'users#profile'
end
