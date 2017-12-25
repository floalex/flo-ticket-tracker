class TagsController < ApplicationController
  before_action :set_tag, only: [:update, :destroy]
  
  def create
    @tag = Tag.new(tag_params)
    
    # if @tag.save
    # else
    # end
  end
  
  def update
    
  end
  
  def destroy
  end
  
  private
  
  def set_tag
    @tag = Tag.find(params[:id])
  end
  
  def tag_params
    params.require(:tag).permit(:name)
  end
end