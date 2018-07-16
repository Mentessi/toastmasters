class AddIdToCollectionsTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :collections_topics, :id, :primary_key
  end
end
