Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

mount ActionCable.server => "/cable"
post '/authenticate', to: 'authentications#authenticate'

#users
get 'users/tables', to: 'users#tables'

post '/users/create', to: 'users#create'

patch '/users/edit', to: 'users#edit'

delete '/users/delete' , to: 'users#delete'

get '/users/index' , to: "users#index"

#product
get '/products/index', to: 'products#index'

post '/products/create', to: 'products#create'

patch '/products/edit', to: 'products#edit'

delete '/products/delete' , to: 'products#delete'

#category
get '/categories/index' ,to: 'categories#index'

post '/categories/create', to: 'categories#create'

patch '/categories/edit' , to: 'categories#edit'

delete '/categories/delete' , to: 'categories#delete'

#order

post '/orders/create' , to: 'orders#create_order_with_order_details'

get '/orders/ordering' , to: 'orders#ordering'

get '/orders/order', to: 'orders#order'
#order details

post '/order_details/create' , to: 'order_details#create'

put '/order_details/update' , to: 'order_details#update'

get '/order_details/ordering', to: 'order_details#ordering'

patch '/orders/complete', to: 'orders#complete'

end
