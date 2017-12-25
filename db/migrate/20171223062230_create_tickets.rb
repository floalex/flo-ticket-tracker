class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :body
      t.string :status, default: "new"
      t.boolean :open, default: true
      t.integer :project_id
      t.timestamps
    end
  end
end
