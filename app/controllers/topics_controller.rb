class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create(topic_params)
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
    Topic.find(params[:id]).destroy
    redirect_to topics_path
  end

  def edit
    @topic = Topic.find_by_id(params[:id])
  end

  def update
    @topic = Topic.find_by_id(params[:id])
    @topic.update!(topic_params)
    redirect_to topic_path(@topic.id)
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end
end
