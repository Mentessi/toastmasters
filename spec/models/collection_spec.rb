# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:collections_memberships) }
    it { is_expected.to have_many(:topics) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to accept_nested_attributes_for(:collections_memberships) }
  end

  describe 'valildations' do
    describe 'name' do
      it 'is required' do
        collection = FactoryBot.build(:collection, name: '')
        expect(collection).to be_invalid
      end
    end

    describe 'factory' do
      subject { FactoryBot.build(:collection) }

      it { is_expected.to be_valid }
    end
  end
end
