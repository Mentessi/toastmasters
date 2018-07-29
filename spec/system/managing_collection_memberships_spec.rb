require 'rails_helper'

RSpec.describe 'managing collections memberships' do
  let!(:collection1) { FactoryBot.create :collection, name: 'Dogs and cats' }
  let!(:collection2) { FactoryBot.create :collection, name: 'Monkeys and lamas', user: collection1.user }
  let!(:topic){ FactoryBot.create :topic, name: 'dog topic' }
  let!(:user){ collection1.user }

  # From Topics show page:
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
    find('label', :text => collection2.name).click
    click_button 'Update'
    expect(current_path).to eq topic_path(topic)
    expect(page).to have_content "collection(s) successfully updated"
    expect(page).to have_field(collection1.name, checked: false, visible: false)
    expect(page).to have_field(collection2.name, checked: true, visible: false)
  end

  # From Collections show page:
  scenario 'add a topic to a collection' do

    collection1.topics << topic

    sign_in user
    visit collection_path(collection1)
    click_link 'Edit Collection'
    expect(page).to have_content 'Dog topic'


  end
end
