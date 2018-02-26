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
    @topic = Topic.find_by_id(params[:id])

    if @topic.nil?
      redirect_to topics_path
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name)
  end
end
