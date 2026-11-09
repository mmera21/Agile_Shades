Rails.application.routes.draw do
  # RUBRIC 2.2 — every link in the menu points to one of these routes
  root "home#index"

  # RUBRIC 2.1 — About page
  get "about", to: "pages#about", as: :about

  # RUBRIC 3.1 / 3.2 / 4.1 / 4.2 — products index (list + search) and show pages
  resources :products, only: %i[index show]

  # RUBRIC 3.4 — hierarchical navigation (association "show" pages)
  resources :brands,     only: %i[index show]
  resources :categories, only: %i[index show]
  resources :tags,       only: %i[index show]
  resources :colors,     only: %i[show]

  get "up" => "rails/health#show", as: :rails_health_check
end
