# frozen_string_literal: true

# SleepRecord model represents a sleep record for a user.
# It stores the start and end times of a sleep session and is associated with a user.
class SleepRecord < ApplicationRecord
  # Each sleep record belongs to a user
  belongs_to :user

  # Validate the presence of start_time and end_time attributes
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :start_time_must_be_before_end_time

  private

  # Custom validation for checking if start_time is before end_time
  def start_time_must_be_before_end_time
    errors.add(:start_time, 'start_time must be before end_time') if start_time >= end_time
  end
end
