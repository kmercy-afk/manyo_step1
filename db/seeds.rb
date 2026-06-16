Task.delete_all
User.delete_all

general_user = User.create!(
  name: 'general_user',
  email: 'general@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

admin_user = User.create!(
  name: 'admin_user',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

50.times do |i|
  general_user.tasks.create!(
    title: "general_task_title_#{i + 1}",
    content: "general_task_content_#{i + 1}",
    deadline_on: Date.current + i.days,
    priority: Task.priorities.keys.sample,
    status: Task.statuses.keys.sample
  )
end

50.times do |i|
  admin_user.tasks.create!(
    title: "admin_task_title_#{i + 1}",
    content: "admin_task_content_#{i + 1}",
    deadline_on: Date.current + i.days,
    priority: Task.priorities.keys.sample,
    status: Task.statuses.keys.sample
  )
end