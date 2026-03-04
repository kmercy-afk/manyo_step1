require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation test' do
    context 'when the task title is an empty string' do
      it 'validation fails (task is invalid)' do
        task = Task.new(title: '', content: 'Write a report')
        expect(task).not_to be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'when the task content is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(title: 'Important meeting', content: '')
        expect(task).not_to be_valid
        expect(task.errors[:content]).to include("can't be blank")
      end
    end

    context 'when both title and content have values' do
      it 'the task is valid and can be saved' do
        task = Task.new(title: 'Buy groceries', content: 'Milk, eggs, bread')
        expect(task).to be_valid
        expect { task.save }.to change { Task.count }.by(1)
      end
    end
  end
end