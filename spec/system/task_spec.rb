require 'rails_helper'

RSpec.describe 'Task management function', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Registration function' do
    it 'registered task is displayed on index' do
      visit new_task_path
      fill_in 'Title', with: 'Learn RSpec'
      fill_in 'Content', with: 'Read documentation'
      click_button 'Create Task'
      expect(page).to have_content 'Task was successfully created.'
      expect(page).to have_content 'Learn RSpec'
    end
  end

  describe 'List display function' do
    it 'shows list of registered tasks' do
      FactoryBot.create(:task)
      FactoryBot.create(:second_task)
      visit tasks_path
      expect(page).to have_content 'Write weekly report'
      expect(page).to have_content 'Call client'
    end
  end

  describe 'Detail display function' do
    it 'shows content of selected task' do
      task = FactoryBot.create(:task)
      visit task_path(task)
      expect(page).to have_content task.title
      expect(page).to have_content task.content
      expect(page).to have_content 'Show Task Page'
    end
  end
end