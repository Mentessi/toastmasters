require 'rails_helper'

RSpec.describe Collection, type: :model do
  describe 'associations' do
    it { should have_many(:collections_topics) }
    it { should have_many(:topics) }
  end
end
