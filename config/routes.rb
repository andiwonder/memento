Rails.application.routes.draw do

  root 'welcome#index'

  get '/sessions/new' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/sessions' => 'sessions#destroy'
  get '/search/nfl' => 'search#nfl'
  post '/search/nfl' => 'search#nfl_search'
  get '/search/mlb' => 'search#mlb'
  post '/search/mlb' => 'search#mlb_search'
  get '/search/mlb/:id' => 'search#mlb_show'
  get '/search/nfl/:id' => 'search#nfl_show'
  get '/search/game' => 'search#game'
  get '/search/gameresults' => 'search#game_search'
  post '/search/gameresults' => 'search#game_add'
  post '/search/mlb_save' => 'search#mlb_save'
  resources :users
  
end
