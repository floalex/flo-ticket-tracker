class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_ticket
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_creator, only: [:edit, :update, :destroy]
  
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.creator = current_user
    
    if @comment.save
      if params[:ticket_status].present?
        @ticket.update_attributes!(status: params[:ticket_status])
      end
      
      flash[:success] = 'Comment was added.'
      redirect_to @ticket
    else
      flash[:danger] = 'Comment can not be blank.'
      redirect_to @ticket
    end
  end
  
  def update
    if @comment.update(comment_params)
      if params[:ticket_status].present?
        @ticket.update_attributes!(status: params[:ticket_status])
      end
      
      flash[:success] = 'Comment was updated.'
      redirect_to @ticket
    else
      flash[:danger] = 'Comment can not be blank.'
      redirect_to @ticket
    end
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment was deleted."
    redirect_to @ticket
  end
  
  private
  
  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def require_creator
    if current_user != @comment.creator
      flash[:danger] = "You can only edit your own comments."
      redirect_to @ticket
    end
  end
end