Rails.application.routes.draw do
  root :to => "problems#index"
  resources :problems
  #get 'problem/new'

  get 'welcome/index'

  puts 'LOADING ROUTES'
  mount DceLti::Engine => '/lti'
  # scope '/lti' do
  #   resources :sessions, only: [:create] do
  #     collection do
  #       get :invalid
  #     end
  #   end
  #
  #   resources :configs, only: [:index]
  # end

  post 'submission', to: 'problems#submit_grade'

  # Public Redirects
  get 'snap', to: 'welcome#snap'
end
