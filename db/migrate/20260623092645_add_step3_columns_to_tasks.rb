class AddStep3ColumnsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :deadline_on, :date unless column_exists?(:tasks, :deadline_on)
    add_column :tasks, :priority, :integer, default: 0 unless column_exists?(:tasks, :priority)
    add_column :tasks, :status, :integer, default: 0 unless column_exists?(:tasks, :status)
  end
end