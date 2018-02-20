require 'rails_helper'

RSpec.describe 'visiting topics page' do
  before do
    FactoryBot.create(:topic, name: 'What is your favourite colour')
  end

  scenario 'when viewing' do
    visit('/topics')
    expect(page).to have_content('Topics')
    expect(page).to have_content('What is your favourite colour')
  end
end
