require 'rails_helper'

RSpec.describe CollectionsMembership, type: :model do

  describe 'associations' do
    it { should belong_to(:collection) }
    it { should belong_to(:topic) }
  end
end
