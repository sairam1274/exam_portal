class AddIsCompletedFieldToExam < ActiveRecord::Migration
  def change
    add_column :exams, :is_completed, :boolean, :default=> false
  end
end
