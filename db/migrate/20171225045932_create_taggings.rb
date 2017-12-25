class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :ticket_id, :tag_id
      t.timestamps
    end
  end
end
