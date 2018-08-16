require 'rails_helper'

RSpec.describe 'pagination' do

  let!(:topics){ FactoryBot.create_list(:topic, 31) }

  scenario 'topic index is paginated' do
    visit topics_path
    expect(page).to have_link '2', exact: true
    expect(page).to have_link 'Next'
    click_link 'Next'
    expect(page).to have_current_path(topics_path(page: 2))
    expect(page).to have_link '1', exact: true
    expect(page).to_not have_link '2', exact: true
  end
end
