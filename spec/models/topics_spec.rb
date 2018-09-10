# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'name' do
    it 'is required' do
      topic = FactoryBot.build(:topic, name: '')
      expect(topic).to be_invalid
    end
  end

  describe 'factory' do
    subject { FactoryBot.build(:topic) }

    it { is_expected.to be_valid }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:collections_memberships) }
    it { is_expected.to have_many(:collections) }
    it { is_expected.to accept_nested_attributes_for(:collections_memberships) }
  end
end
