Task.destroy_all

Task.create!(
  title: "First Task",
  content: "Complete assignment",
  deadline_on: Date.new(2026, 6, 20),
  priority: :medium,
  status: :not_started
)

Task.create!(
  title: "Second Task",
  content: "Review code",
  deadline_on: Date.new(2026, 6, 18),
  priority: :high,
  status: :in_progress
)

Task.create!(
  title: "Third Task",
  content: "Write tests",
  deadline_on: Date.new(2026, 6, 16),
  priority: :low,
  status: :completed
)

Task.create!(
  title: "Fourth Task",
  content: "Fix bugs",
  deadline_on: Date.new(2026, 6, 25),
  priority: :high,
  status: :not_started
)

Task.create!(
  title: "Fifth Task",
  content: "Deploy application",
  deadline_on: Date.new(2026, 6, 30),
  priority: :medium,
  status: :in_progress
)

Task.create!(
  title: "Sixth Task",
  content: "Update documentation",
  deadline_on: Date.new(2026, 7, 5),
  priority: :low,
  status: :completed
)

Task.create!(
  title: "Seventh Task",
  content: "Prepare report",
  deadline_on: Date.new(2026, 7, 10),
  priority: :high,
  status: :not_started
)

Task.create!(
  title: "Eighth Task",
  content: "Client meeting",
  deadline_on: Date.new(2026, 7, 12),
  priority: :medium,
  status: :in_progress
)

Task.create!(
  title: "Ninth Task",
  content: "Database cleanup",
  deadline_on: Date.new(2026, 7, 15),
  priority: :low,
  status: :completed
)

Task.create!(
  title: "Tenth Task",
  content: "Final review",
  deadline_on: Date.new(2026, 7, 20),
  priority: :high,
  status: :not_started
)