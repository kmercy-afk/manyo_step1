require 'rails_helper'

RSpec.describe 'Label management function', type: :system do
  before do
    @user = User.create!(
      name: 'Test User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    login_as(@user)
  end

  describe 'Registration function' do
    context 'When a label is registered' do
      it 'Registered labels are displayed.' do
        visit new_label_path
        fill_in 'Name', with: 'Important'
        click_button 'register'

        expect(page).to have_content 'Important'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of registered labels is displayed.' do
        Label.create!(name: 'Study', user: @user)

        visit labels_path

        expect(page).to have_content 'Study'
      end
    end
  end
end