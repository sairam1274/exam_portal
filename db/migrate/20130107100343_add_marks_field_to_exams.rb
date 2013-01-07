class AddMarksFieldToExams < ActiveRecord::Migration
  def change
    add_column :exams, :marks, :integer
   
  end
end
