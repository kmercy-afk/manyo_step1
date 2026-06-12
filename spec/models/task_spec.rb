require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation test' do
    context 'when the task title is an empty string' do
      it 'validation fails (task is invalid)' do
        task = Task.new(
          title: '',
          content: 'Write a report',
          deadline_on: Date.today,
          priority: :medium,
          status: :not_started
        )

        expect(task).not_to be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'when the task content is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(
          title: 'Important meeting',
          content: '',
          deadline_on: Date.today,
          priority: :medium,
          status: :not_started
        )

        expect(task).not_to be_valid
        expect(task.errors[:content]).to include("can't be blank")
      end
    end

    context 'when both title and content have values' do
      it 'the task is valid and can be saved' do
        task = Task.new(
          title: 'Buy groceries',
          content: 'Milk, eggs, bread',
          deadline_on: Date.today,
          priority: :medium,
          status: :not_started
        )

        expect(task).to be_valid
        expect { task.save }.to change { Task.count }.by(1)
      end
    end

    context 'when deadline_on is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(
          title: 'Buy groceries',
          content: 'Milk, eggs, bread',
          deadline_on: nil,
          priority: :medium,
          status: :not_started
        )

        expect(task).not_to be_valid
        expect(task.errors[:deadline_on]).to include("can't be blank")
      end
    end

    context 'when priority is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(
          title: 'Buy groceries',
          content: 'Milk, eggs, bread',
          deadline_on: Date.today,
          priority: nil,
          status: :not_started
        )

        expect(task).not_to be_valid
        expect(task.errors[:priority]).to include("can't be blank")
      end
    end

    context 'when status is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(
          title: 'Buy groceries',
          content: 'Milk, eggs, bread',
          deadline_on: Date.today,
          priority: :medium,
          status: nil
        )

        expect(task).not_to be_valid
        expect(task.errors[:status]).to include("can't be blank")
      end
    end
  end

  describe 'Search function' do
    let!(:first_task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task) }
    let!(:third_task) { FactoryBot.create(:third_task) }

    context 'Title is performed by scope method' do
      it 'Tasks containing search words are narrowed down.' do
        expect(Task.search_title('first')).to include(first_task)
        expect(Task.search_title('first')).not_to include(second_task)
        expect(Task.search_title('first')).not_to include(third_task)
        expect(Task.search_title('first').count).to eq 1
      end
    end

    context 'When the status is searched with the scope method' do
      it 'Tasks that exactly match the status are narrowed down' do
        expect(Task.search_status('in_progress')).to include(second_task)
        expect(Task.search_status('in_progress')).not_to include(first_task)
        expect(Task.search_status('in_progress')).not_to include(third_task)
        expect(Task.search_status('in_progress').count).to eq 1
      end
    end

    context 'When performing fuzzy search and status search Title' do
      it 'Refine your search to tasks that contain the search word Title and match the status exactly.' do
        results = Task.search_title('third').search_status('completed')

        expect(results).to include(third_task)
        expect(results).not_to include(first_task)
        expect(results).not_to include(second_task)
        expect(results.count).to eq 1
      end
    end
  end
end