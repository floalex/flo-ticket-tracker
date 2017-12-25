module ApplicationHelper

  def options_for_ticket_status(selected=nil)
    options_for_select(Ticket::STATUSES.map {|status| [status, status]}, selected) # ['status', status] <option value="status">status</option>
  end
  

end
