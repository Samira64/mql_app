class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.string :url
      t.boolean :is_approved, default: false
      t.boolean :is_completed, default: false

      t.timestamps
    end
  end
end
