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

  describe 'association' do
    it { should belong_to(:user) }
  end
end
