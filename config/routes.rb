Rails.application.routes.draw do
  resources :problems
  #get 'problem/new'

  get 'welcome/index'

end
