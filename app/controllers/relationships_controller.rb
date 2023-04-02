# frozen_string_literal: true

# RelationshipsController handles the creation and destruction of relationships
# between users (followers and followings).
class RelationshipsController < ApplicationController
  before_action :set_users, only: %i[create destroy]

  # Create a new relationship between follower and followed
  def create
    # Check if the relationship already exists
    existing_relationship = Relationship.find_by(follower_id: @follower.id, followed_id: @followed.id)
    if existing_relationship
      # Render an error if the relationship already exists
      render_error('Relationship already exists', status: :unprocessable_entity)
      return
    end

    if relationship.save
      render_success(relationship, status: :created)
    else
      render_error(relationship.errors, status: :unprocessable_entity)
    end
  end

  # Destroy an existing relationship follower and followed
  def destroy
    relationship = Relationship.find_by(follower_id: @follower.id, followed_id: @followed.id)

    if relationship&.destroy
      render_success(relationship, status: :ok)
    else
      render_error(relationship&.errors || 'Relationship not found')
    end
  end

  private

  # Set the follower and followed users
  def set_users
    @follower = User.find_by(id: params[:id])
    @followed = User.find_by(id: params[:followed_id])

    return if @follower && @followed

    render_error('User not found', status: :not_found)
  end

  # Render a JSON response indicating success
  def render_success(data, options = {})
    render options.merge(json: { status: 'success', data: data })
  end

  # Render a JSON response indicating an error
  def render_error(errors, options = {})
    render options.merge(json: { status: 'error', data: errors })
  end
end
