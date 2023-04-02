# frozen_string_literal: true

Rails.application.routes.draw do
  # Define application routes using the DSL in https://guides.rubyonrails.org/routing.html

  # Define routes for users with only show and create actions
  resources :users, only: %i[show create] do
    member do
      get 'followers' # Route for getting followers of a user
      get 'following' # Route for getting users being followed by a user
    end
    resources :sleep_records, only: %i[index create] # Nested route for sleep records of a user
    get 'friends_sleep_records', on: :member # Route for getting sleep records of a user's friends
  end

  # Define routes for creating and destroying relationships
  resources :relationships, only: %i[create destroy]
end
