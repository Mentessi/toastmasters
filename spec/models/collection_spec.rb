# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe 'associations' do
    it { should have_many(:collections_memberships) }
    it { should have_many(:topics) }
    it { should belong_to(:user) }
    it { should accept_nested_attributes_for(:collections_memberships) }
  end

  describe 'valildations' do
    context 'name' do
      it 'is required' do
        collection = FactoryBot.build(:collection, name: '')
        expect(collection).to be_invalid
      end
    end

    context 'factory' do
      subject { FactoryBot.build(:collection) }

      it { is_expected.to be_valid }
    end
  end
end
