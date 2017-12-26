class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  
  def index
    @tickets = Ticket.all
  end
  
  def show
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(ticket_params)
    
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
    params.require(:ticket).permit(:name, :body, :status, :open, :project_id, tag_ids: [])
  end
end