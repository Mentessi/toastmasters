# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topic requests', type: :request do
  let!(:topic) { FactoryBot.create :topic }
  let(:user) { topic.user }

  describe 'get#show' do
    let(:dispatch_request) { get topic_path(topic) }

    it_behaves_like 'NOT only for logged in users'
    it_behaves_like 'NOT just for owners'
  end

  describe 'get#new' do
    let(:dispatch_request) { get new_topic_path }

    it_behaves_like 'only logged in users'
  end

  describe 'post#create' do
    let(:dispatch_request) { post topics_path, params: { topic: { name: 'here is a new topic' } } }

    it_behaves_like 'only logged in users'
  end

  describe 'get#edit' do
    let(:dispatch_request) { get edit_topic_path(topic) }

    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end

  describe 'put#update' do
    let(:dispatch_request) do
      put topic_path(topic), params: { topic: { name: 'ammended topic' } }
    end

    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end

  describe 'delete#destroy' do
    let(:dispatch_request) { delete topic_path(topic) }

    it_behaves_like 'only logged in users'
    it_behaves_like 'owners only'
  end
end
