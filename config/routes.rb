SparePlan::Application.routes.draw do
  resources :tasks
  resources :projects
  resources :resources

  root :to => 'welcome#index'
end
