require 'rails_helper'

RSpec.describe 'authenticating users' do

  let!(:user) { FactoryBot.create :user}

  scenario 'when signing up' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'Username', with: ''
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Sign up'
    expect(page).to have_content "Username can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"

    fill_in 'Username', with: 'Mentessi'
    fill_in 'Email', with: 'michael@bluespot.io'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'when logging in and out' do
    visit '/'
    click_on 'Log In'
    fill_in 'Email', with: ''
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content "Invalid Email or password"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    click_link 'Log Out'
    expect(page).to have_content 'Signed out successfully'
  end

  scenario 'when resetting a password' do
    visit '/'
    click_on 'Log In'
    click_on 'Forgot your password?'
    expect(current_path).to eq new_user_password_path
    fill_in 'Email', with: user.email
    click_on 'Send me reset password instructions'
    expect(page).to have_content 'You will receive an email with instructions'
    expect(current_path).to eq user_session_path
    expect(unread_emails_for(user.email)).to be_present
    open_email(user.email, with_subject: 'Reset password instructions')
    click_first_link_in_email
    fill_in 'New password', with: 'passw0rd'
    fill_in 'Confirm new password', with: 'passw0rd'
    click_button 'Change my password'
    expect(page).to have_content 'Your password has been changed successfully'
    click_link 'Log Out'
    expect(page).to have_content 'Signed out successfully'
    click_on 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'passw0rd'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
  end
end
