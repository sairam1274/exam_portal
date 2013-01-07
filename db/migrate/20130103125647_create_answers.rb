class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :technology_id
      t.integer :topic_id
      t.boolean :is_correct, :default => false
      t.integer :question_id
      t.string :question_type
      t.string :question_title
      t.string :actual_answer_ids
      t.string :given_answer_ids
      t.text :actual_answers
      t.text :given_answers
      t.text :free_text_answer
      t.integer :exam_id
      t.timestamps
    end
  end
end
