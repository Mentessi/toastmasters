# frozen_string_literal: true

class Collection < ApplicationRecord
  has_many :collections_memberships
  has_many :topics, through: :collections_memberships
  belongs_to :user
  validates :name, presence: true
  accepts_nested_attributes_for :collections_memberships, allow_destroy: true
end
