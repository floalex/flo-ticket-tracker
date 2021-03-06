class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  
  def index
    @tickets = Ticket.all
    with_status_tag_search
  end
  
  def show
    @comment = Comment.new
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(ticket_params.merge!(creator: current_user))
    
    if @ticket.save
      redirect_to @ticket
      flash[:success] = "Ticket was successfully created."
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @ticket.update(ticket_params)
      redirect_to @ticket
      flash[:success] = "Ticket was successfully updated.."
    else
      render :edit
    end
  end
  
  def destroy
    @ticket.destroy
    redirect_to tickets_path
    flash[:success] = "Ticket was successfully deleted."
  end
  
  private
  
  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
  
  def ticket_params
    params.require(:ticket).permit(:name, :body, :status, :project_id, :assignee_id, tag_ids: [])
  end
  
  def with_status_tag_search
    if params[:project_id].present?
      @tickets = Project.find(params[:project_id]).tickets
    end
    if params[:search_term].present?
      @tickets = @tickets.search_by_name_or_description(params[:search_term])
    end
    if params[:status].present?
      @tickets = @tickets.where(status: params[:status])
    end
    if params[:tag_id].present?
      @tickets = @tickets.joins(:tags).where("tags.id" => params[:tag_id])
    end
  end
end