# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Collection requests', type: :request do
  let(:collection) { FactoryBot.create :collection }
  let(:user) { collection.user }

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
    let(:dispatch_request) do
      post collections_path, params: { collection: { name: 'hello' } }
    end

    it_behaves_like 'only logged in users'
  end

  describe 'get#edit' do
    let(:dispatch_request) { get edit_collection_path(collection) }
    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end

  describe 'put#update' do
    let(:dispatch_request) do
      put collection_path(collection), params: { collection: { name: 'hello' } }
    end
    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end

  describe 'delete#destroy' do
    let(:dispatch_request) { delete collection_path(collection) }
    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end
end
