Rails.application.routes.draw do

  root 'welcome#index'
  get '/' => 'welcome#index'

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
  post '/search/mlb_save' => 'search#event_save'
  post '/search/nfl_save' => 'search#event_save'
  post '/search/mlb_save' => 'search#mlb_save'
  post '/search/nfl_save' => 'search#nfl_save'
  get '/search/music' => 'search#music_search'
  get '/search/music_save' => 'search#music_show'
  post '/search/music_save' => 'search#music_save'
  get '/logout' => 'sessions#destroy'



  get '/search/movies' => 'search#movies'
  get '/search/tv' => 'search#tv'

  post '/events' => 'events#new'
  
  resources :users

  # get ':id' => 'welcome#index'
  
end
