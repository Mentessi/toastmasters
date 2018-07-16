require 'rails_helper'

RSpec.describe 'managing collections' do
  let!(:collection1) { FactoryBot.create :collection, name: 'Dogs and cats' }
  let!(:collection2) { FactoryBot.create :collection, name: 'Rabbits and hamsters' }
  let!(:topic){ FactoryBot.create :topic, name: 'dog topic' }
  let!(:unrelated_topic){ FactoryBot.create :topic, name: 'unrelated' }
  let!(:user){ FactoryBot.create :user }

  before do
    collection1.topics << topic
  end

  scenario 'when viewing collections' do
    visit collections_path
    expect(page).to have_content('Collections')
    expect(page).to have_content('Dogs and cats')
  end

  scenario 'viewing a single collection' do
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

    sign_in user
    visit collection_path(collection1)
    expect(page).to have_link 'Edit Collection'

    sign_in user
    visit collection_path(collection1)
    click_link 'Edit Collection'
    expect(current_path).to eq edit_collection_path(collection1)
    expect(page).to have_content 'Dogs and cats'
    fill_in 'Name', with: ''
    click_button 'Update Collection'
    expect(page).to have_content "Name can't be blank"
    fill_in 'Name', with: 'rabbits'
    click_button 'Update Collection'
    expect(current_path).to eq collection_path(collection1)
    expect(page).to have_content 'rabbits'
  end

  scenario 'deleting a collection' do
    # No delete button if not logged in
    visit collection_path(collection1)
    expect(page).to have_no_button 'Delete Collection'

    # can delete when logged in
    sign_in user
    visit collection_path(collection1)
    expect {
      accept_confirm { click_on 'Delete Collection' }
      expect(current_path).to eq collections_path
    }.to change(Collection, :count).by(-1)
    expect(page).to have_no_content 'Dogs and cats'
  end

  scenario 'add a topic to a collection' do
    # No add topic to collection option if not logged in
    visit topic_path(topic)
    expect(page).to have_no_content 'Add to collection'

    #Can add topic to collection when logged in
    sign_in user
    visit topic_path(topic)
    expect(page).to have_content('Add to collection')
    expect(page).to have_content collection1.name
    page.check collection1.name
    click_button 'Update'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content "collection(s) successfully updated"
    expect(page).to have_field(collection1.name, checked: true)

    #can update multiple collections at once when logged in
    page.uncheck collection1.name
    page.check collection2.name
    click_button 'Update'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content "collection(s) successfully updated"
    expect(page).to have_field(collection1.name, checked: false)
    expect(page).to have_field(collection2.name, checked: true)
  end
end
