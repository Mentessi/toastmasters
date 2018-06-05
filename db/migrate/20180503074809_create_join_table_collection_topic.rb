class CreateJoinTableCollectionTopic < ActiveRecord::Migration[5.1]
  def change
    create_join_table :collections, :topics do |t|
      t.index [:collection_id, :topic_id]
      t.index [:topic_id, :collection_id]
    end
  end
end
