module TicketsHelper
  def tag_list(ticket)
    ticket.tags.map(&:name).join(", ")
  end
end