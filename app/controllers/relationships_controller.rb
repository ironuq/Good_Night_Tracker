# frozen_string_literal: true

#-------------------------
# todo: error handlings for when the query and body parameters include non-existing ids
# todo: error handlings for when trying to delete non-existing relationships
# todo: error handling for when trying create relationship that already exists
#-------------------------

# RelationshipsController handles the creation and destruction of relationships
# between users (followers and followings).
class RelationshipsController < ApplicationController
  before_action :set_users, only: %i[create destroy]

  # Create a new relationship between follower and followed
  def create
    relationship = @follower.active_relationships.build(followed_id: @followed.id)

    if relationship.save
      render_success(relationship)
    else
      render_error(relationship.errors)
    end
  end

  # Destroy an existing relationship follower and followed
  def destroy
    relationship = Relationship.find_by(follower_id: @follower.id, followed_id: @followed.id)

    if relationship&.destroy
      render_success(relationship)
    else
      render_error(relationship&.errors || 'Relationship not found')
    end
  end

  private

  # Set the follower and followed users
  def set_users
    # FIXME: follower_id should be id
    @follower = User.find_by(id: params[:follower_id])
    @followed = User.find_by(id: params[:followed_id])

    return if @follower && @followed

    render_error('User not found')
  end

  # Render a JSON response indicating success
  def render_success(data)
    render json: { status: 'SUCCESS', data: data }
  end

  # Render a JSON response indicating an error
  def render_error(errors)
    render json: { status: 'ERROR', data: errors }
  end
end
