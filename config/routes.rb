Rails.application.routes.draw do
  resources :clientes
  resources :historicos
  resources :conta
  resources :transferencia
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
