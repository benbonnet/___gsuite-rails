Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root("application#index")
  get('/auth/google_oauth2/callback', to: 'application#create_session')
  match('*path' => 'application#index', via: :get)
end
