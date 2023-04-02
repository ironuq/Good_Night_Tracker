# frozen_string_literal: true

# CreateRelationships migration creates the relationships table in the database.
# It defines the follower_id, followed_id, and timestamps columns.
# It also adds indices for follower_id, followed_id, and a unique index for the combination of both.
class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    # Add an index to improve query performance for follower_id and followed_id
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # Add a unique index to ensure a follower can only follow a user once
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
