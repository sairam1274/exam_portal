class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :technology_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
