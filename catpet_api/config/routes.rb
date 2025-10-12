Rails.application.routes.draw do
  post '/signup', to: 'registrations#create'
  post '/login', to: 'sessions#create'

  # exemplo de rota protegida
  get '/profile', to: 'users#profile'
end
