# frozen_string_literal: true

#-------------------------
# todo:error handling for when asking for non-existing id
#-------------------------

# UsersController handles user-related actions
# such as showing user information, creating new users, and showing followers or following.
class UsersController < ApplicationController
  # Retrieves and displays sleep records of a user's friends (mutual followers) from the past week
  def friends_sleep_records
    user = User.find(params[:id])
    friends = User.where(user_id: user.following & user.followers)
    friends_sleep_records = friends
                                  .joins(:sleep_records)
                                  .where('sleep_records.created_at >= ?', 1.week.ago)
                                  .order(Arel.sql('sleep_records.end_time - sleep_records.start_time DESC'))
                                  .select('users.*, sleep_records.*')

    render json: { status: 'success', data: friends_sleep_records }
  end

  # Retrieves and displays the specified user's information
  def show
    user = User.find(params[:id])
    render json: { status: 'success', data: user }
  end

  # Retrieves and displays a list of a user's followers
  def followers
    user = User.find(params[:id])
    followers = user.followers
    render json: followers
  end

  # Retrieves and displays a list of users that the specified user is following
  def following
    user = User.find(params[:id])
    following = user.following
    render json: following
  end

  # Creates a new user with the given parameters
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for creating a user
  def user_params
    params.require(:user).permit(:name)
  end
end
