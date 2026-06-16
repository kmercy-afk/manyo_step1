class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def up
    add_reference :tasks, :user, foreign_key: true

    user = User.find_or_create_by!(email: 'general@example.com') do |u|
      u.name = 'General User'
      u.password = 'password'
      u.password_confirmation = 'password'
      u.admin = false
    end

    Task.where(user_id: nil).update_all(user_id: user.id)

    change_column_null :tasks, :user_id, false
  end

  def down
    remove_reference :tasks, :user, foreign_key: true
  end
end