require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  before do
    @user = User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    login_as(@user)
  end

  describe 'List Display Function' do
    it 'displays tasks in descending order of creation' do
      Task.create!(title: 'Old Task', content: 'Old Content', user: @user)
      Task.create!(title: 'New Task', content: 'New Content', user: @user)

      visit tasks_path

      expect(page.text.index('New Task')).to be < page.text.index('Old Task')
    end

    it 'shows pagination' do
      11.times do |i|
        Task.create!(title: "Task #{i}", content: "Content #{i}", user: @user)
      end

      visit tasks_path

      expect(page).to have_css('.pagination')
    end
  end

  describe 'Search function' do
    context 'When searching by label' do
      it 'All tasks with that label are displayed.' do
        label1 = Label.create!(name: 'Work', user: @user)
        label2 = Label.create!(name: 'Study', user: @user)

        task1 = Task.create!(title: 'Task A', content: 'Content A', user: @user)
        task2 = Task.create!(title: 'Task B', content: 'Content B', user: @user)

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