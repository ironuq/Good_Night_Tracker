# frozen_string_literal: true

# The User model represents an individual user in the application.
# Users can have sleep records and relationships with other users.
class User < ApplicationRecord
  # A user has many sleep records, which will be destroyed if the user is deleted
  has_many :sleep_records, dependent: :destroy

  # A user has many active relationships, representing users they are following
  # If the user is deleted, the active relationships will also be destroyed
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy

  # A user has many passive relationships, representing users who are following them
  # If the user is deleted, the passive relationships will also be destroyed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # A user has many other users they are following, through the active relationships
  has_many :following, through: :active_relationships, source: :followed

  # A user has many followers, through the passive relationships
  has_many :followers, through: :passive_relationships, source: :follower
end
