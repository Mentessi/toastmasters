class CollectionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      redirect_to collections_path
    else
      render :new
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end
end
