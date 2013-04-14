SparePlan::Application.routes.draw do
  resources :projects do
    resources :tasks
  end
  resources :resources

  root :to => 'welcome#index'
end
