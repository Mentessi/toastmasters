require 'rails_helper'

RSpec.describe 'managing topics' do
  before do
    FactoryBot.create(:topic, name: 'What is your favourite colour')
  end

  scenario 'when viewing' do
    visit('/topics')
    expect(page).to have_content('Topics')
    expect(page).to have_content('What is your favourite colour')
  end

  scenario 'when creating a topic' do
    visit topics_path
    click_link 'New Topic'
    click_button 'Create'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'tell us a story'
    click_button 'Create'
    expect(current_path).to eq topics_path
    expect(page).to have_content 'tell us a story'
  end
end
