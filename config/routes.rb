Rails.application.routes.draw do
  namespace :admin do
    get "", to: "dashboard#index", as: "/"
    resources :phones do
      resources :variants, shallow: true
    end
  end
end
