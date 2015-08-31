Rails.application.routes.draw do

  root 'welcome#index'

  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/sessions' => 'sessions#destroy'
  get '/search/nfl' => 'search#nfl'
  post '/search/nfl' => 'search#nfl_search'
  get '/search/mlb' => 'search#mlb'
  post '/search/mlb' => 'search#mlb_search'

  resources :users
  
end
