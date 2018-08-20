# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'managing topics' do
  let (:user) { FactoryBot.create :user }
  let!(:topic) do
    FactoryBot.create :topic, name: 'What is your favourite colour'
  end

  it 'when viewing' do
    visit topics_path
    expect(page).to have_content('Topics')
    expect(page).to have_content('What is your favourite colour')
  end

  it 'when creating a topic' do
    visit topics_path
    click_link 'New Topic'
    expect(page).to have_content('You need to sign in or sign up before continuing')
    sign_in user
    visit topics_path
    click_link 'New Topic'
    click_button 'Create'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'tell us a story'
    click_button 'Create'
    expect(page).to have_current_path topics_path
    expect(page).to have_content 'tell us a story'
  end

  it 'viewing a topic' do
    visit topics_path
    click_on('What is your favourite colour')
    expect(page).to have_current_path topic_path(topic)
    expect(page).to have_content('Topic:')
    expect(page).to have_content(topic.user.username)
  end

  it 'when deleting a topic' do
    # No delete button if not logged in
    visit topic_path(topic)
    expect(page).to have_no_button 'Delete Topic'

    # can't delete if not the topic owner
    sign_in user
    visit topic_path(topic)
    expect(page).to have_no_button 'Delete Topic'

    # can delete as the topic owner
    sign_in topic.user
    visit topic_path(topic)
    expect do
      accept_confirm { click_on 'Delete Topic' }
      expect(page).to have_current_path topics_path
    end.to change(Topic, :count).by(-1)
    expect(page).to have_no_content 'What is your favourite colour'
  end

  it 'when updating a topic' do
    # No link to edit if not logged in
    visit topic_path(topic)
    expect(page).to have_no_link 'Edit Topic'

    # can't edit if not the topic owner
    sign_in user
    visit topic_path(topic)
    expect(page).to have_no_link 'Edit Topic'

    # Can edit as the topic owner
    sign_in topic.user
    visit topic_path(topic)
    click_link 'Edit Topic'
    expect(page).to have_current_path edit_topic_path(topic)
    expect(page).to have_content 'What is your favourite colour'
    fill_in 'Name', with: ''
    click_button 'Update Topic'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'this is my new topic'
    click_button 'Update Topic'
    expect(page).to have_current_path topic_path(topic)
    expect(page).to have_content 'this is my new topic'
  end
end
