class RemoveOpenFromTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :open
  end
end
