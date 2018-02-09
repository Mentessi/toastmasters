require 'rails_helper'

RSpec.describe 'visiting welcome page' do 
  scenario 'when viewing' do 
    visit('/') 
    expect(page).to have_content('Welcome')
  end
end