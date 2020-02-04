Rails.application.routes.draw do

  resources :areas, only: [:index]

  post "areas/location", to: "areas#inside"
end
