class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :technology_id
      t.integer :topic_id
      t.text :title
      t.string :question_type
      t.integer :parent_id
      t.text :note
      t.string :description

      t.timestamps
    end
  end
end
