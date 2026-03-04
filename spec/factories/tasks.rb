FactoryBot.define do
  factory :task do
    title   { "Write weekly report" }
    content { "Summarize this week's progress" }
  end

  factory :second_task, class: Task do
    title   { "Call client" }
    content { "Discuss project timeline" }
  end
end