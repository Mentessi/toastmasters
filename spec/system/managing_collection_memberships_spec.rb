# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'managing collections memberships' do
  let!(:collection1) { FactoryBot.create :collection, name: 'Dogs and cats' }
  let!(:collection2) { FactoryBot.create :collection, name: 'Monkeys and lamas', user: collection1.user }
  let!(:topic1) { FactoryBot.create :topic, name: 'dog topic' }
  let!(:topic2) { FactoryBot.create :topic, name: 'cat topic' }
  let!(:user) { collection1.user }

  # From Topics show page:
  it 'add a topic to a collection on topic show page' do
    # No add topic to collection option if not logged in
    visit topic_path(topic1)
    expect(page).to have_no_content 'Add to collection'

    # Can only add to own collections
    sign_in user
    visit topic_path(topic1)
    expect(page).to have_no_content('Rabbits and hamsters')

    # Can add own topic to collection
    sign_in user
    visit topic_path(topic1)
    expect(page).to have_content('Add to collection')
    expect(page).to have_content collection1.name
    find('label', text: collection1.name).click
    click_button 'Update'
    expect(current_path).to eq topic_path(topic1)
    expect(page).to have_content 'collection(s) successfully updated'
    expect(page).to have_field(collection1.name, checked: true, visible: false)

    # can update multiple collections at once when logged in
    find('label', text: collection1.name).click
    find('label', text: collection2.name).click
    click_button 'Update'
    expect(current_path).to eq topic_path(topic1)
    expect(page).to have_content 'collection(s) successfully updated'
    expect(page).to have_field(collection1.name, checked: false, visible: false)
    expect(page).to have_field(collection2.name, checked: true, visible: false)
  end

  # From Collections edit page:
  it 'remove a topic from a collection on collection edit page' do
    collection1.topics << topic1
    collection1.topics << topic2

    # Can remove a topic from a collection
    sign_in user
    visit collection_path(collection1)
    expect(page).to have_content 'dog topic'
    expect(page).to have_content 'cat topic'
    click_link 'Edit Collection'
    expect(page).to have_field(topic1.name, checked: true, visible: false)
    expect(page).to have_field(topic1.name, checked: true, visible: false)
    find('label', text: topic1.name).click
    click_button 'Update'
    expect(page).to have_no_content 'dog topic'
    expect(page).to have_content 'cat topic'
    expect(current_path).to eq collection_path(collection1)

    # Can remove topics and edit collection name at the same time
    click_link 'Edit Collection'
    expect(page).to have_field(topic2.name, checked: true, visible: false)
    find('label', text: topic2.name).click
    fill_in 'Name', with: 'No more animal topics'
    click_button 'Update'
    expect(page).to have_no_content 'cat topic'
    expect(page).to have_content 'No more animal topics'
    expect(current_path).to eq collection_path(collection1)
  end
end
