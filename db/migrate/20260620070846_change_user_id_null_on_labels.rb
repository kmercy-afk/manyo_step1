class ChangeUserIdNullOnLabels < ActiveRecord::Migration[6.1]
  def change
    change_column_null :labels, :user_id, true
  end
end