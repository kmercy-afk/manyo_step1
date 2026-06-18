class AddStep3ColumnsToTasks < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:tasks, :deadline_on)
      add_column :tasks, :deadline_on, :date, null: false, default: -> { 'CURRENT_DATE' }
    end

    unless column_exists?(:tasks, :priority)
      add_column :tasks, :priority, :integer, null: false, default: 0
    end

    unless column_exists?(:tasks, :status)
      add_column :tasks, :status, :integer, null: false, default: 0
    end

    unless index_exists?(:tasks, :status)
      add_index :tasks, :status
    end
  end
end