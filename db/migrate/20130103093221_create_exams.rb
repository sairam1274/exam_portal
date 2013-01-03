class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :user_id
      t.integer :technology_id
      t.integer :topic_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
