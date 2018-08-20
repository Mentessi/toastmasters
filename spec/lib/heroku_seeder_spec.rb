# frozen_string_literal: true

require 'rails_helper'
require 'heroku_seeder'

RSpec.describe 'heroku runner' do
  context 'when running Heroku seeder' do
    it 'runs without raising errors' do
      expect { HerokuSeeder.run }.to_not raise_error
    end
  end
end
