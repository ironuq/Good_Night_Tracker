# frozen_string_literal: true

#-------------------------
# todo: error handlings for when the query and body parameters include non-existing ids
# todo: error handlings for when trying to delete non-existing relationships
#-------------------------

# RelationshipsController handles the creation and deletion of relationships between users.
class RelationshipsController < ApplicationController
  before_action :set_users, only: %i[create destroy]
  # Create a new relationship between two users (follower and followed)
  def create
    relationship = @follower.active_relationships.build(followed_id: @followed.id)

    if relationship.save
      render json: { status: 'SUCCESS', data: relationship }
    else
      render json: { status: 'ERROR', data: relationship.errors }
    end
  end

  # Destroy an existing relationship between two users (follower and followed)
  def destroy
    relationship = Relationship.find_by(follower_id: @follower.id, followed_id: @followed.id)

    if relationship.destroy
      render json: { status: 'SUCCESS', data: relationship }
    else
      render json: { status: 'ERROR', data: relationship.errors }
    end
  end

  private

  # Set the follower and followed users
  def set_users
    @follower = User.find_by(id: params[:follower_id])
    @followed = User.find_by(id: params[:followed_id])

    return if @follower && @followed

    render_error('User not found')
  end
end
