# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'visiting home page' do
  scenario 'when viewing' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end
