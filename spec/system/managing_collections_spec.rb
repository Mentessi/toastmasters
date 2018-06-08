require 'rails_helper'

RSpec.describe 'managing collections' do
  let!(:collection) { FactoryBot.create :collection, name: 'dogs and cats' }
  let!(:topic){ FactoryBot.create :topic, name: 'dog topic' }
  let!(:unrelated_topic){ FactoryBot.create :topic, name: 'unrelated' }
  let!(:user){ FactoryBot.create :user }

  before do
    collection.topics << topic
  end

  scenario 'when viewing collections' do
    visit collections_path
    expect(page).to have_content('Collections')
    expect(page).to have_content('dogs and cats')
  end

  scenario 'viewing a single collection' do
    visit collections_path
    expect(page).to have_content('Collections')
    click_link('dogs and cats')
    expect(page).to have_content('dog topic')
    expect(page).not_to have_content('unrelated')
  end

  scenario 'creating a collection' do
    # No create button if not logged in
    visit collections_path
    expect(page).to_not have_link 'New Collection'

    sign_in user
    visit collections_path
    click_link 'New Collection'
    expect(current_path).to eq new_collection_path
    click_button 'Create'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'cat collection'
    click_button 'Create'
    expect(page).to have_content 'cat collection'
  end

  scenario 'updating a collection' do
    # No edit button if not logged in
    visit collection_path(collection)
    expect(page).not_to have_link 'Edit Collection'

    sign_in user
    visit collection_path(collection)
    expect(page).to have_link 'Edit Collection'

    sign_in user
    visit collection_path(collection)
    click_link 'Edit Collection'
    expect(current_path).to eq edit_collection_path(collection)
    expect(page).to have_content 'dogs and cats'
    fill_in 'Name', with: ''
    click_button 'Update Collection'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'rabbits'
    click_button 'Update Collection'
    expect(current_path).to eq collection_path(collection)
    expect(page).to have_content 'rabbits'
  end

  scenario 'deleting a collection' do
    # No delete button if not logged in
    visit collection_path(collection)
    expect(page).to have_no_button 'Delete Collection'

    # can delete when logged in
    sign_in user
    visit collection_path(collection)
    expect {
      accept_confirm { click_on 'Delete Collection' }
      expect(current_path).to eq collections_path
    }.to change(Collection, :count).by(-1)
    expect(page).to have_no_content 'dogs and cats'
  end

  scenario 'add a topic to a collection' do
    sign_in user
    visit topic_path(topic)
    expect(page).to have_select('add_topic_to_collection')
    select(collection.name, :from => 'add_topic_to_collection')
    click_button 'Add'
    expect(page).to have_content 'dog topic'
    expect(page).to have_content 'dogs and cats'
    expect(current_path).to eq collection_path(collection)
  end
end
