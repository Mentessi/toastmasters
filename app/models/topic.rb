class Topic < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :collections_topics
  has_many :collections, through: :collections_topics
end
