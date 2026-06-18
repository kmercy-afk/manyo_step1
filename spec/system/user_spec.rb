require 'rails_helper'

RSpec.describe 'User Management Functions', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:user) do
    User.create!(
      name: 'General User',
      email: 'general@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
  end

  let!(:other_user) do
    User.create!(
      name: 'Other User',
      email: 'other@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    )
  end

  let!(:admin_user) do
    User.create!(
      name: 'Admin User',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password',
      admin: true
    )
  end

  describe 'Registration function' do
    context 'when a user is registered' do
      it 'transitions to the task list screen' do
        visit new_user_path
        fill_in 'Name', with: 'New User'
        fill_in 'Email address', with: 'new@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password (confirmation)', with: 'password'
        click_button 'register'

        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content('I have registered an account')
      end
    end

    context 'when moving to the task list screen without logging in' do
      it 'redirects to the login screen and displays Please log in' do
        visit tasks_path

        expect(page).to have_current_path(new_session_path)
        expect(page).to have_content('Please log in')
      end
    end
  end

  describe 'Login function' do
    context 'when logged in as a registered user' do
      before do
        visit new_session_path
        fill_in 'Email address', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
      end

      it 'moves to the task list screen and displays login message' do
        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content('I have logged in')
      end

      it 'accesses own detail screen' do
        visit user_path(user)

        expect(page).to have_content('Account Details Page')
        expect(page).to have_content(user.email)
      end

      it "redirects when accessing someone else's detail screen" do
        visit user_path(other_user)

        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content('You do not have permission to access')
      end

      it 'logs out and moves to login screen' do
        click_link 'Log out'

        expect(page).to have_current_path(new_session_path)
        expect(page).to have_content('logged out')
      end
    end
  end

  describe 'Administrator function' do
    before do
      visit new_session_path
      fill_in 'Email address', with: admin_user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    context 'when the administrator logs in' do
      it 'accesses the user list screen' do
        visit admin_users_path

        expect(page).to have_content('User View Page')
        expect(page).to have_content(user.email)
      end

      it 'can register administrators' do
        visit new_admin_user_path
        fill_in 'Name', with: 'Second Admin'
        fill_in 'Email address', with: 'second_admin@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password (confirmation)', with: 'password'
        check 'Administrator privileges'
        click_button 'register'

        expect(page).to have_current_path(admin_users_path)
        expect(page).to have_content('You have registered a user')
        expect(page).to have_content('second_admin@example.com')
      end

      it 'accesses user details screen' do
        visit admin_user_path(user)

        expect(page).to have_content('User Details Page')
        expect(page).to have_content(user.email)
      end

      it 'edits users other than yourself from the user edit screen' do
        visit edit_admin_user_path(user)
        fill_in 'Name', with: 'Edited User'
        click_button 'Update'

        expect(page).to have_current_path(admin_users_path)
        expect(page).to have_content('Updated users')
        expect(page).to have_content('Edited User')
      end

      it 'deletes users' do
        visit admin_users_path
        click_link 'delete', href: admin_user_path(other_user)

        expect(page).to have_content('You have deleted a user')
        expect(page).not_to have_content(other_user.email)
      end
    end

    context 'when a general user accesses the user list screen' do
      it 'moves to the task list screen and displays admin-only message' do
        click_link 'Log out'

        visit new_session_path
        fill_in 'Email address', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'

        visit admin_users_path

        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content('Only administrators can access')
      end
    end
  end
end