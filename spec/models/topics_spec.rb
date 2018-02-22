require 'rails_helper'

RSpec.describe 'topics' do

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
end
