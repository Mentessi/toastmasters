class Topic < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_and_belongs_to_many :collections
  has_many :collection_topic_memberships
end
