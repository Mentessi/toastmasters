require 'rails_helper'

RSpec.describe Topic, type: :model do

  context 'name' do
    it "is required" do
      topic = FactoryBot.build(:topic, name: '')
      expect(topic).to be_invalid
    end
  end

  context 'factory' do
    subject { FactoryBot.build(:topic) }
    it { is_expected.to be_valid }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:collections_topics) }
    it { should have_many(:collections) }
  end
end
