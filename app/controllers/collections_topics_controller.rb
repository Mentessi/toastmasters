class CollectionsTopicsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @collection = Collection.find(params[:add_topic_to_collection])

    if @topic.update(collections_topics_attributes: [{collection_id: @collection.id, topic_id: @topic.id}])

      redirect_to collection_path(@collection)
    else
      redirect_to topics_path
    end
  end
end
