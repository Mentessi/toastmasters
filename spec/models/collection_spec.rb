require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe 'associations' do
    it { should have_many(:collections_topics) }
    it { should have_many(:topics) }
  end

  describe 'valildations' do
    context 'name' do
      it "is required" do
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
