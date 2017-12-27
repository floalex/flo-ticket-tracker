module ApplicationHelper

  def options_for_ticket_status(selected=nil)
    options_for_select(Ticket::STATUSES.map {|status| [status, status]}, selected) # ['status', status] <option value="status">status</option>
  end
 
  # user time_ago_in_words in Rails 
  def display_time_ago(time)
    time_passed = Time.now - time
    one_day = 60*60*24
    one_hour = 60*60
    day_distance = (time_passed/one_day).to_i
    hour_distance = (time_passed/one_hour).to_i
    minute_distance = (time_passed/60).to_i
    if day_distance > 0
      pluralize(day_distance, 'day') + " ago"
    elsif hour_distance > 0
      pluralize(hour_distance, 'hour') + " ago"
    else
      pluralize(minute_distance, 'minute') + " ago"
    end
  end

end
