require 'rails_helper'

RSpec.describe 'managing collections' do
  let!(:collection1) { FactoryBot.create :collection, name: 'Dogs and cats' }
  let!(:collection2) { FactoryBot.create :collection, name: 'Rabbits and hamsters' }
  let!(:collection3) { FactoryBot.create :collection, name: 'Monkeys and lamas', user: collection1.user }
  let!(:unrelated_topic){ FactoryBot.create :topic, name: 'unrelated' }
  let!(:topic){ FactoryBot.create :topic, name: 'dog topic' }
  let!(:user){ collection1.user }
  let!(:user2){ collection2.user }

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

    # Cant delete if not collection owner
    sign_in user
    visit collection_path(collection2)
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

    # Can only add to own collections
    sign_in user
    visit topic_path(topic)
    expect(page).to have_no_content('Rabbits and hamsters')

    #Can add own topic to collection
    sign_in user
    visit topic_path(topic)
    expect(page).to have_content('Add to collection')
    expect(page).to have_content collection1.name
    find('label', :text => collection1.name).click
    click_button 'Update'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content "collection(s) successfully updated"
    expect(page).to have_field(collection1.name, checked: true, visible: false)

    #can update multiple collections at once when logged in
    find('label', :text => collection1.name).click
    find('label', :text => collection3.name).click
    click_button 'Update'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content "collection(s) successfully updated"
    expect(page).to have_field(collection1.name, checked: false, visible: false)
    expect(page).to have_field(collection3.name, checked: true, visible: false)
  end
end
