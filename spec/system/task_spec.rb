require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:user) do
    User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
  end

  before do
    driven_by(:rack_test)

    user.tasks.create!(
      title: 'Old task',
      content: 'Old content',
      deadline_on: Date.current + 3.days,
      priority: :low,
      status: :not_started,
      created_at: 3.days.ago
    )

    user.tasks.create!(
      title: 'New task',
      content: 'New content',
      deadline_on: Date.current + 1.day,
      priority: :high,
      status: :completed,
      created_at: 1.day.ago
    )

    visit new_session_path
    fill_in 'Email address', with: 'test@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  describe 'List Display Function' do
    it 'displays tasks in descending order of creation' do
      visit tasks_path

      task_titles = page.all('tbody tr td:first-child').map(&:text)

      expect(task_titles[0]).to eq 'New task'
      expect(task_titles[1]).to eq 'Old task'
    end

    it 'shows pagination' do
      15.times do |i|
        user.tasks.create!(
          title: "Task #{i}",
          content: "Content #{i}",
          deadline_on: Date.current,
          priority: :medium,
          status: :in_progress
        )
      end

      visit tasks_path

      expect(page).to have_selector('.pagination')
    end
  end
end