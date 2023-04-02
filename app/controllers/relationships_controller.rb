# frozen_string_literal: true

# RelationshipsController handles the creation and deletion of relationships between users.
class RelationshipsController < ApplicationController
  # Create a new relationship between two users (follower and followed)
  def create
    follower = User.find(params[:follower_id])
    followed = User.find(params[:followed_id])

    relationship = follower.active_relationships.build(followed_id: followed.id)

    if relationship.save
      render json: { status: 'SUCCESS', data: relationship }
    else
      render json: { status: 'ERROR', data: relationship.errors }
    end
  end

  # Destroy an existing relationship between two users (follower and followed)
  def destroy
    relationship = Relationship.find_by(follower_id: params[:id], followed_id: params[:followed_id])

    if relationship.destroy
      render json: { status: 'SUCCESS', data: relationship }
    else
      render json: { status: 'ERROR', data: relationship.errors }
    end
  end
end
