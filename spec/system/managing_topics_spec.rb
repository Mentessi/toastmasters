require 'rails_helper'

RSpec.describe 'managing topics' do

  let!(:topic) { FactoryBot.create :topic, name: 'What is your favourite colour'}

  scenario 'when viewing' do
    visit topics_path
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
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content('Topic:')
  end

  scenario 'when deleting a topic' do
    visit topic_path(topic)
    expect {
      accept_confirm { click_on 'Delete Topic' }
      expect(current_path).to eq topics_path
    }.to change(Topic, :count).by(-1)
    expect(page).to have_no_content 'What is your favourite colour'
  end

  scenario 'when editing a topic' do
    visit topic_path(topic)
    click_link 'Edit Topic'
    expect(current_path).to eq edit_topic_path(topic)
    expect(page).to have_content 'What is your favourite colour'
    fill_in 'Name', with: ''
    click_button 'Update Topic'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'this is my new topic'
    click_button 'Update Topic'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content 'this is my new topic'
  end
end
