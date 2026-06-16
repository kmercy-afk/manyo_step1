require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation test' do
    context "if the user's name is empty" do
      it 'validation fails' do
        user = User.new(
          name: '',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        )

        expect(user).not_to be_valid
      end
    end

    context "if the user's email address is empty" do
      it 'validation fails' do
        user = User.new(
          name: 'Test User',
          email: '',
          password: 'password',
          password_confirmation: 'password'
        )

        expect(user).not_to be_valid
      end
    end

    context "if the user's password is empty" do
      it 'validation fails' do
        user = User.new(
          name: 'Test User',
          email: 'user@example.com',
          password: '',
          password_confirmation: ''
        )

        expect(user).not_to be_valid
      end
    end

    context "if the user's email address is already in use" do
      it 'validation fails' do
        User.create!(
          name: 'First User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        )

        user = User.new(
          name: 'Second User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        )

        expect(user).not_to be_valid
      end
    end

    context "if the user's password is less than 6 characters" do
      it 'validation fails' do
        user = User.new(
          name: 'Test User',
          email: 'user@example.com',
          password: 'pass',
          password_confirmation: 'pass'
        )

        expect(user).not_to be_valid
      end
    end

    context 'if name, unused email, and password of at least 6 characters are present' do
      it 'validation succeeds' do
        user = User.new(
          name: 'Test User',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        )

        expect(user).to be_valid
      end
    end
  end
end