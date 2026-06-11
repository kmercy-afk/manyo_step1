require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:task_old) do
    Task.create!(
      title: "Old task",
      content: "Old content",
      deadline_on: Date.new(2022, 2, 18),
      priority: :medium,
      status: :not_started,
      created_at: 3.days.ago
    )
  end

  let!(:task_mid) do
    Task.create!(
      title: "Mid task",
      content: "Mid content",
      deadline_on: Date.new(2022, 2, 17),
      priority: :high,
      status: :in_progress,
      created_at: 2.days.ago
    )
  end

  let!(:task_new) do
    Task.create!(
      title: "New task",
      content: "New content",
      deadline_on: Date.new(2022, 2, 16),
      priority: :low,
      status: :completed,
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
        Task.create!(
          title: "Task #{i}",
          content: "Content #{i}",
          deadline_on: Date.today,
          priority: :medium,
          status: :not_started
        )
      end

      visit tasks_path

      expect(page).to have_selector('.pagination')
    end

    describe 'sort function' do
      context 'If you click on the link "End Date"' do
        it 'A list of tasks sorted in ascending order of due date is displayed.' do
          visit tasks_path
          click_link 'End Date'

          task_titles = all('tbody tr td:first-child').map(&:text)

          expect(task_titles[0]).to eq 'New task'
          expect(task_titles[1]).to eq 'Mid task'
          expect(task_titles[2]).to eq 'Old task'
        end
      end

      context 'If you click on the link "Priority"' do
        it 'A list of tasks sorted by priority is displayed' do
          visit tasks_path
          click_link 'Priority'

          task_titles = all('tbody tr td:first-child').map(&:text)

          expect(task_titles[0]).to eq 'Mid task'
          expect(task_titles[1]).to eq 'Old task'
          expect(task_titles[2]).to eq 'New task'
        end
      end
    end

    describe 'Search function' do
      context 'If you do a fuzzy search by Title' do
        it 'Only tasks containing the search word will be displayed.' do
          visit tasks_path

          fill_in 'Title', with: 'Old'
          click_button 'Search'

          expect(page).to have_content 'Old task'
          expect(page).not_to have_content 'Mid task'
          expect(page).not_to have_content 'New task'
        end
      end

      context 'Search by status' do
        it 'Only tasks matching the searched status will be displayed' do
          visit tasks_path

          select 'In progress', from: 'Status'
          click_button 'Search'

          expect(page).to have_content 'Mid task'
          expect(page).not_to have_content 'Old task'
          expect(page).not_to have_content 'New task'
        end
      end

      context 'Title and search by status' do
        it 'Only tasks that contain the search word Title and match the status will be displayed' do
          visit tasks_path

          fill_in 'Title', with: 'New'
          select 'Completed', from: 'Status'
          click_button 'Search'

          expect(page).to have_content 'New task'
          expect(page).not_to have_content 'Old task'
          expect(page).not_to have_content 'Mid task'
        end
      end
    end
  end
end