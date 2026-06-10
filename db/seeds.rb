50.times do |i|
  Task.create!(
    title: "Task #{i + 1}",
    content: "This is task number #{i + 1}"
  )
end