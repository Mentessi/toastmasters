# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_user!, only: %i[new destroy create edit update]
  before_action :set_current_user_topic, only: %i[update destroy edit]

  def index
    @topics = Topic.paginate(page: params[:page], per_page: Rails.configuration.x.results_per_page)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path
    else
      render :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  def edit
    render :edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_path
    else
      render :edit
    end
  end

  private

  def set_current_user_topic
    @topic = current_user.topics.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name, collections_memberships_attributes: %i[collection_id topic_id _destroy])
  end
end
