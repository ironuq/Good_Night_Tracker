# frozen_string_literal: true

#-------------------------
# todo:validation for sleeping records(ex:start_time being later than end_time)
# todo:error handling for when ask for index on non-existing user
#-------------------------

# SleepRecordsController handles the creation and listing of sleep records for a specific user.
class SleepRecordsController < ApplicationController
  before_action :set_user

  # Create a new sleep record for the given user
  def create
    sleep_record = @user.sleep_records.build(sleep_record_params)

    if sleep_record.save
      render_success(sleep_record, status: :success)
    else
      render_error(sleep_record, status: :unprocessable_entity)
    end
  end

  # List all sleep records for the given user, ordered by start_time in descending order
  def index
    sleep_records = @user.sleep_records.order(start_time: :desc)

    render_success(sleep_records, status: :success)
  end

  private

  # Set the user for the current request
  def set_user
    @user = User.find(params[:user_id])
  end

  # Strong parameters for creating a sleep record
  def sleep_record_params
    params.require(:sleep_record).permit(:start_time, :end_time)
  end

  # Renders a successful JSON response
  def render_success(data, options = {})
    render options.merge(json: { status: 'success', data: data })
  end

  # Renders an error JSON response
  def render_error(errors, options = {})
    render options.merge(json: { status: 'error', data: errors })
  end
end
