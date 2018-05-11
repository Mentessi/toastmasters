class AddUsersAssociationToTopics < ActiveRecord::Migration[5.1]
  def change
    add_reference :topics, :user, foreign_key: true
  end
end
