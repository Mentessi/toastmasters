require 'rails_helper'

RSpec.describe 'authenticating users' do

  let!(:user) { FactoryBot.create :user}

  scenario 'when signing up' do
    visit '/'
    click_on 'Sign Up'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
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
end


