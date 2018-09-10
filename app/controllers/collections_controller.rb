# frozen_string_literal: true

class CollectionsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_current_user_collection, only: %i[update edit destroy]

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
    @collection = current_user.collections.new(collection_params)
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

  def set_current_user_collection
    @collection = current_user.collections.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(
      :name,
      :id,
      collections_memberships_attributes: %i[id collection_id topic_id _destroy]
    )
  end
end
