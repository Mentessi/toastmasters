# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'managing collections' do
  let!(:collection1) { FactoryBot.create :collection, name: 'Dogs and cats' }
  let!(:collection2) { FactoryBot.create :collection, name: 'Rabbits and hamsters' }
  let!(:unrelated_topic) { FactoryBot.create :topic, name: 'unrelated' }
  let!(:topic) { FactoryBot.create :topic, name: 'dog topic' }
  let!(:user) { collection1.user }

  scenario 'when viewing collections' do
    visit collections_path
    expect(page).to have_content('Collections')
    expect(page).to have_content('Dogs and cats')
  end

  scenario 'viewing a single collection' do
    collection1.topics << topic
    visit collections_path
    expect(page).to have_content('Collections')
    click_link('Dogs and cats')
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
    visit collection_path(collection1)
    expect(page).not_to have_link 'Edit Collection'

    # Can't edit of not the collection owner
    sign_in user
    visit collection_path(collection2)
    expect(page).to have_no_link 'Edit Collection'

    # Can edit as collection owner
    sign_in user
    visit collection_path(collection1)
    click_link 'Edit Collection'
    expect(current_path).to eq edit_collection_path(collection1)
    expect(page).to have_content 'Dogs and cats'
    fill_in 'Name', with: ''
    click_button 'Update'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'rabbits'
    click_button 'Update'
    expect(current_path).to eq collection_path(collection1)
    expect(page).to have_content 'rabbits'
  end

  scenario 'deleting a collection' do
    # No delete button if not logged in
    visit collection_path(collection1)
    expect(page).to have_no_button 'Delete Collection'

    # Cant delete if not collection owner
    sign_in user
    visit collection_path(collection2)
    expect(page).to have_no_button 'Delete Collection'

    # can delete when logged in
    sign_in user
    visit collection_path(collection1)
    expect do
      accept_confirm { click_on 'Delete Collection' }
      expect(current_path).to eq collections_path
    end.to change(Collection, :count).by(-1)
    expect(page).to have_no_content 'Dogs and cats'
  end
end
