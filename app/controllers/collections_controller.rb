class CollectionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_current_collection, only: [:update, :edit, :destroy]

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

  def edit
    render :edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to collection_path
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to collections_path
  end

  private

  def set_current_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name)
  end
end
