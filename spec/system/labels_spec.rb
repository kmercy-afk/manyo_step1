require 'rails_helper'

RSpec.describe 'Label management function', type: :system do
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
        Label.create!(name: 'Study')

        visit labels_path

        expect(page).to have_content 'Study'
      end
    end
  end
end