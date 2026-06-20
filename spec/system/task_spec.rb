require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  describe 'List Display Function' do
    it 'displays tasks in descending order of creation' do
      Task.create!(title: 'Old Task', content: 'Old Content')
      Task.create!(title: 'New Task', content: 'New Content')

      visit tasks_path

      expect(page.text.index('New Task')).to be < page.text.index('Old Task')
    end

    it 'shows pagination' do
      11.times do |i|
        Task.create!(title: "Task #{i}", content: "Content #{i}")
      end

      visit tasks_path

      expect(page).to have_css('.pagination')
    end
  end

  describe 'Search function' do
    context 'When searching by label' do
      it 'All tasks with that label are displayed.' do
        label1 = Label.create!(name: 'Work')
        label2 = Label.create!(name: 'Study')

        task1 = Task.create!(title: 'Task A', content: 'Content A')
        task2 = Task.create!(title: 'Task B', content: 'Content B')

        task1.labels << label1
        task2.labels << label2

        visit tasks_path

        select 'Work', from: 'Labels'
        click_button 'Search'

        expect(page).to have_content 'Task A'
        expect(page).not_to have_content 'Task B'
      end
    end
  end
end