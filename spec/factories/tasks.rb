FactoryBot.define do
  factory :task do
    title { "sample task" }
    content { "Sample content" }
  end

  # Optional second factory for variety in system tests
  factory :second_task, class: Task do
    title { "Call client" }
    content { "Discuss project deadline" }
  end
end