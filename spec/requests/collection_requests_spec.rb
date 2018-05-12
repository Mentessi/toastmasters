require 'rails_helper'

RSpec.describe 'Collection requests', type: :request do
  let(:collection) { FactoryBot.create :collection }
  let(:user) { FactoryBot.create :user }

  describe 'get#show' do
    let(:dispatch_request) { get collection_path(collection) }
    it_behaves_like 'NOT only for logged in users'
  end

  describe 'get#index' do
    let(:dispatch_request) { get collections_path }
    it_behaves_like 'NOT only for logged in users'
  end

  describe 'get#new' do
    let(:dispatch_request) { get new_collection_path }
    it_behaves_like 'only logged in users'
  end

  describe 'post#create' do
    let(:dispatch_request) {
      post collections_path, params: { collection: {name: 'hello'} }
    }

    it_behaves_like 'only logged in users'
  end
end
