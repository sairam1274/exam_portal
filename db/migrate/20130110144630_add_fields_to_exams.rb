class AddFieldsToExams < ActiveRecord::Migration
  def change
    add_column :exams, :topic, :string
    add_column :exams, :technology, :string
  end
end
