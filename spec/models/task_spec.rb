require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Validation test' do
    context 'title is empty' do
      it 'is invalid (validation fails)' do
        task = Task.new(title: '', content: 'something')
        expect(task).not_to be_valid
      end
    end

    context 'content is empty' do
      it 'is invalid (validation fails)' do
        task = Task.new(title: 'something', content: '')
        expect(task).not_to be_valid
      end
    end

    context 'both title and content are present' do
      it 'is valid' do
        task = Task.new(title: 'Buy milk', content: 'Go to supermarket')
        expect(task).to be_valid
      end
    end
  end
end