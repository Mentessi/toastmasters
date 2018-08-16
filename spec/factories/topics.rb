# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    sequence :name do |n|
      "This is my topic number # #{n}"
    end
    user
  end
end
