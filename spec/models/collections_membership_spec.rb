# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CollectionsMembership, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:collection) }
    it { is_expected.to belong_to(:topic) }
  end
end
