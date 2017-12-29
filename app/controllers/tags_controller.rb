class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  
  def index
    @tags = Tag.with_counts.alphabetical
  end
  
  def new
    @tag = Tag.new
  end
  
  def create
    @tag = Tag.new(tag_params)
    
    if @tag.save
      redirect_to tags_path
      flash[:success] = "Tag was successfully created."
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @tag.update(tag_params)
      redirect_to tags_path
      flash[:success] = "Tag was successfully updated.."
    else
      render :edit
    end
  end
  
  def destroy
    @tag.destroy
    redirect_to tags_path
    flash[:success] = "Tag was successfully deleted."
  end
  
  private
  
  def set_tag
    @tag = Tag.find(params[:id])
  end
  
  def tag_params
    params.require(:tag).permit(:name)
  end
end