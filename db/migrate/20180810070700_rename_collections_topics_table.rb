class RenameCollectionsTopicsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :collections_topics, :collections_memberships
  end
end
