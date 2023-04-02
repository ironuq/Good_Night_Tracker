# frozen_string_literal: true

# SleepRecord model represents a sleep record for a user.
# It stores the start and end times of a sleep session and is associated with a user.
class SleepRecord < ApplicationRecord
  # Each sleep record belongs to a user
  belongs_to :user

  # Validate the presence of start_time and end_time attributes
  validates :start_time, presence: true
  validates :end_time, presence: true
end
