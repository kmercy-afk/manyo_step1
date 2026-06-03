require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation test' do
    context 'when the task title is an empty string' do
      it 'validation fails (task is invalid)' do
        task = Task.new(title: '', content: 'Content')
        task.valid?
        expect(task.errors[:title]).to be_present
      end
    end

    context 'when the task content is empty' do
      it 'validation fails (task is invalid)' do
        task = Task.new(title: 'Title', content: '')
        task.valid?
        expect(task.errors[:content]).to be_present
      end
    end

    context 'when both title and content have values' do
      it 'the task is valid and can be saved' do
        task = Task.new(title: 'Test title', content: 'Test content')
        expect(task).to be_valid
      end
    end
  end
end