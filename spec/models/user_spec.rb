# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'when email missing' do
      subject { FactoryBot.build(:user, email: '') }

      it { is_expected.to be_invalid }
    end

    context 'when email is already taken' do
      before do
        FactoryBot.create(:user, email: 'hello@email.com')
      end
      subject { FactoryBot.build(:user, email: 'hello@email.com') }

      it { is_expected.to be_invalid }
    end

    context 'when username missing' do
      subject { FactoryBot.build(:user, username: '') }

      it { is_expected.to be_invalid }
    end

    context 'when username is already taken' do
      before do
        FactoryBot.create(:user, username: 'Dave')
      end
      subject { FactoryBot.build(:user, username: 'Dave') }

      it { is_expected.to be_invalid }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:topics) }
    it { is_expected.to have_many(:collections) }
  end
end
