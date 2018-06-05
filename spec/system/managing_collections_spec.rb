require 'rails_helper'

RSpec.describe 'managing collections' do
  let!(:collection) { FactoryBot.create(:collection, name: 'dogs and cats') }
  let!(:topic){ FactoryBot.create(:topic, name: 'dog topic') }
  let!(:unrelated_topic){ FactoryBot.create(:topic, name: 'unrelated') }

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
end
