Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#dashboard"
  post "zepto_callback", to: "zepto#callback"
end
