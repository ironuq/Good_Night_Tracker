# frozen_string_literal: true

Rails.application.routes.draw do
  # Define routes for User resources
  resources :users, only: %i[show create] do
    # Define member routes for User resources
    member do
      # Route for getting a list of a user's followers
      get 'followers'

      # Route for getting a list of users being followed by a user
      get 'following'

      # Route for getting sleep records of a user's friends (mutual followers)
      get 'friends_sleep_records'
    end

    # Nested routes for SleepRecord resources under User resources
    resources :sleep_records, only: %i[index create]
  end

  # Define routes for creating and destroying Relationship resources
  resources :relationships, only: %i[create destroy]
end
