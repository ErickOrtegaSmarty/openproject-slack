OpenProject::Application.routes.draw do
  resources :projects, only: [] do
    resources :slack, only: %i[create new index]
  end

  resources :slack, except: %i[create new index]
end
