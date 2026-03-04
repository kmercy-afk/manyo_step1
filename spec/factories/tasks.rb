FactoryBot.define do
  factory :task do
    title { "Write weekly report" }
    content { "Summarize progress and plan next steps" }
  end

  # Optional second factory for variety in system tests
  factory :second_task, class: Task do
    title { "Call client" }
    content { "Discuss project deadline" }
  end
end