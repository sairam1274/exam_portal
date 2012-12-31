class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :question_id
      t.text :answer
      t.string :answer_type
      t.boolean :correct_answer

      t.timestamps
    end
  end
end
