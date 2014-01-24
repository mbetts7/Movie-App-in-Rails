Movies::Application.routes.draw do

  resources :movies
 
  root 'movies#index'

  get '/movies/search_results' => 'movies#search_results', as: :search_results

#          Prefix Verb   URI Pattern                      Controller#Action
#         movies GET    /movies(.:format)                movies#index
#                POST   /movies(.:format)                movies#create
#      new_movie GET    /movies/new(.:format)            movies#new
#     edit_movie GET    /movies/:id/edit(.:format)       movies#edit
#          movie GET    /movies/:id(.:format)            movies#show
#                PATCH  /movies/:id(.:format)            movies#update
#                PUT    /movies/:id(.:format)            movies#update
#                DELETE /movies/:id(.:format)            movies#destroy
#           root GET    /                                movies#index
# search_results GET    /movies/search_results(.:format) movies#search_results
 
end
