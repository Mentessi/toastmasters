# frozen_string_literal: true
class Topic < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :collections_memberships
  has_many :collections, through: :collections_memberships
  accepts_nested_attributes_for :collections_memberships, allow_destroy: true
end
