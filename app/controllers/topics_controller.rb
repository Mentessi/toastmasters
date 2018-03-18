class TopicsController < ApplicationController

  before_action :topic_find, only: [:show, :edit, :update]

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
  end

  def destroy
    Topic.find(params[:id]).destroy
    redirect_to topics_path
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topic_path
    else
      @topic.name = Topic.find(params[:id]).name
      render :edit
    end
  end

  private

  def topic_find
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:name)
  end
end
