require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:task_old) do
    Task.create!(
      title: "Old task",
      content: "Old content",
      created_at: 3.days.ago
    )
  end

  let!(:task_mid) do
    Task.create!(
      title: "Mid task",
      content: "Mid content",
      created_at: 2.days.ago
    )
  end

  let!(:task_new) do
    Task.create!(
      title: "New task",
      content: "New content",
      created_at: 1.day.ago
    )
  end

  describe 'List Display Function' do
    it 'displays tasks in descending order of creation' do
      visit tasks_path

      task_titles = all('tbody tr td:first-child').map(&:text)

      expect(task_titles.index("New task")).to be < task_titles.index("Mid task")
      expect(task_titles.index("Mid task")).to be < task_titles.index("Old task")
    end

    it 'shows pagination' do
      15.times do |i|
        Task.create!(title: "Task #{i}", content: "Content #{i}")
      end

      visit tasks_path

      expect(page).to have_selector('.pagination')
    end
  end
end