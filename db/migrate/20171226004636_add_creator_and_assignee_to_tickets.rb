class AddCreatorAndAssigneeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :creator_id, :integer
    add_column :tickets, :assignee_id, :integer, null: true
  end
end
