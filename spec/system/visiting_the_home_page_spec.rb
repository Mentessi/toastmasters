# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'visiting home page' do
  it 'when viewing' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end
