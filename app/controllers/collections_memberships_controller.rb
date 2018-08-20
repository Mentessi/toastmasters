# frozen_string_literal: true

class CollectionsMembershipsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])

    if @topic.update(topic_params)
      redirect_to topic_path(@topic), notice: 'collection(s) successfully updated'
    else
      redirect_to topic_path(@topic)
    end
  end

  private

  def topic_params
    params.require(:topic).permit(
      collections_memberships_attributes: %i[
        id collection_id topic_id _destroy
      ]
    )
 end
end
