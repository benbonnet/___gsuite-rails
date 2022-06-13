Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root("application#index")
  match('/auth/google_oauth2/callback', to: 'application#create_session', via: %i[get post])
  match('*path' => 'application#index', via: :get)
end
