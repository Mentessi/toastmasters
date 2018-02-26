require 'rails_helper'

RSpec.describe 'managing topics' do
  before do
    @topic = FactoryBot.create(:topic, name: 'What is your favourite colour', id: 1)
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

  scenario 'viewing a topic' do
    visit topics_path
    click_on('What is your favourite colour')
    expect(current_path).to eq topic_path(@topic.id)
    expect(page).to have_content('Topic: 1')
  end
end
