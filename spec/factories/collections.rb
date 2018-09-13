# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    sequence :name do |n|
      "This is my collection number # #{"%.8d" % n}"
    end
    user
  end
end
