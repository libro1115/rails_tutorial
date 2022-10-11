Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  Rails.application.routes.draw do
    resources :books
  end
  # get "/books",to:"books#index"
  # post "/books",to:"books#create"
  # get "/books/new",to:"books#new",as:"new_book"
  # get "/books/:id/edit",to:"books#edit",as:"edit_book"
  # get "/books/:id",to:"books#show",as:"book"
  # patch "/books/:id",to:"books#update"
  # delete "/books/:id",to:"books#destroy"
end
