Rails.application.routes.draw do
  root "pages#home"
  resource :dashboard, only: :show
end
