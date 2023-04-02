# frozen_string_literal: true

# Relationship model represents the follower-followed relationship between users.
# It stores the follower and followed user IDs and ensures their presence.
class Relationship < ApplicationRecord
  # Each relationship has a follower (User) and a followed (User)
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # Validate the presence of follower_id and followed_id attributes
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
