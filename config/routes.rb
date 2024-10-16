Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  root "pages#home"
  resource :dashboard, only: :show

  resource :registration, only: %i[new create]

  # Login and logout
  resource :session, only: %i[new create destroy]
  resource :password_reset, only: %i[new create edit update]

  get "up" => "rails/health#show", as: :rails_health_check
end
