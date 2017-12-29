class AddUserToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :user_id, :integer
    remove_column :tickets, :creator_id, :integer
  end
end
