FactoryBot.define do
  factory :task do
    title { "first_task" }
    content { "first content" }
    deadline_on { Date.new(2022, 2, 18) }
    priority { :medium }
    status { :not_started }
  end

  factory :second_task, class: Task do
    title { "second_task" }
    content { "second content" }
    deadline_on { Date.new(2022, 2, 17) }
    priority { :high }
    status { :in_progress }
  end

  factory :third_task, class: Task do
    title { "third_task" }
    content { "third content" }
    deadline_on { Date.new(2022, 2, 16) }
    priority { :low }
    status { :completed }
  end
end