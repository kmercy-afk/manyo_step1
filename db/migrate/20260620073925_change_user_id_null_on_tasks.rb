class ChangeUserIdNullOnTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tasks, :user_id, true
  end
end