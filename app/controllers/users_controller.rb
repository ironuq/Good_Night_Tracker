# frozen_string_literal: true

#-------------------------
# todo:error handling for when asking for non-existing id
#-------------------------

# UsersController handles user-related actions
# such as showing user information, creating new users, and showing followers or following.
class UsersController < ApplicationController
  before_action :set_user, only: %i[show followers following friends_sleep_records]

  # Retrieves and displays sleep records of a user's friends (mutual followers) from the past week
  def friends_sleep_records
    friends = User.where(id: @user.following & @user.followers)
    friends_sleep_records = friends
                                  .joins(:sleep_records)
                                  .where('sleep_records.created_at >= ?', 1.week.ago)
                                  .order(Arel.sql('sleep_records.end_time - sleep_records.start_time DESC'))
                                  .select('users.*, sleep_records.*')

    render_success(friends_sleep_records)
  end

  # Retrieves and displays the specified user's information
  def show
    render_success(@user)
  end

  # Retrieves and displays a list of a user's followers
  def followers
    render_success(@user.followers)
  end

  # Retrieves and displays a list of users that the specified user is following
  def following
    render_success(@user.following)
  end

  # Creates a new user with the given parameters
  def create
    @user = User.new(user_params)
    if @user.save
      render_success(@user, status: :created)
    else
      render_error(@user.errors, status: :unprocessable_entity)
    end
  end

  private

  # Strong parameters for creating a user
  def user_params
    params.require(:user).permit(:name)
  end

  # Sets the @user instance variable for the specified actions
  def set_user
    @user = User.find_by(id: params[:id])

    return if @user

    render_error('User not found', status: :not_found)
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
