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
end
