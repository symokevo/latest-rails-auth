Rails.application.routes.draw do
  root "pages#home"
  resource :dashboard, only: :show

  resource :registration, only: %i[new create]

  # Login and logout
  resource :session, only: %i[new create]

  get "up" => "rails/health#show", as: :rails_health_check
end
