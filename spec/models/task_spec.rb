require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) do
    User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
  end

  describe 'Validation test' do
    context 'when the task title is an empty string' do
      it 'validation fails (task is invalid)' do
        task = user.tasks.build(
          title: '',
          content: 'Test content',
          deadline_on: Date.current,
          priority: :low,
          status: :not_started
        )

        expect(task).not_to be_valid
      end
    end

    context 'when the task content is empty' do
      it 'validation fails (task is invalid)' do
        task = user.tasks.build(
          title: 'Test title',
          content: '',
          deadline_on: Date.current,
          priority: :low,
          status: :not_started
        )

        expect(task).not_to be_valid
      end
    end

    context 'when both title and content have values' do
      it 'the task is valid and can be saved' do
        task = user.tasks.build(
          title: 'Buy groceries',
          content: 'Milk, eggs, bread',
          deadline_on: Date.current,
          priority: :low,
          status: :not_started
        )

        expect(task).to be_valid
      end
    end
  end
end