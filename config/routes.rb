SparePlan::Application.routes.draw do
  resources :projects do
    resources :tasks, except: [:show, :edit]
  end
  resources :resources

  root :to => 'welcome#index'
end
