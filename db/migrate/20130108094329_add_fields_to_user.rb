class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :employee_id, :integer
    add_column :users, :department_id, :integer
    add_column :users, :designation, :string
  end
end
