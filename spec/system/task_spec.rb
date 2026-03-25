require 'rails_helper'

RSpec.describe 'Task management', type: :system do
  describe 'List display function' do
    let!(:task1) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18') }
    let!(:task2) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17') }
    let!(:task3) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16') }

    before do
      visit tasks_path
    end

    it 'displays tasks in descending order of creation date and time' do
      task_list = all('tbody tr')

      expect(task_list[0]).to have_content 'first_task'
      expect(task_list[1]).to have_content 'second_task'
      expect(task_list[2]).to have_content 'third_task'
    end
  end

  describe 'Task creation' do
    before do
      visit tasks_path
      find('#new-task-link').click
    end

    it 'creates a new task and displays it at the top' do
      fill_in 'Title', with: 'new_task'
      fill_in 'Content', with: 'new_content'
      find('#create-task').click

      expect(page).to have_content 'I have registered a task'

      visit tasks_path
      expect(all('tbody tr')[0]).to have_content 'new_task'
    end
  end
end